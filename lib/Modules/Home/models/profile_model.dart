// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

class ProfileModel {
  String? id;
  String? username;
  DateTime? createdAt;
  String? phoneNumber;
  int? age;
  String? address;
  String? gender;
  String? profileImage;
  DateTime? updatedAt;
  String? email;

  ProfileModel({
    this.id,
    this.username,
    this.createdAt,
    this.phoneNumber,
    this.age,
    this.address,
    this.gender,
    this.profileImage,
    this.updatedAt,
    this.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    username: json["username"],
    createdAt: DateTime.parse(json["created_at"]),
    phoneNumber: json["phoneNumber"],
    age: json["age"],
    address: json["address"],
    gender: json["gender"],
    profileImage: json["profile_image"],
    updatedAt: DateTime.parse(json["updated_at"]),
    email: json["email"],
  );
}
