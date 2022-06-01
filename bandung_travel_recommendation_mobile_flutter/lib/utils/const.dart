import 'package:flutter/material.dart';

class MyGeneralConst {
  static const _BASE_URL = "http://10.0.2.2:8000";
  static const API_URL = "${_BASE_URL}/api";
  static const API_IMAGE_URL = "${_BASE_URL}/img/destination";
  static const PREF_USER_KEY = "PREF_USER_KEY";
}

class MyColorsConst {
  static const whiteColor = Colors.white;
  static const lightDarkColor = Color.fromARGB(255, 219, 219, 219);
  static const semiDarkColor = Color.fromARGB(255, 77, 77, 77);
  static const darkColor = Color.fromARGB(255, 35, 35, 35);
  static const errorColor = Color.fromARGB(255, 255, 46, 46);

  static const primaryColor = Color.fromARGB(255, 46, 164, 255);
  static const primaryLightColor = Color.fromARGB(255, 107, 191, 255);
  static const primaryDarkColor = Color.fromARGB(255, 47, 46, 65);
}
