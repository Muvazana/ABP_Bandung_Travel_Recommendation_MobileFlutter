import 'package:bandung_travel_recommendation_mobile_flutter/componens/loading_cutom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/signin_or_signup_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/signin_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/signup_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view/favorite_screen/add_schedule_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view/layout/sidebar_layout.dart';
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
      case SignUpScreen.routeName:
        return MaterialPageRoute(builder: (context) {
          return SignUpScreen();
        });
      case SidebarLayout.routeName:
        return MaterialPageRoute(builder: (context) {
          return SidebarLayout();
        });
      case AddScheduleScreen.routeName:
        return MaterialPageRoute(builder: (context) {
          return AddScheduleScreen();
        });
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
