
class ContactListResponse {
  int? count;
  var next;
  var previous;
  List<Results>? results;

  ContactListResponse({this.count, this.next, this.previous, this.results});

  ContactListResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  int? timestamp;
  LastMessage? lastMessage;
  String? absoluteUrl;
  String? websocketUrl;
  String? contact;
  String? owner;
  String? eststateList;
  int? unseen;

  Results(
      {this.id,
        this.timestamp,
        this.lastMessage,
        this.absoluteUrl,
        this.websocketUrl,
        this.contact,
        this.owner,
        this.eststateList,
        this.unseen,});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timestamp = json['timestamp'];
    lastMessage = json['last_message'] != null
        ? new LastMessage.fromJson(json['last_message'])
        : null;
    absoluteUrl = json['absolute_url'];
    websocketUrl = json['websocket_url'];
    contact = json['contact'];
    owner = json['owner'];
    eststateList = json['eststate_list'];
    unseen  = json['unseen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['timestamp'] = this.timestamp;
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage!.toJson();
    }
    data['absolute_url'] = this.absoluteUrl;
    data['websocket_url'] = this.websocketUrl;
    data['contact'] = this.contact;
    data['owner'] = this.owner;
    data['eststate_list'] = this.eststateList;
    data['unseen'] = unseen;
    return data;
  }
}

class LastMessage {
  int? id;
  String? description;
  String? receiverName;
  bool? seen;

  LastMessage({this.id, this.description, this.receiverName, this.seen});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    receiverName = json['receiver_name'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['receiver_name'] = this.receiverName;
    data['seen'] = this.seen;
    return data;
  }
}