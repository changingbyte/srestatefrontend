// To parse this JSON data, do
//
//     final createEstateResponse = createEstateResponseFromJson(jsonString);

import 'dart:convert';

CreateEstateResponse createEstateResponseFromJson(String str) => CreateEstateResponse.fromJson(json.decode(str));

String createEstateResponseToJson(CreateEstateResponse data) => json.encode(data.toJson());

class CreateEstateResponse {
  CreateEstateResponse({
    this.success,
    this.error,
    this.message,
    this.data,
  });

  bool? success;
  List<dynamic>? error;
  String? message;
  List<dynamic>? data;

  factory CreateEstateResponse.fromJson(Map<String, dynamic> json) => CreateEstateResponse(
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
