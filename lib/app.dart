import 'package:briefsea/common/app_utils/device_type.dart';
import 'package:briefsea/main.dart';
import 'package:flutter/material.dart';

import 'common/others/routes.dart';
import 'presentation/themes/theme.dart';
import 'presentation/themes/util.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final brightness = View.of(context).platformDispatcher.platformBrightness;
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
