import 'dart:convert';

import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/model/user_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/services.dart';

class AuthServices {
  static Future<Object> register(UserModel userModel) async {
    var url = Uri.parse("${MyGeneralConst.API_URL}/auth/register");
    return await GeneralServices.baseService(
      url: url,
      method: GeneralServicesMethod.POST,
      body: json.encode(userModel.toMap4API()),
    );
  }

  static Future<Object> login(UserModel userModel) async {
    var url = Uri.parse("${MyGeneralConst.API_URL}/auth/login");
    return await GeneralServices.baseService(
      url: url,
      method: GeneralServicesMethod.POST,
      body: json.encode(userModel.toMap4API()),
    );
  }

  static Future<Object> logout(String token) async {
    var url = Uri.parse("${MyGeneralConst.API_URL}/auth/logout");
    return await GeneralServices.baseService(
      url: url,
      method: GeneralServicesMethod.DELETE,
      headers: GeneralServices.addToken2Headers(token),
    );
  }
}
