import 'package:croma_brokrage/model/EstateListCommonResponse.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/ChatProfileResponse.dart';
import '../model/SuggestionResponse.dart';
import '../utils/AppCommonFunction.dart';
import '../utils/AppString.dart';

class PropertyDetailsController extends GetxController{
  bool isDataLoading = true;
  late EstateListCommonResponse suggestionResponse;
  //List<EstateList> suggestionList = [];

  Future<EstateListCommonResponse> suggestionListApi({required String token,required String id}) async {
    try{
      http.Response response = await http.get(
        Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/estate/details/$id/"),
        headers: {
          //"Content-Type": "application/json",
          "Authorization" : "Token $token"
        },
      ).timeout(
          Duration(seconds: 30),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            return Future.value();
          });
      printWrapped("suggestion List Api  --::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          suggestionResponse = EstateListCommonResponse.fromJson(json.decode(response.body));
          progressDataLoading(false);
          return suggestionResponse;
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