import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/services.dart';

class DestServices {
  static Future<Object> getDestinations(String token) async {
    var url = Uri.parse("${MyGeneralConst.API_URL}/place/get-destinations");
    return await GeneralServices.baseService(
      url: url,
      method: GeneralServicesMethod.GET,
    );
  }

  static Future<Object> getHotels(String token) async {
    var url = Uri.parse("${MyGeneralConst.API_URL}/place/get-hotels");
    return await GeneralServices.baseService(
      url: url,
      method: GeneralServicesMethod.GET,
    );
  }

  static Future<Object> getPlaceById({
    required String token,
    required PlaceModel place,
  }) async {
    var url = Uri.parse(
        "${MyGeneralConst.API_URL}/place/${place.id}");
    return await GeneralServices.baseService(
      url: url,
      method: GeneralServicesMethod.GET,
      headers: GeneralServices.addToken2Headers(token),
    );
  }
}
