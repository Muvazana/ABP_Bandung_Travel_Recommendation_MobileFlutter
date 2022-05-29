import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view/favorite_screen/add_schedule_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/add_schedule_view_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/profile_view_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/sidebar_view_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/routes.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SidebarViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => AddScheduleViewModel()),
      ],
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
        brightness: Brightness.light,
        primaryColor: MyColors.primaryColor,
      ),
      initialRoute: AddScheduleScreen.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
