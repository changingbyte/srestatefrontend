import 'dart:convert';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/utils/AppString.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class SearchModuleController extends GetxController{

  dynamic buyEstateListResponse;
  dynamic buyEstateList = [];

  dynamic saleEstateListResponse;
  dynamic saleEstateList = [];

  bool isDataLoading = true;



  Future<dynamic> buyEstateListApi({required String token}) async {
    try{
      http.Response response = await http.get(
        Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/estate/buy/"),
        headers: {
          "Accept": "application/json",
          "Authorization" : "Token $token"
        },
      ).timeout(
          Duration(seconds: 10),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            // time has run out, do what you wanted to do
            return Future.value();
          });

      print("buy Estate List  ::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          buyEstateListResponse = json.decode(response.body);
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


  Future<dynamic> saleEstateListApi({required String token}) async {
    try{
      http.Response response = await http.get(
        Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/estate/sell/"),
        headers: {
          "Accept": "application/json",
          "Authorization" : "Token $token"
        },
      ).timeout(
          Duration(seconds: 10),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            // time has run out, do what you wanted to do
            return Future.value();
          });


      print("sale Estate List  ::  ${response.body}");


      if(response.statusCode == 200){
        if(response.body != null){
          saleEstateListResponse = json.decode(response.body);
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


  void progressDataLoading(bool isProgress) {
    isDataLoading = isProgress;
    update();
  }

}