import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/signin_or_signup_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/signin_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/signup_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view/layout/sidebar_layout.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/sidebar_view_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/routes.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SidebarViewModel())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bandung Travel Recommendation',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.dark,
        primaryColor: MyColors.primaryColor,
      ),
      initialRoute: SidebarLayout.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
