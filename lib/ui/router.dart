import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/ui/views/login_view.dart';
import 'views/home_view.dart';




class AppRoutes{
   static const String homeRoute ="home";
   static const String loginPageRoute = "login";
}


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeView());
      case AppRoutes.loginPageRoute:
        return MaterialPageRoute(builder: (_) => LoginView());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}