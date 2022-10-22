// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:brokerBook/utils/AppCommonFunction.dart';
import 'package:brokerBook/utils/AppString.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_item/multi_select_item.dart';

import '../model/EstateListCommonResponse.dart';
import '../utils/ApiUtils.dart';

class SearchModuleController extends GetxController{
  MultiSelectController myMultiSelectController = MultiSelectController();

  late EstateListCommonResponse buyEstateListResponse;
  List<EstateList> buyEstateList = [];

  late EstateListCommonResponse saleEstateListResponse;
  List<EstateList> saleEstateList = [];

  bool isDataLoading = true;

  Future<EstateListCommonResponse> buyEstateListApi({required String token}) async {
    try{
      http.Response response = await http.get(
        Uri.parse("${ApiUtils.BASE_URL}api/v1/property/estate/buy/"),
        headers: {
          "Accept": "application/json",
          "Authorization" : "Token $token"
        },
      ).timeout(
          Duration(seconds: 30),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            // time has run out, do what you wanted to do
            return Future.value();
          });

      printWrapped("buy Estate List  ::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          buyEstateListResponse = EstateListCommonResponse.fromJson(json.decode(response.body));
          progressDataLoading(false);
          return buyEstateListResponse;
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

  Future<EstateListCommonResponse> saleEstateListApi({required String token}) async {
    try{
      http.Response response = await http.get(
        Uri.parse("${ApiUtils.BASE_URL}api/v1/property/estate/sell/"),
        headers: {
          "Accept": "application/json",
          "Authorization" : "Token $token"
        },
      ).timeout(
          Duration(seconds: 30),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            // time has run out, do what you wanted to do
            return Future.value();
          });

      print("sale Estate List  ::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          saleEstateListResponse = EstateListCommonResponse.fromJson(json.decode(response.body));
          // print("estateListResponse  ::  $estateListResponse");
          progressDataLoading(false);
          return saleEstateListResponse;
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



  void isToggle(int index){
    myMultiSelectController.toggle(index);
    update();
  }



  void progressDataLoading(bool isProgress) {
    isDataLoading = isProgress;
    update();
  }

}