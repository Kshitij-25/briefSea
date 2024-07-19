import 'package:briefsea/common/app_utils/device_type.dart';
import 'package:briefsea/main.dart';
import 'package:flutter/material.dart';

import 'common/others/routes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    getDeviceType(context).log();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      routerConfig: AppRouter.router,
    );
  }
}
