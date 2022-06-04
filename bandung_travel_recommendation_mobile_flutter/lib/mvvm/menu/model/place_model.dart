// To parse this JSON data, do
//
//     final place = placeFromMap(jsonString);

import 'dart:convert';

class PlaceModel {
  PlaceModel({
    this.id,
    this.name,
    this.typePlaceId,
    this.rate,
    this.description,
    this.imageName,
    this.alamat,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.view,
    this.placeType,
  });

  int? id;
  String? name;
  int? typePlaceId;
  double? rate;
  String? description;
  String? imageName;
  String? alamat;
  String? latitude;
  String? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? view;
  PlaceTypeModel? placeType;

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
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]).toLocal() : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]).toLocal() : null,
        view: json["view"],
        placeType: json["place_types"] != null
            ? PlaceTypeModel.fromMap(json["place_types"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "name": this.name,
        "type_place_id": this.typePlaceId,
        "rate": this.rate,
        "description": this.description,
        "image_name": this.imageName,
        "alamat": this.alamat,
        "latitude": this.latitude,
        "longitude": this.longitude,
        "created_at": this.createdAt?.toIso8601String() ?? '',
        "updated_at": this.updatedAt?.toIso8601String() ?? '',
        "view": this.view,
        "place_types": this.placeType?.toMap() ?? '',
      };

  static List<PlaceModel> placesFromMap(List<dynamic> str) =>
      List<PlaceModel>.from(str.map((x) => PlaceModel.fromMap(x)));

  static String placesToMap(List<PlaceModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

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
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PlaceTypeModel.fromMap(Map<String, dynamic> json) => PlaceTypeModel(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]).toLocal() : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]).toLocal() : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String() ?? '',
        "updated_at": updatedAt?.toIso8601String() ?? '',
      };

  factory PlaceTypeModel.dataDummy() => PlaceTypeModel(
        id: 0,
        name: "Place Type Dummy",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}
