import 'dart:convert';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/place_model.dart';

List<FavoritePlace> favoritePlaceFromMap(String str) =>
    List<FavoritePlace>.from(
        json.decode(str).map((x) => FavoritePlace.fromMap(x)));

String favoritePlaceToMap(List<FavoritePlace> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class FavoritePlace {
  FavoritePlace({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.places,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  List<Place> places;

  factory FavoritePlace.fromMap(Map<String, dynamic> json) => FavoritePlace(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        places: placesFromMap(json["places"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "places": placesToMap(places),
      };

  static List<FavoritePlace> dataDummyList({int count = 5}) => List.generate(
        count,
        (index) => FavoritePlace(
          id: index,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          places: Place.dataDummyList(count: count * 5)
              .getRange(index , index + 5)
              .toList(),
        ),
      );
}
