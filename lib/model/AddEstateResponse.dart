// To parse this JSON data, do
//
//     final addEstateResponse = addEstateResponseFromJson(jsonString);

import 'dart:convert';

AddEstateResponse addEstateResponseFromJson(String str) => AddEstateResponse.fromJson(json.decode(str));

String addEstateResponseToJson(AddEstateResponse data) => json.encode(data.toJson());

class AddEstateResponse {
  AddEstateResponse({
    this.success,
    this.error,
    this.message,
    this.data,
  });

  bool? success;
  List<dynamic>? error;
  String? message;
  List<dynamic>? data;

  factory AddEstateResponse.fromJson(Map<String, dynamic> json) => AddEstateResponse(
    success: json["success"] == null ? null : json["success"],
    error: json["error"] == null ? null : List<dynamic>.from(json["error"].map((x) => x)),
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "error": error == null ? null : List<dynamic>.from(error!.map((x) => x)),
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
  };
}
