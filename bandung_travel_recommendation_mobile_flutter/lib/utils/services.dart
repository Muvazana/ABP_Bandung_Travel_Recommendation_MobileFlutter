import 'dart:convert';
import 'dart:io';

import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:http/http.dart' as http;

class ServicesSuccess {
  int code;
  dynamic response;
  ServicesSuccess({
    required this.code,
    required this.response,
  });
}

class ServicesFailure {
  int code;
  dynamic errorResponse;
  ServicesFailure({
    required this.code,
    required this.errorResponse,
  });
}

enum GeneralServicesMethod { GET, POST, DELETE }

class GeneralServices {
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static Map<String, String> addToken2Headers(String token) {
    Map<String, String> headers = new Map<String, String>.from(_headers)
      ..addAll({'Authorization': "Bearer ${token}"});

    return headers;
  }

  static Future<Object> baseService({
    required Uri url,
    required GeneralServicesMethod method,
    Map<String, String>? headers = _headers,
    Object? body,
  }) async {
    try {
      var response;
      if (method == GeneralServicesMethod.POST) {
        response = await http.post(
          url,
          headers: headers,
          body: body,
        );
      } else if (method == GeneralServicesMethod.GET) {
        response = await http.get(
          url,
          headers: headers,
        );
      } else {
        response = await http.delete(
          url,
          headers: headers,
        );
      }
      if (response.statusCode == 200) {
        return ServicesSuccess(
          code: response.statusCode,
          response: json.decode(response.body)['data'],
        );
      }
      return ServicesFailure(
        code: response.statusCode,
        errorResponse: json.decode(response.body)['errormsg'].toString(),
      );
    } on HttpException {
      return ServicesFailure(
          code: MyGeneralConst.CODE_NO_INTERNET_CONECCTION,
          errorResponse: "No Internet Connection");
    } on FormatException {
      return ServicesFailure(
          code: MyGeneralConst.CODE_INVALID_FORMAT,
          errorResponse: "Invalid Format");
    } catch (e) {
      return ServicesFailure(
          code: MyGeneralConst.CODE_UNKWON_ERROR,
          errorResponse: "Unknwon Error");
    }
  }
}
