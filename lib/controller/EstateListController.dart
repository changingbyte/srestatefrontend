import 'package:get/get.dart';
import 'dart:convert';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/utils/AppString.dart';
import 'package:http/http.dart' as http;


class EstateListController extends GetxController{


  dynamic estateListResponse;
  dynamic estateList = [];
  bool isDataLoading = true;


  Future<dynamic> estateListApi({required String token,required String estateName}) async {
    try{
      var jsonPayload = jsonEncode( { 'estate_type': ['$estateName']  });


      http.Response response = await http.post(
        Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/estate/filter_query/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Token $token"
        },
        body: jsonPayload
      ).timeout(
          Duration(seconds: 10),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            // time has run out, do what you wanted to do
            return Future.value();
          });


      //print("Estate Listtttt  ::  ${response.body}");


      if(response.statusCode == 200){
        if(response.body != null){
          estateListResponse = json.decode(response.body);
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


  void progressDataLoading(bool isProgress) {
    isDataLoading = isProgress;
    update();
  }

}