import 'dart:developer';
import 'dart:math' hide log;

import 'package:app_settings/app_settings.dart';
import 'package:briefsea/data/di/get_it.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

import '../../common/app_utils/shared_prefs_helper.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';

class NotificationServices {
  final _dio = getItInstance<Dio>();
  final _apiClient = getItInstance<ApiClient>();

  // Instance of FirebaseMessaging to handle messaging functionalities
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  // Instance of FlutterLocalNotificationsPlugin to handle local notifications
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Requests the user's permission for notifications
  void requestNotificationPermission() async {
    NotificationSettings notificationSettings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    // Handle the different authorization statuses
    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Permission Granted");
    } else if (notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {
      print("Provisional Permission Granted");
    } else {
      // Open app settings if permission is denied
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      print("Permission Denied");
    }
  }

  // Retrieves the device token for Firebase Messaging
  Future<String?> getDeviceToken() async {
    return await firebaseMessaging.getToken();
  }

  // Listens for token refresh events and prints the new token
  void isTokenRefreshed() async {
    firebaseMessaging.onTokenRefresh.listen((newToken) async {
      await updateFcmToken(newToken);
    });
  }

  // Initializes local notifications settings
  void initLocalNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitialization = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialization = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
      android: androidInitialization,
      iOS: iosInitialization,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        handleMessage(context, message);
      },
    );
  }

  // Initializes Firebase messaging and sets up handlers for incoming messages
  void firebaseInit(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title);
      print(message.notification!.body);
      print(message.data);

      // Initialize local notifications if on Android
      // if (Platform.isAndroid) {
      initLocalNotifications(context, message);
      showNotification(message);
      // } else {
      //   showNotification(message);
      // }
    });
  }

  // Displays a notification with the given message details
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      "High Importance",
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      androidNotificationChannel.id,
      androidNotificationChannel.name,
      channelDescription: "High Importance",
      importance: Importance.high,
      priority: Priority.high,
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      presentBanner: true,
      sound: 'default',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }

  // Handles the received message and performs actions based on its content
  void handleMessage(BuildContext context, RemoteMessage message) async {
    if (message.data['id'] == 0) {
      // Perform specific action like navigating to a page
    }
  }

  // Sets up message interaction when the app is opened from a notification
  Future<void> setupInteractMessage(BuildContext context) async {
    // Handle the case when the app is terminated
    RemoteMessage? initialMessage = await firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    // Handle the case when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });
  }

  Future<String> getAccessToken() async {
    final privateKey = dotenv.env['PRIVATE_KEY'];
    final privateKeyId = dotenv.env['PRIVATE_KEY_ID'];
    final clientEmail = dotenv.env['Client_Email'];
    final clientId = dotenv.env['Client_ID'];
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "briefsea",
      "private_key_id": privateKeyId,
      "private_key": privateKey,
      "client_email": clientEmail,
      "client_id": clientId,
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-wnmhm%40briefsea.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    final credentials = client.credentials;

    log("${credentials.accessToken.data} ACCESS TOKEN");

    return credentials.accessToken.data;
  }

  void sendPushNotification({required String userToken, required String body, required String title}) async {
    final accessToken = await getAccessToken();

    final Map<String, dynamic> message = {
      "message": {
        "token": userToken,
        "notification": {
          "body": body,
          "title": title,
        }
      }
    };

    final response = await _dio.post(
      ApiConstants.sendPushNotification,
      data: message,
      options: Options(
        headers: {
          "Authorization": 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response == 200) {
      print("Push notification sent successfully");
    } else {
      print("Failed to send push notification");
    }
  }

  Future<void> updateFcmToken(String fcmToken) async {
    String? jwtToken = await SharedPreferencesHelper.getString('jwtToken');
    String? userId = await SharedPreferencesHelper.getString('user_id');

    if (jwtToken == null || userId == null) {
      return;
    }

    try {
      final body = {
        'fcmToken': fcmToken,
      };

      final response = await _apiClient.patchReq(
        url: "${ApiConstants.updateFcmToken}/$userId",
        body: body,
        jwtToken: jwtToken,
      );

      if (response?.statusCode == 200) {
        final responseJson = response?.data;
        log(responseJson.toString());
      } else {
        throw AppError(statusCode: response?.statusCode);
      }
    } catch (e) {
      log('updateFcmToken Error', error: e);
      throw AppError(errorMessage: e.toString());
    }
  }
}
