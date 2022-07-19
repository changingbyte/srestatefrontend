// ignore_for_file: null_argument_to_non_null_type, unnecessary_null_comparison

import 'dart:convert';

import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/utils/AppString.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/AddEstateResponse.dart';


class AddEstateController extends GetxController{

  bool isDataLoading = false;
  late AddEstateResponse addEstateResponse;

  String estateStatusVal = "Status";
  String estateType = "";


  Future<AddEstateResponse> addEstateApi({String? token,String? estate_name,String? city, String? budget,String? estate_type, String? floor_space, String? estate_status,
  String? society,String? area,String? no_of_bedroom
  }) async {
    try{

      var payload = jsonEncode({
        "estate_name": "app_test_anil",
        "city": city,
        "estate_type": estate_type,
        "floor_space": floor_space,
        "number_of_balconies": "0",
        "balconies_space": "0",
        "number_of_bedrooms": "0",
        "number_of_bathrooms": "0",
        "number_of_garages": "0",
        "number_of_parking_spaces": "0",
        "pets_allowed": "0",
        "estate_description": "Nice Property",
        "estate_status": estate_status,
        "society": society,
        "area": area,
        "furniture" : ""

      }); 


      http.Response response = await http.post(
        Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/estate/create/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Token $token"
        },
        body: payload
      ).timeout(
          Duration(seconds: 10),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            // time has run out, do what you wanted to do
            return Future.value();
          });


      print("addEstateApi  ::  ${response.body}");

      if(response.statusCode == 200  ||  response.statusCode == 201){
        if(response.body != null){
          addEstateResponse = AddEstateResponse.fromJson(json.decode(response.body));
          progressDataLoading(false);
          return addEstateResponse;
        }
        else{
          progressDataLoading(false);
          return AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
        }
      }
      else{
        progressDataLoading(false);
        AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
        throw Exception(AppString.somethingWentWrong);
      }


    }
    catch (e){
      progressDataLoading(false);
      AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
      print("ERROR  ::  $e");
      throw Exception(AppString.somethingWentWrong);

    }
  }

  void updateEstateType(String type){
    estateType = type;
    update();
  }

  void updateEstateStatusVal(String val){
    estateStatusVal = val;
    update();
  }


  void progressDataLoading(bool isProgress) {
    isDataLoading = isProgress;
    update();
  }

}