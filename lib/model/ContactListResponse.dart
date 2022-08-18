class ContactListResponse {
  ContactListResponse({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  ContactListResponse.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Results {
  Results({
      this.id, 
      this.timestamp, 
      this.lastMessage, 
      this.contact, 
      this.owner, 
      this.websocketUrl,
      this.unseen,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    timestamp = json['timestamp'];
    lastMessage = json['last_message'] != null ? LastMessage.fromJson(json['last_message']) : null;
    contact = json['contact'];
    owner = json['owner'];
    websocketUrl = json['websocket_url'];
    unseen = json['unseen'];
    
  }
  int? id;
  int? timestamp;
  LastMessage? lastMessage;
  String? contact;
  String? owner;
  String? websocketUrl;
  int? unseen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['timestamp'] = timestamp;
    if (lastMessage != null) {
      map['last_message'] = lastMessage?.toJson();
    }
    map['contact'] = contact;
    map['owner'] = owner;
    map['websocket_url'] = websocketUrl;
    map['unseen'] = unseen;
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