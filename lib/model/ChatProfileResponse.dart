class BrokerProfileResponse {
  BrokerProfileResponse({
      this.success, 
      this.error, 
      this.message, 
      this.data,});

  BrokerProfileResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
    message = json['message'];
    data = json['data'] != null ? BrokerProfileData.fromJson(json['data']) : null;
  }
  bool? success;
  List<dynamic>? error;
  String? message;
  BrokerProfileData? data;

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

class BrokerProfileData {
  BrokerProfileData({
      this.name, 
      this.mobile, 
      this.balance, 
      this.contacts, 
      this.estates, 
      this.area, 
      this.estate_type,});

  String? name;
  String? mobile;
  int? balance;
  int? contacts;
  int? estates;
  List<String>? area;
  List<String>? estate_type;


  factory BrokerProfileDataResponse.fromJson(Map<String, dynamic> json) => BrokerProfileDataResponse(
    name: json["name"] == null ? null : json["name"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    balance: json["balance"] == null ? null : json["balance"],
    contacts: json["contacts"] == null ? null : json["contacts"],
    estates: json["estates"] == null ? null : json["estates"],
    area: json["area"] == null ? null : List<String>.from(json["area"].map((x) => x)),
    estate_type: json["estate_type"] == null ? null : List<String>.from(json["estate_type"].map((x) => x)),
  );
  

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    
    map['name'] = name;
    map['mobile'] = mobile;
    map['balance'] = balance;
    map['contacts'] = contacts;
    map['estates'] = estates;
    map['area'] = area;
    map['estate_type'] = estate_type;
    return map;
  }

}

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
      this.eststateList,});

  ChatProfileData.fromJson(dynamic json) {
    id = json['id'];
    timestamp = json['timestamp'];
    lastMessage = json['last_message'] != null ? LastMessage.fromJson(json['last_message']) : null;
    absoluteUrl = json['absolute_url'];
    websocketUrl = json['websocket_url'];
    contact = json['contact'];
    owner = json['owner'];
    if (json['eststate_list'] != null) {
      eststateList = [];
      json['eststate_list'].forEach((v) {
        eststateList?.add(EststateList.fromJson(v));
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
  List<EststateList>? eststateList;

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
    if (eststateList != null) {
      map['eststate_list'] = eststateList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class EststateList {
  EststateList({
      this.id, 
      this.estateName, 
      this.city, 
      this.estateType, 
      this.furniture, 
      this.floorSpace, 
      this.numberOfBalconies, 
      this.numberOfBedrooms, 
      this.numberOfBathrooms, 
      this.numberOfGarages, 
      this.numberOfParkingSpaces, 
      this.petsAllowed, 
      this.estateDescription, 
      this.estateStatus, 
      this.isDeleted, 
      this.society, 
      this.area, 
      this.brokerMobile, 
      this.brokerName, 
      this.budget,});

  EststateList.fromJson(dynamic json) {
    id = json['id'];
    estateName = json['estate_name'];
    city = json['city'];
    estateType = json['estate_type'];
    furniture = json['furniture'];
    floorSpace = json['floor_space'];
    numberOfBalconies = json['number_of_balconies'];
    numberOfBedrooms = json['number_of_bedrooms'];
    numberOfBathrooms = json['number_of_bathrooms'];
    numberOfGarages = json['number_of_garages'];
    numberOfParkingSpaces = json['number_of_parking_spaces'];
    petsAllowed = json['pets_allowed'];
    estateDescription = json['estate_description'];
    estateStatus = json['estate_status'];
    isDeleted = json['is_deleted'];
    society = json['society'];
    area = json['area'];
    brokerMobile = json['broker_mobile'];
    brokerName = json['broker_name'];
    budget = json['budget'];
  }
  int? id;
  String? estateName;
  String? city;
  String? estateType;
  String? furniture;
  int? floorSpace;
  dynamic numberOfBalconies;
  int? numberOfBedrooms;
  dynamic numberOfBathrooms;
  dynamic numberOfGarages;
  dynamic numberOfParkingSpaces;
  dynamic petsAllowed;
  String? estateDescription;
  String? estateStatus;
  bool? isDeleted;
  String? society;
  String? area;
  String? brokerMobile;
  String? brokerName;
  int? budget;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['estate_name'] = estateName;
    map['city'] = city;
    map['estate_type'] = estateType;
    map['furniture'] = furniture;
    map['floor_space'] = floorSpace;
    map['number_of_balconies'] = numberOfBalconies;
    map['number_of_bedrooms'] = numberOfBedrooms;
    map['number_of_bathrooms'] = numberOfBathrooms;
    map['number_of_garages'] = numberOfGarages;
    map['number_of_parking_spaces'] = numberOfParkingSpaces;
    map['pets_allowed'] = petsAllowed;
    map['estate_description'] = estateDescription;
    map['estate_status'] = estateStatus;
    map['is_deleted'] = isDeleted;
    map['society'] = society;
    map['area'] = area;
    map['broker_mobile'] = brokerMobile;
    map['broker_name'] = brokerName;
    map['budget'] = budget;
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