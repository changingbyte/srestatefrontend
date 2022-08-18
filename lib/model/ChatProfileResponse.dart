
import 'EstateListCommonResponse.dart';

class ChatProfileResponse {
  ChatProfileResponse({
      this.success, 
      this.error, 
      this.message, 
      this.data,});

  ChatProfileResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
    message = json['message'];
    data = json['data'] != null ? ChatProfileData.fromJson(json['data']) : null;
  }
  bool? success;
  List<dynamic>? error;
  String? message;
  ChatProfileData? data;

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

class ChatProfileData {
  ChatProfileData({
      this.id, 
      this.timestamp, 
      this.lastMessage, 
      this.absoluteUrl, 
      this.websocketUrl, 
      this.contact, 
      this.owner, 
      this.estateList,});

  ChatProfileData.fromJson(dynamic json) {
    id = json['id'];
    timestamp = json['timestamp'];
    lastMessage = json['last_message'] != null ? LastMessage.fromJson(json['last_message']) : null;
    absoluteUrl = json['absolute_url'];
    websocketUrl = json['websocket_url'];
    contact = json['contact'];
    owner = json['owner'];
    if (json['eststate_list'] != null) {
      estateList = [];
      json['eststate_list'].forEach((v) {
        estateList?.add(EstateList.fromJson(v));
      });
    }
  }
  int? id;
  int? timestamp;
  LastMessage? lastMessage;
  String? absoluteUrl;
  String? websocketUrl;
  String? contact;
  String? owner;
  List<EstateList>? estateList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['timestamp'] = timestamp;
    if (lastMessage != null) {
      map['last_message'] = lastMessage?.toJson();
    }
    map['absolute_url'] = absoluteUrl;
    map['websocket_url'] = websocketUrl;
    map['contact'] = contact;
    map['owner'] = owner;
    if (estateList != null) {
      map['eststate_list'] = estateList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



class LastMessage {
  LastMessage({
      this.id, 
      this.description, 
      this.receiverName, 
      this.seen,});

  LastMessage.fromJson(dynamic json) {
    id = json['id'];
    description = json['description'];
    receiverName = json['receiver_name'];
    seen = json['seen'];
  }
  int? id;
  String? description;
  String? receiverName;
  bool? seen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['description'] = description;
    map['receiver_name'] = receiverName;
    map['seen'] = seen;
    return map;
  }

}