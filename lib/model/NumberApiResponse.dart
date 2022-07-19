// To parse this JSON data, do
//
//     final numberApiResponse = numberApiResponseFromJson(jsonString);

import 'dart:convert';

NumberApiResponse numberApiResponseFromJson(String str) => NumberApiResponse.fromJson(json.decode(str));

String numberApiResponseToJson(NumberApiResponse data) => json.encode(data.toJson());

class NumberApiResponse {
  NumberApiResponse({
    this.mobile,
    this.authToken,
    this.otp,
  });

  String? mobile;
  String? authToken;
  String? otp;

  factory NumberApiResponse.fromJson(Map<String, dynamic> json) => NumberApiResponse(
    mobile: json["mobile"] == null ? null : json["mobile"],
    authToken: json["auth_token"] == null ? null : json["auth_token"],
    otp: json["otp"] == null ? null : json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile == null ? null : mobile,
    "auth_token": authToken == null ? null : authToken,
    "otp": otp == null ? null : otp,
  };
}
