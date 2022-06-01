import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ServicesResponseSuccess {
  int code;
  Object response;
  ServicesResponseSuccess({
    required this.code,
    required this.response,
  });
}

class ServicesFailure {
  int code;
  Object errorResponse;
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
    Map<String, String> headers = _headers;
    headers['Authorization'] = 'Bearer ${token}';

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
        return ServicesResponseSuccess(
          code: 200,
          response: json.decode(response.body)['data'],
        );
      }
      return ServicesFailure(
        code: response.statusCode,
        errorResponse: json.decode(response.body)['errormsg'],
      );
    } on HttpException {
      return ServicesFailure(
          code: 101, errorResponse: "No Internet Connection");
    } on FormatException {
      return ServicesFailure(code: 102, errorResponse: "Invalid Format");
    } catch (e) {
      return ServicesFailure(code: 103, errorResponse: "Unknwon Error");
    }
  }
}
