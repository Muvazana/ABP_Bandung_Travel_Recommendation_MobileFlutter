import 'dart:convert';

class UserModel {
  String? email;
  String? name;
  String? role;
  String? password;
  String? token;

  UserModel({
    this.email,
    this.name,
    this.role,
    this.password,
    this.token,
  });

  UserModel copyWith({
    String? name,
    String? password,
  }) {
    return UserModel(
      email: this.email,
      name: name ?? this.name,
      role: this.role,
      password: password ?? this.password,
      token: this.token,
    );
  }

  factory UserModel.fromMapApi(Map<String, dynamic> dataJson) {
    var user = json.decode(dataJson["user"]);
    return UserModel(
      email: user["email"],
      name: user["name"],
      role: user["role"],
      token: dataJson["token"],
    );
  }
  factory UserModel.fromMapPref(Map<String, dynamic> dataJson) => UserModel(
        email: dataJson["email"],
        name: dataJson["name"],
        role: dataJson["role"],
        token: dataJson["token"],
      );

  Map<String, dynamic> toMap4Pref() => {
        "email": this.email,
        "name": this.name,
        "role": this.role,
        "token": this.token,
      };
  Map<String, dynamic> toMap4API() => {
        "inputEmail": this.email,
        "inputName": this.name,
        "inputPassword": this.role,
      };
  // Map<String, dynamic> toMap4EditAPI() => {
  //       "inputName": this.name,
  //       "inputPassword": this.role,
  //     };
  // Map<String, dynamic> toMap4RegisterAPI() => {
  //       "inputEmail": this.email,
  //       "inputName": this.name,
  //       "inputPassword": this.role,
  //     };
  // Map<String, dynamic> toMap4LoginAPI() => {
  //       "inputEmail": this.email,
  //       "inputPassword": this.role,
  //     };
}
