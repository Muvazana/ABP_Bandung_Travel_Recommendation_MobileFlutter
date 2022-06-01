// To parse this JSON data, do
//
//     final place = placeFromMap(jsonString);

import 'dart:convert';

List<PlaceModel> placesFromMap(String str) =>
    List<PlaceModel>.from(json.decode(str).map((x) => PlaceModel.fromMap(x)));

String placesToMap(List<PlaceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PlaceModel {
  PlaceModel({
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
  PlaceTypeModel placeType;

  factory PlaceModel.fromMap(Map<String, dynamic> json) => PlaceModel(
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
        placeType: PlaceTypeModel.fromMap(json["place_type"]),
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

  static List<PlaceModel> dataDummyList({int count = 20}) => List.generate(
        count,
        (index) => PlaceModel(
          id: index,
          name: "Place Name $index",
          typePlaceId: 0,
          rate: 0,
          description:
              "Place $index Description with Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          imageName:
              "https://media.gettyimages.com/photos/dome-mosque-in-makassar-sulawesi-indonesia-picture-id1221460539?s=612x612",
          alamat: "",
          latitude: "",
          longitude: "",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          view: index * 2 + index,
          placeType: PlaceTypeModel.dataDummy(),
        ),
      );

  factory PlaceModel.dataDummy() => PlaceModel(
        id: 0,
        name: "Place Title",
        typePlaceId: 1,
        rate: 0.5,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        imageName:
            "https://media.gettyimages.com/photos/dome-mosque-in-makassar-sulawesi-indonesia-picture-id1221460539?s=612x612",
        alamat: " ini adalah alamat",
        latitude: "",
        longitude: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        view: 25,
        placeType: PlaceTypeModel.dataDummy(),
      );
}

class PlaceTypeModel {
  PlaceTypeModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory PlaceTypeModel.fromMap(Map<String, dynamic> json) => PlaceTypeModel(
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

  factory PlaceTypeModel.dataDummy() => PlaceTypeModel(
        id: 0,
        name: "Place Type Dummy",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}
