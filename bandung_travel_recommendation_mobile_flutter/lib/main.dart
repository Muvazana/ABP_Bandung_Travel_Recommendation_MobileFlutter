import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/view/sidebar.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/view/signin_or_signup_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/view/signin_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bandung Travel Recommendation',
      theme: ThemeData(
        // primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.dark
      ),
      initialRoute: SignInScreen.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}