// To parse this JSON data, do
//
//     final chatReminderResponse = chatReminderResponseFromJson(jsonString);

import 'dart:convert';

ChatReminderResponse chatReminderResponseFromJson(String str) => ChatReminderResponse.fromJson(json.decode(str));

String chatReminderResponseToJson(ChatReminderResponse data) => json.encode(data.toJson());

class ChatReminderResponse {
  ChatReminderResponse({
    this.success,
    this.error,
    this.message,
    this.data,
  });

  bool? success;
  List<dynamic>? error;
  String? message;
  ChatReminderData? data;

  factory ChatReminderResponse.fromJson(Map<String, dynamic> json) => ChatReminderResponse(
    success: json["success"] == null ? null : json["success"],
    error: json["error"] == null ? null : List<dynamic>.from(json["error"].map((x) => x)),
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : ChatReminderData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "error": error == null ? null : List<dynamic>.from(error!.map((x) => x)),
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class ChatReminderData {
  ChatReminderData({
    this.time,
    this.description,
  });

  String? time;
  String? description;

  factory ChatReminderData.fromJson(Map<String, dynamic> json) => ChatReminderData(
    time: json["time"] == null ? null : json["time"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "time": time == null ? null : time,
    "description": description == null ? null : description,
  };
}
