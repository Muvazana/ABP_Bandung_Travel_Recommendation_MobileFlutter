import 'dart:convert';

import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/model/user_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/favorite_place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/services.dart';

class UserServices {
  static Future<Object> getInformation(String token) async {
    var url = Uri.parse("${MyGeneralConst.API_URL}/user/get-information");
    return await GeneralServices.baseService(
      url: url,
      method: GeneralServicesMethod.GET,
      headers: GeneralServices.addToken2Headers(token),
    );
  }

  static Future<Object> edit(UserModel userModel) async {
    var url = Uri.parse("${MyGeneralConst.API_URL}/user/edit");
    return await GeneralServices.baseService(
      url: url,
      method: GeneralServicesMethod.POST,
      headers: GeneralServices.addToken2Headers(userModel.token!),
      body: json.encode(userModel.toMap4API()),
    );
  }

  // Dealing with Favorite Place
  //
  //

  static Future<Object> addFavoritePlace({
    required String token,
    required List<PlaceModel> places,
  }) async {
    var url = Uri.parse("${MyGeneralConst.API_URL}/user/favorite-place/add");
    var data = {
      'place_ids': places.map((e) => e.id).join(','),
    };
    return await GeneralServices.baseService(
      url: url,
      method: GeneralServicesMethod.POST,
      headers: GeneralServices.addToken2Headers(token),
      body: json.encode(data),
    );
  }

  static Future<Object> deleteFavoritePlace({
    required String token,
    required FavoritePlaceModel favoritePlace,
  }) async {
    var url = Uri.parse(
        "${MyGeneralConst.API_URL}/user/favorite-place/delete/${favoritePlace.id}");
    return await GeneralServices.baseService(
      url: url,
      method: GeneralServicesMethod.DELETE,
      headers: GeneralServices.addToken2Headers(token),
    );
  }

  static Future<Object> getFavoritePlaces(String token) async {
    var url =
        Uri.parse("${MyGeneralConst.API_URL}/user/favorite-place/get-all");
    return await GeneralServices.baseService(
      url: url,
      method: GeneralServicesMethod.GET,
      headers: GeneralServices.addToken2Headers(token),
    );
  }

  
  static Future<Object> touchPlace({
    required String token,
    required PlaceModel place,
  }) async {
    var url = Uri.parse(
        "${MyGeneralConst.API_URL}/user/touch-place/${place.id}");
    return await GeneralServices.baseService(
      url: url,
      method: GeneralServicesMethod.GET,
      headers: GeneralServices.addToken2Headers(token),
    );
  }
}
