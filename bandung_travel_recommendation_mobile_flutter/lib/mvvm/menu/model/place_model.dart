// To parse this JSON data, do
//
//     final place = placeFromMap(jsonString);

import 'dart:convert';

List<Place> placesFromMap(String str) =>
    List<Place>.from(json.decode(str).map((x) => Place.fromMap(x)));

String placesToMap(List<Place> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Place {
  Place({
    required this.id,
    required this.name,
    required this.typePlaceId,
    required this.rate,
    required this.description,
    required this.imageName,
    required this.alamat,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.view,
    required this.placeType,
  });

  int id;
  String name;
  int typePlaceId;
  double rate;
  String description;
  String imageName;
  String alamat;
  String latitude;
  String longitude;
  DateTime createdAt;
  DateTime updatedAt;
  int view;
  PlaceType placeType;

  factory Place.fromMap(Map<String, dynamic> json) => Place(
        id: json["id"],
        name: json["name"],
        typePlaceId: json["type_place_id"],
        rate: json["rate"].toDouble(),
        description: json["description"],
        imageName: json["image_name"],
        alamat: json["alamat"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        view: json["view"],
        placeType: PlaceType.fromMap(json["place_type"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type_place_id": typePlaceId,
        "rate": rate,
        "description": description,
        "image_name": imageName,
        "alamat": alamat,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "view": view,
        "place_type": placeType.toMap(),
      };

  static List<Place> dataDummyList({int count = 20}) => List.generate(
    count,
    (index) => Place(
      id: index,
      name: "Place $index",
      typePlaceId: 0,
      rate: 0,
      description: "Place $index Description",
      imageName: "museum.jpg",
      alamat: "",
      latitude: "",
      longitude: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      view: index * 2 + index,
      placeType: PlaceType.dataDummy(),
    ),
  );
}

class PlaceType {
  PlaceType({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory PlaceType.fromMap(Map<String, dynamic> json) => PlaceType(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  factory PlaceType.dataDummy() => PlaceType(
        id: 0,
        name: "Place Type Dummy",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}
