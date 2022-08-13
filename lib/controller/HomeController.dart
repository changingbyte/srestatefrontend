// ignore_for_file: null_argument_to_non_null_type, unnecessary_null_comparison

import 'package:get/get.dart';
import 'dart:convert';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/utils/AppString.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_item/multi_select_item.dart';

import '../model/EstateListResponse.dart';
import '../model/FilterDataResponse.dart';

class HomeController extends GetxController{

  MultiSelectController myMultiSelectController = MultiSelectController();
  late EstateListResponse estateListResponse;
  late FilterDataResponse filterDataResponse;

  List<EstateList> estateList = [];
  List<EstateList> newEstateList = [];
  Set<int> selectedEstateList = {};
  bool isDataLoading = true;

  FilterData? data;

  List<String> filterAreaList = [];
    String filterAreaListTitle = "Area";

  List<String> filterPropertyTypeList = [];
  String filterPropertyTypeTitle = "Type";

  List<String> filterFurnitureList = [];
  String filterFurnitureTitle = "Furniture Type";

  List<String> filterEstateCategoryList = [];
  String filterEstateCategoryTitle = "Estate Status";


  List<num> filterBudgetList = [];
  num intervalValue = 0;


  List<String> filterBHKList = [];
  String filterBHKTitle = "BHK";


  Future<EstateListResponse> estateListApi({required String token,List<String>? area,List<String>? estate_status,List<String>? no_of_bedrooms,
    List<String>? apartment,List<String>? budget, List<String>? furniture}) async {

    /*print("area  ::  $area");
    print("estate_status  ::  $estate_status");
    print("no_of_bedrooms  ::  $no_of_bedrooms");
    print("apartment  ::  $apartment");
    print("budget  ::  $budget");
    print("furniture  ::  $furniture");*/


    try{
      var payload = jsonEncode({
        "area" : area,
        "estate_status": estate_status,
        "number_of_bedrooms": no_of_bedrooms,
        "apartment": apartment,
        "budget":budget,
        "furniture": furniture
      });

      //Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/estate/"),


      http.Response response = await http.post(
        Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/estate/filter_query/"),
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
            return Future.value();
          });

      printWrapped("Estate List  --::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          estateListResponse = EstateListResponse.fromJson(json.decode(response.body));
          progressDataLoading(false);
          return estateListResponse;
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


  Future<FilterDataResponse> filterApi({required String token}) async {
    try{

      http.Response response = await http.get(
          Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/estate/filter_details/"),
          headers: {
            "Content-Type": "application/json",
            "Authorization" : "Token $token"
          },
      ).timeout(
          Duration(seconds: 30),
          onTimeout: () async{

            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            return Future.value();
          });

      printWrapped("Filter Data  --::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          filterDataResponse = FilterDataResponse.fromJson(json.decode(response.body));
          return filterDataResponse;
        }
        else{
          return AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
        }
      }
      else{
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


  void selectAllItems() {
      myMultiSelectController.toggleAll();
      update();
  }

  void deselectItems() {
    myMultiSelectController.deselectAll();
    update();
  }

  void isToggle(int index){
    myMultiSelectController.toggle(index);
    update();
  }

  void updateAreaListTitle(String area){
    filterAreaListTitle = area;
    update();
  }


  void updatePropertyTypeTitle(String type){
    filterPropertyTypeTitle = type;
    update();
  }

  void updateFurnitureTitle(String type){
    filterFurnitureTitle = type;
    update();
  }

  void updateEstateCategoryTitle(String type){
    filterEstateCategoryTitle = type;
    update();
  }

  void updateBHKTitle(String type){
    filterBHKTitle = type;
    update();
  }

  void progressDataLoading(bool isProgress) {
    isDataLoading = isProgress;
    update();
  }


}