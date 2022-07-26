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


  factory BrokerProfileData.fromJson(Map<String, dynamic> json) => BrokerProfileData(
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