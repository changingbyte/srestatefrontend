// To parse this JSON data, do
//
//     final estateListResponse = estateListResponseFromJson(jsonString);

import 'dart:convert';

EstateListCommonResponse estateListResponseFromJson(String str) => EstateListCommonResponse.fromJson(json.decode(str));

String estateListResponseToJson(EstateListCommonResponse data) => json.encode(data.toJson());

class EstateListCommonResponse {
  EstateListCommonResponse({
    this.success,
    this.error,
    this.message,
    this.data,
  });

  bool? success;
  List<dynamic>? error;
  String? message;
  List<EstateList>? data;

  factory EstateListCommonResponse.fromJson(Map<String, dynamic> json) => EstateListCommonResponse(
    success: json["success"] == null ? null : json["success"],
    error: json["error"] == null ? null : List<dynamic>.from(json["error"].map((x) => x)),
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<EstateList>.from(json["data"].map((x) => EstateList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "error": error == null ? null : List<dynamic>.from(error!.map((x) => x)),
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class EstateList {
  EstateList({
    this.id,
    this.estateName,
    this.city,
    this.estateType,
    this.floorSpace,
    this.numberOfBedrooms,
    this.estateDescription,
    this.estateStatus,
    this.society,
    this.area,
    this.budget,
    this.furniture,
    this.isMyProperty,
    this.brokerMobile,
    this.brokerName
  });

  int? id;
  String? estateName;
  String? city;
  String? estateType;
  String? floorSpace;
  int? numberOfBedrooms;
  String? estateDescription;
  String? estateStatus;
  String? society;
  String? area;
  int? budget;
  String? furniture;
  bool? isMyProperty;
  String? brokerMobile;
  String? brokerName;


  factory EstateList.fromJson(Map<String, dynamic> json) => EstateList(
    id: json["id"] == null ? null : json["id"],
    estateName: json["estate_name"] == null ? null : json["estate_name"],
    city: json["city"] == null ? null : json["city"],
    estateType: json["estate_type"] == null ? null : json["estate_type"],
    floorSpace: json["floor_space"] == null ? null : json["floor_space"],
    numberOfBedrooms: json["number_of_bedrooms"] == null ? null : json["number_of_bedrooms"],
    estateDescription: json["estate_description"] == null ? null : json["estate_description"],
    estateStatus: json["estate_status"] == null ? null : json["estate_status"],
    society: json["society"] == null ? null : json["society"],
    area: json["area"] == null ? null : json["area"],
    budget: json["budget"] == null ? null : json["budget"],
    furniture: json["furniture"] == null ? null : json["furniture"],
    isMyProperty: json["is_my_property"] == null ? false : json["is_my_property"],
    brokerMobile: json["broker_mobile"] == null ? null : json["broker_mobile"],
    brokerName: json["broker_name"] == null ? null : json["broker_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "estate_name": estateName == null ? null : estateName,
    "city": city == null ? null : city,
    "estate_type": estateType == null ? null : estateType,
    "floor_space": floorSpace == null ? null : floorSpace,
    "number_of_bedrooms": numberOfBedrooms == null ? null : numberOfBedrooms,
    "estate_description": estateDescription == null ? null : estateDescription,
    "estate_status": estateStatus == null ? null : estateStatus,
    "society": society == null ? null : society,
    "area": area == null ? null : area,
    "budget": budget == null ? null : budget,
    "furniture": furniture == null ? null : furniture,
    "is_my_property": isMyProperty == null ? null : isMyProperty,
    "broker_mobile": brokerMobile == null ? null : brokerMobile,
    "broker_name": brokerName == null ? null : brokerName,
  };
}

