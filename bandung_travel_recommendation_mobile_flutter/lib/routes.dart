import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/view/sidebar.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/view/signin_or_signup_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/view/signin_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      // case LoginScreen.routeName:
      //   return MaterialPageRoute(builder: (context) {
      //     CustomProgressDialog.context = context;
      //     return LoginScreen();
      //   });
      case SignInOrSignUpScreen.routeName:
        return MaterialPageRoute(builder: (context) {
          return SignInOrSignUpScreen();
        });
      case SignInScreen.routeName:
        return MaterialPageRoute(builder: (context) {
          return SignInScreen();
        });
      // case Sidebar.routeName:
      //   return MaterialPageRoute(builder: (context) {
      //     return Sidebar();
      //   });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Route Error'),
        ),
        body: Center(
          child: Text('Route Error'),
        ),
      );
    });
  }
}
