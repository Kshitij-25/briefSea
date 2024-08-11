import 'package:app_links/app_links.dart';
import 'package:briefsea/common/app_utils/device_type.dart';
import 'package:briefsea/main.dart';
import 'package:flutter/material.dart';

import 'common/others/routes.dart';
import 'presentation/screens/my_feed/feed_screen.dart';
import 'presentation/themes/theme.dart';
import 'presentation/themes/util.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();

    // Handle incoming links when the app is opened via a deep link
    _handleInitialUri();

    // Listen to incoming deep links
    _appLinks.uriLinkStream.listen((uri) {
      _handleIncomingLink(uri);
    });
  }

  Future<void> _handleInitialUri() async {
    try {
      final uri = await _appLinks.getInitialLink();
      if (uri != null) {
        _handleIncomingLink(uri);
      }
    } on Exception catch (e) {
      print('Failed to get initial link: $e');
    }
  }

  void _handleIncomingLink(Uri uri) {
    // Check if the path matches the pattern you're expecting
    final pathSegments = uri.pathSegments;

    if (pathSegments.length >= 3 && pathSegments[1] == 'discussion' && pathSegments[2] == 'thread') {
      // Extract the threadId from the path
      final threadId = pathSegments.last;

      // Navigate to the FeedScreen with the threadId
      Navigator.pushNamed(
        context,
        FeedScreen.routeName,
        arguments: {'briefId': threadId},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");

    MaterialTheme theme = MaterialTheme(textTheme);

    getDeviceType(context).log();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: theme.dark(),
      theme: theme.light(),
      routerConfig: AppRouter.router,
    );
  }
}
