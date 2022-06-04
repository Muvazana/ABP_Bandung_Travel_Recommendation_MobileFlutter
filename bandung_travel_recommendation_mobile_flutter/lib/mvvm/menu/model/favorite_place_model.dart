import 'dart:convert';
import 'dart:math';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/place_model.dart';

class FavoritePlaceModel {
  FavoritePlaceModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.places,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  List<PlaceModel> places;

  factory FavoritePlaceModel.fromMap(Map<String, dynamic> json) =>
      FavoritePlaceModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        places: PlaceModel.placesFromMap(json["places"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "places": PlaceModel.placesToMap(places),
      };

  static List<FavoritePlaceModel> dataDummyList({int count = 5}) =>
      List.generate(
        count,
        (index) => FavoritePlaceModel(
          id: index,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          places: PlaceModel.dataDummyList(count: count * 5)
              .getRange(index, index + Random(index).nextInt(5) + 5)
              .toList(),
        ),
      );

  static List<FavoritePlaceModel> favoritePlaceFromMap(List<dynamic> str) =>
      List<FavoritePlaceModel>.from(
          str.map((x) => FavoritePlaceModel.fromMap(x)));

  static String favoritePlaceToMap(List<FavoritePlaceModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
