import 'package:flutter/material.dart';
import 'common/navigation_service.dart';
import 'locator.dart';
import 'ui/router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'ui/views/home_view.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      title: 'Flutter Demo',
      initialRoute: AppRoutes.homeRoute,
      onGenerateRoute: AppRouter.generateRoute,

      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomeView(),
    );
  }
}

