import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/ChatProfileResponse.dart';
import '../utils/AppCommonFunction.dart';
import '../utils/AppString.dart';


class ViewProfileController extends GetxController{
  bool isDataLoading = true;
  late ChatProfileResponse chatProfileResponse;
  ChatProfileData? chatProfileData;




  Future<ChatProfileResponse> chatProfileApi({required String token}) async {
    try{

      http.Response response = await http.get(
        Uri.parse("http://srestateapi.herokuapp.com/chats/contact_details/8000802034/9426469653/"),
        headers: {
          //"Content-Type": "application/json",
          "Authorization" : "Token $token"
        },
      ).timeout(
          Duration(seconds: 20),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            return Future.value();
          });

      printWrapped("View Chat Profile  --::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          chatProfileResponse = ChatProfileResponse.fromJson(json.decode(response.body));
          progressDataLoading(false);
          return chatProfileResponse;
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