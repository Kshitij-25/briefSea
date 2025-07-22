import 'dart:async';
import 'dart:developer' as devtools show log;
import 'dart:io';

import 'package:briefsea/data/models/contacts_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/data/di/get_it.dart' as getIt;
import 'app.dart';
import 'data/services/notification_service.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title);
  print(message.notification!.body);
}

SharedPreferences? prefs;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  unawaited(
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  );

  unawaited(getIt.init());

  prefs = await SharedPreferences.getInstance();

  await dotenv.load();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  // set observer
  FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final isLogin = prefs!.getBool('isLogin') ?? false;

  if (isLogin == true) {
    NotificationServices notificationServices = NotificationServices();

    notificationServices.isTokenRefreshed();
  }

  await Hive.initFlutter();
  Hive.registerAdapter(ContactsModelAdapter()); // Register the adapter
  await Hive.openBox('contactsBox'); // Open Hive box

  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }

  runApp(const ProviderScope(child: MainApp()));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
