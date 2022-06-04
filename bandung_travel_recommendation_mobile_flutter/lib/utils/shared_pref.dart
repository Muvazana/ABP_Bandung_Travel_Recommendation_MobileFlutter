import 'dart:convert';

import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/model/user_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralSharedPreferences {
  static Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  static Future<Object> saveUserData(UserModel user) async {
    var pref = await _pref;
    return await pref
        .setString(
          MyGeneralConst.PREF_USER_KEY,
          json.encode(
            user.toMap4Pref(),
          ),
        )
        .then(
          (value) => ServicesSuccess(
            code: MyGeneralConst.CODE_PROCESS_SUCCESS,
            response: "Save user data success!",
          ),
          onError: (error) => ServicesFailure(
            code: MyGeneralConst.CODE_UNKWON_ERROR,
            errorResponse: "Unknwon Error!",
          ),
        );
  }

  static Future<Object> getUserData() async {
    var pref = await _pref;
    var data = pref.getString(MyGeneralConst.PREF_USER_KEY);
    if (data != null)
      return ServicesSuccess(
        code: MyGeneralConst.CODE_PROCESS_SUCCESS,
        response: json.decode(data),
      );
    return ServicesFailure(
      code: MyGeneralConst.CODE_NULL_RESPONSE,
      errorResponse: "User not found!",
    );
  }

  static Future<Object> removeUserData() async {
    var pref = await _pref;
    var data = await pref.remove(MyGeneralConst.PREF_USER_KEY);
    if (data)
      return ServicesSuccess(
        code: MyGeneralConst.CODE_PROCESS_SUCCESS,
        response: "Remove User successfuly!",
      );
    else
      return ServicesFailure(
        code: MyGeneralConst.CODE_NULL_RESPONSE,
        errorResponse: "Remove User Failed!",
      );
  }
}
