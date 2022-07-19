// To parse this JSON data, do
//
//     final sendMessageResponse = sendMessageResponseFromJson(jsonString);

import 'dart:convert';

SendMessageResponse sendMessageResponseFromJson(String str) => SendMessageResponse.fromJson(json.decode(str));

String sendMessageResponseToJson(SendMessageResponse data) => json.encode(data.toJson());

class SendMessageResponse {
  SendMessageResponse({
    this.success,
    this.error,
    this.message,
    this.data,
  });

  bool? success;
  List<dynamic>? error;
  String? message;
  SendSmsData? data;

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) => SendMessageResponse(
    success: json["success"] == null ? null : json["success"],
    error: json["error"] == null ? null : List<dynamic>.from(json["error"].map((x) => x)),
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : SendSmsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "error": error == null ? null : List<dynamic>.from(error!.map((x) => x)),
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class SendSmsData {
  SendSmsData({
    this.success,
    this.error,
    this.sms,
    this.whatsapp,
  });

  bool? success;
  String? error;
  Sms? sms;
  Sms? whatsapp;

  factory SendSmsData.fromJson(Map<String, dynamic> json) => SendSmsData(
    success: json["success"] == null ? null : json["success"],
    error: json["error"] == null ? null : json["error"],
    sms: json["sms"] == null ? null : Sms.fromJson(json["sms"]),
    whatsapp: json["whatsapp"] == null ? null : Sms.fromJson(json["whatsapp"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "error": error == null ? null : error,
    "sms": sms == null ? null : sms!.toJson(),
    "whatsapp": whatsapp == null ? null : whatsapp!.toJson(),
  };
}

class Sms {
  Sms({
    this.success,
    this.msg,
  });

  bool? success;
  String? msg;

  factory Sms.fromJson(Map<String, dynamic> json) => Sms(
    success: json["success"] == null ? null : json["success"],
    msg: json["msg"] == null ? null : json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "msg": msg == null ? null : msg,
  };
}
