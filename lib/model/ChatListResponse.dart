class ChatListResponse {
  ChatListResponse({
      this.success, 
      this.error, 
      this.message, 
      this.data,});

  ChatListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ChatListData.fromJson(v));
      });
    }
  }
  bool? success;
  List<dynamic>? error;
  String? message;
  List<ChatListData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (error != null) {
      map['error'] = error?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ChatListData {
  ChatListData({
      this.id, 
      this.timestamp, 
      this.sent, 
      this.description, 
      this.senderName, 
      this.receiverName, 
      this.seen,});

  ChatListData.fromJson(dynamic json) {
    id = json['id'];
    timestamp = json['timestamp'];
    sent = json['sent'];
    description = json['description'];
    senderName = json['sender_name'];
    receiverName = json['receiver_name'];
    seen = json['seen'];
  }
  int? id;
  int? timestamp;
  bool? sent;
  String? description;
  String? senderName;
  String? receiverName;
  bool? seen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['timestamp'] = timestamp;
    map['sent'] = sent;
    map['description'] = description;
    map['sender_name'] = senderName;
    map['receiver_name'] = receiverName;
    map['seen'] = seen;
    return map;
  }

}