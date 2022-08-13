import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/AppCommonFunction.dart';
import '../utils/AppString.dart';

class MessageBalanceController extends GetxController{
  dynamic messageBalanceResponse;
  var textBalance;
  var whatsappBalance;
  bool isDataLoading = true;

  Future<dynamic> messageBalanceApi({required String token}) async {
    try{
      http.Response response = await http.get(
        Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/get_balance/"),
        headers: {
          "Accept" : "application/json",
          "Authorization" : "Token $token",
        },
      ).timeout(
          Duration(seconds: 30),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site is under maintenance!", false);
            // time has run out, do what you wanted to do
            return Future.value();
          });


      print("Messageee Balance  ::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          messageBalanceResponse = json.decode(response.body);
          progressDataLoading(false);
          return messageBalanceResponse;
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