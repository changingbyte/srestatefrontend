class ReminderResponse {
  ReminderResponse  ({
      this.success, 
      this.error, 
      this.message, 
      this.data,});

  ReminderResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  List<dynamic>? error;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (error != null) {
      map['error'] = error?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.time, 
      this.description,});

  Data.fromJson(dynamic json) {
    time = json['time'];
    description = json['description'];
  }
  String? time;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['description'] = description;
    return map;
  }

}