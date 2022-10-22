// To parse this JSON data, do
//
//     final numberApiResponse = numberApiResponseFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

NumberApiResponse numberApiResponseFromJson(String str) => NumberApiResponse.fromJson(json.decode(str));

String numberApiResponseToJson(NumberApiResponse data) => json.encode(data.toJson());

class NumberApiResponse {
  NumberApiResponse({
    this.mobile,
    this.authToken,
    this.otp,
    this.name,
    this.isPremium,
    this.isProfileCompleted,
  });

  String? mobile;
  String? authToken;
  String? otp;
  String? name;
  bool? isPremium;
  bool? isProfileCompleted;

  factory NumberApiResponse.fromJson(Map<String, dynamic> json) => NumberApiResponse(
    mobile: json["mobile"] == null ? null : json["mobile"],
    authToken: json["auth_token"] == null ? null : json["auth_token"],
    otp: json["otp"] == null ? null : json["otp"],
    name: json["name"] == null ? null : json["name"],
    isPremium: json["is_premium"] == null ? false : json["is_premium"],
    isProfileCompleted: json["is_profile_completed"] == null ? false : json["is_profile_completed"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile == null ? null : mobile,
    "auth_token": authToken == null ? null : authToken,
    "otp": otp == null ? null : otp,
    "name": name == null ? "User" : name,
    "is_premium": isPremium == null ? false : isPremium,
    "is_profile_completed": isProfileCompleted == null ? false : isProfileCompleted,
  };
}
