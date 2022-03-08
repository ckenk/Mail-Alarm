import 'package:flutter/material.dart';
import 'package:gmail_alarm/home_screen.dart';
import 'package:gmail_alarm/login_screen.dart';
import 'package:gmail_alarm/settings_screen.dart';

import '../gmail_label_screen.dart';

class Routes {
  static const String USER_LOGIN = "LOGIN";
  static const String HOME = "HOME";
  static const String LABELS = "LABELS";
  static const String SETTINGS = "SETTINGS";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      // case RouteName.USER_LOGIN:
      case USER_LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      // case RouteName.HOME:
      case HOME:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case LABELS:
        return MaterialPageRoute(builder: (_) => GmailLabelScreen());
      case SETTINGS:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${settings.name} does not exists!",
                    style: TextStyle(fontSize: 24.0),
                  )
                ],
              ),
            ),
          ),
        );
    }
  }
}
