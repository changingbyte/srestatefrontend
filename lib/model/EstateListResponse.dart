// To parse this JSON data, do
//
//     final estateListResponse = estateListResponseFromJson(jsonString);

import 'dart:convert';

EstateListResponse estateListResponseFromJson(String str) => EstateListResponse.fromJson(json.decode(str));

String estateListResponseToJson(EstateListResponse data) => json.encode(data.toJson());

class   EstateListResponse {
  EstateListResponse({
    this.success,
    this.error,
    this.message,
    this.data,
  });

  bool? success;
  List<dynamic>? error;
  String? message;
  List<EstateList>? data;

  factory EstateListResponse.fromJson(Map<String, dynamic> json) => EstateListResponse(
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
    this.numberOfBalconies,
    this.balconiesSpace,
    this.numberOfBedrooms,
    this.numberOfBathrooms,
    this.numberOfGarages,
    this.numberOfParkingSpaces,
    this.petsAllowed,
    this.estateDescription,
    this.estateStatus,
    this.society,
    this.area,
    this.brokerMobile,
    this.brokerName,
    this.budget,
    this.furniture,
  });

  int? id;
  String? estateName;
  String? city;
  String? estateType;
  String? floorSpace;
  int? numberOfBalconies;
  String? balconiesSpace;
  int? numberOfBedrooms;
  int? numberOfBathrooms;
  int? numberOfGarages;
  int? numberOfParkingSpaces;
  int? petsAllowed;
  String? estateDescription;
  String? estateStatus;
  String? society;
  String? area;
  String? brokerMobile;
  String? brokerName;
  int? budget;
  String? furniture;

  factory EstateList.fromJson(Map<String, dynamic> json) => EstateList(
    id: json["id"] == null ? null : json["id"],
    estateName: json["estate_name"] == null ? null : json["estate_name"],
    city: json["city"] == null ? null : json["city"],
    estateType: json["estate_type"] == null ? null : json["estate_type"],
    floorSpace: json["floor_space"] == null ? null : json["floor_space"],
    numberOfBalconies: json["number_of_balconies"] == null ? null : json["number_of_balconies"],
    balconiesSpace: json["balconies_space"] == null ? null : json["balconies_space"],
    numberOfBedrooms: json["number_of_bedrooms"] == null ? null : json["number_of_bedrooms"],
    numberOfBathrooms: json["number_of_bathrooms"] == null ? null : json["number_of_bathrooms"],
    numberOfGarages: json["number_of_garages"] == null ? null : json["number_of_garages"],
    numberOfParkingSpaces: json["number_of_parking_spaces"] == null ? null : json["number_of_parking_spaces"],
    petsAllowed: json["pets_allowed"] == null ? null : json["pets_allowed"],
    estateDescription: json["estate_description"] == null ? null : json["estate_description"],
    estateStatus: json["estate_status"] == null ? null : json["estate_status"],
    society: json["society"] == null ? null : json["society"],
    area: json["area"] == null ? null : json["area"],
    brokerMobile: json["broker_mobile"] == null ? null : json["broker_mobile"],
    brokerName: json["broker_name"] == null ? null : json["broker_name"],
    budget: json["budget"] == null ? null : json["budget"],
    furniture: json["furniture"] == null ? null : json["furniture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "estate_name": estateName == null ? null : estateName,
    "city": city == null ? null : city,
    "estate_type": estateType == null ? null : estateType,
    "floor_space": floorSpace == null ? null : floorSpace,
    "number_of_balconies": numberOfBalconies == null ? null : numberOfBalconies,
    "balconies_space": balconiesSpace == null ? null : balconiesSpace,
    "number_of_bedrooms": numberOfBedrooms == null ? null : numberOfBedrooms,
    "number_of_bathrooms": numberOfBathrooms == null ? null : numberOfBathrooms,
    "number_of_garages": numberOfGarages == null ? null : numberOfGarages,
    "number_of_parking_spaces": numberOfParkingSpaces == null ? null : numberOfParkingSpaces,
    "pets_allowed": petsAllowed == null ? null : petsAllowed,
    "estate_description": estateDescription == null ? null : estateDescription,
    "estate_status": estateStatus == null ? null : estateStatus,
    "society": society == null ? null : society,
    "area": area == null ? null : area,
    "broker_mobile": brokerMobile == null ? null : brokerMobile,
    "broker_name": brokerName == null ? null : brokerName,
    "budget": budget == null ? null : budget,
    "furniture": furniture == null ? null : furniture,
  };
}
