import 'package:flutter/material.dart';

import 'common/others/routes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      routerConfig: AppRouter.router,
    );
  }
}
