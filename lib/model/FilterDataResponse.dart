
import 'dart:convert';

FilterDataResponse filterDataResponseFromJson(String str) => FilterDataResponse.fromJson(json.decode(str));

String filterDataResponseToJson(FilterDataResponse data) => json.encode(data.toJson());

class FilterDataResponse {
  FilterDataResponse({
    this.success,
    this.error,
    this.message,
    this.data,
  });

  bool? success;
  List<dynamic>? error;
  String? message;
  FilterData? data;

  factory FilterDataResponse.fromJson(Map<String, dynamic> json) => FilterDataResponse(
    success: json["success"] == null ? null : json["success"],
    error: json["error"] == null ? null : List<dynamic>.from(json["error"].map((x) => x)),
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : FilterData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "error": error == null ? null : List<dynamic>.from(error!.map((x) => x)),
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class FilterData {
  FilterData({
    this.area,
    this.estateStatus,
    this.furniture,
    this.estateType,
    this.budget,
    this.rooms,
    this.floorSpace,
  });

  List<String>? area;
  List<String>? estateStatus;
  List<String>? furniture;
  List<String>? estateType;
  List<num>? budget;
  List<num>? rooms;
  List<num>? floorSpace;

  factory FilterData.fromJson(Map<String, dynamic> json) => FilterData(
    area: json["area"] == null ? null : List<String>.from(json["area"].map((x) => x)),
    estateStatus: json["estate_status"] == null ? null : List<String>.from(json["estate_status"].map((x) => x)),
    furniture: json["furniture"] == null ? null : List<String>.from(json["furniture"].map((x) => x)),
    estateType: json["estate_type"] == null ? null : List<String>.from(json["estate_type"].map((x) => x)),
    budget: json["budget"] == null ? null : List<num>.from(json["budget"].map((x) => x)),
    rooms: json["rooms"] == null ? null : List<num>.from(json["rooms"].map((x) => x)),
    floorSpace: json["floor_space"] == null ? null : List<num>.from(json["floor_space"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "area": area == null ? null : List<dynamic>.from(area!.map((x) => x)),
    "estate_status": estateStatus == null ? null : List<dynamic>.from(estateStatus!.map((x) => x)),
    "furniture": furniture == null ? null : List<dynamic>.from(furniture!.map((x) => x)),
    "estate_type": estateType == null ? null : List<dynamic>.from(estateType!.map((x) => x)),
    "budget": budget == null ? null : List<dynamic>.from(budget!.map((x) => x)),
    "rooms": rooms == null ? null : List<dynamic>.from(rooms!.map((x) => x)),
    "floor_space": floorSpace == null ? null : List<dynamic>.from(floorSpace!.map((x) => x)),
  };
}
