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
      this.estateType,});

  BrokerProfileData.fromJson(dynamic json) {
    name = json['name'];
    mobile = json['mobile'];
    balance = json['balance'];
    contacts = json['contacts'];
    estates = json['estates'];
    area = json['area'] != null ? json['area'].cast<String>() : [];
    estateType = json['estate_type'] != null ? json['estate_type'].cast<String>() : [];
  }
  String? name;
  String? mobile;
  int? balance;
  int? contacts;
  int? estates;
  List<String>? area;
  List<String>? estateType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['mobile'] = mobile;
    map['balance'] = balance;
    map['contacts'] = contacts;
    map['estates'] = estates;
    map['area'] = area;
    map['estate_type'] = estateType;
    return map;
  }

}