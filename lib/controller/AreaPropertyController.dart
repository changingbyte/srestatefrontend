import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/utils/AppString.dart';
import 'package:get/get.dart';

class AreaPropertyController extends GetxController{


  dynamic areaListResponse;
  dynamic estateTypeListResponse;
  dynamic createUserResponse;
  dynamic areaList = [];
  dynamic estateTypeList = [];
  List<String> selectedAreaList = [];
  List<String> selectedEstateTypeList = [];
  bool isDataLoading = true;


  Future<dynamic> areaListApi({required String token}) async {
    try{

      http.Response response = await http.get(
        Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/area/"),
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


      //print("Area List  ::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          areaListResponse = json.decode(response.body);
          return areaListResponse;
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

  Future<dynamic> estateTypeListApi({required String token}) async {
    try{

      http.Response response = await http.get(
        Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/estate_type/"),
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


      //print("estateType List  ::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          estateTypeListResponse = json.decode(response.body);
          progressDataLoading(false);
          return estateTypeListResponse;
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


  Future<dynamic> createBrokerApi({required String token,required String name,required List<String> area,required List<String> estate_type}) async {
    try{

      var payload = jsonEncode(
        {
          "name": name,
          "area" : area,
          "estate_type" : estate_type
        }
      );

      http.Response response = await http.post(
        Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/broker/create/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Token $token"
        },
        body: payload
      ).timeout(
          Duration(seconds: 30),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            // time has run out, do what you wanted to do
            return Future.value();
          });


      print("Create Broker  ::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          createUserResponse = json.decode(response.body);
          progressDataLoading(false);
          return createUserResponse;
        }
        else{
          progressDataLoading(false);
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

    }
  }


  void progressDataLoading(bool isProgress) {
    isDataLoading = isProgress;
    update();
  }


}