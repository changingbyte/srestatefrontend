import 'package:brokerBook/utils/ApiUtils.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:brokerBook/utils/AppCommonFunction.dart';
import 'package:brokerBook/utils/AppString.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_item/multi_select_item.dart';

import '../model/EstateListCommonResponse.dart';


class EstateListController extends GetxController{
  MultiSelectController myMultiSelectController = MultiSelectController();

  late EstateListCommonResponse estateListResponse;
  List<EstateList> estateList = [];
  bool isDataLoading = true;


  Future<EstateListCommonResponse> estateListApi({required String token,required String estateName}) async {
    try{
      var jsonPayload = jsonEncode( { 'estate_type': ['$estateName']  });


      http.Response response = await http.post(
        Uri.parse("${ApiUtils.BASE_URL}api/v1/property/estate/filter_query/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Token $token"
        },
        body: jsonPayload
      ).timeout(
          Duration(seconds: 30),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            // time has run out, do what you wanted to do
            return Future.value();
          });


      //print("Estate Listtttt  ::  ${response.body}");


      if(response.statusCode == 200){
        if(response.body != null){
          estateListResponse = EstateListCommonResponse.fromJson(json.decode(response.body));
          // print("estateListResponse  ::  $estateListResponse");
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


  void progressDataLoading(bool isProgress) {
    isDataLoading = isProgress;
    update();
  }

}