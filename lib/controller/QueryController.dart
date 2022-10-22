import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/SendMessageResponse.dart';
import '../utils/ApiUtils.dart';
import '../utils/AppCommonFunction.dart';
import '../utils/AppString.dart';


class QueryController extends GetxController{
  bool isDataLoading = false;
  bool isWhatsApp = false;
  bool isText = false;
  late SendMessageResponse sendMessageResponse;
  List<int> estateIdList = [];


  Future<SendMessageResponse> sendMessageApi({required String token,required String phNumber,required List<int> estateId,required bool sms,required bool whatsApp}) async {
    try{
      print("phNumber  ::  $phNumber");
      print("estateId  ::  $estateId");
      print("sms  ::  $sms");
      print("whatsApp  ::  $whatsApp");


      var jsonPayload = jsonEncode( {
        'mobile' : phNumber,
        'estates' : estateId,
        'sms' : sms,
        'whatsapp' : whatsApp,
      });

      http.Response response = await http.post(
        Uri.parse("${ApiUtils.BASE_URL}api/v1/property/estate/sendmessage/"),
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
            return Future.value();
          });

      print("Send SMS API  --::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          sendMessageResponse = SendMessageResponse.fromJson(json.decode(response.body));
          progressDataLoading(false);
          return sendMessageResponse;
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



  void updateIsWhatsApp(bool val){
    isWhatsApp = val;
    update();
  }

  void updateIsText(bool val){
    isText = val;
    update();
  }

  void progressDataLoading(bool isProgress) {
    isDataLoading = isProgress;
    update();
  }
}