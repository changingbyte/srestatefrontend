
import 'dart:convert';
import 'package:croma_brokrage/model/NumberApiResponse.dart';
import 'package:croma_brokrage/utils/ApiUtils.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/utils/AppString.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class OnBoardingController extends GetxController
{

  bool isDataLoading = false;
  bool isAgreeTerms = false;
  bool isResendTimerShow = false;
  var statusCode;
  late NumberApiResponse numberApiResponse;



 Future<NumberApiResponse> enterNumberApi({required String number,required String appSignature}) async {
   try{
     var jsonPayload = jsonEncode( { 'Mobile' : '$number', 'appString' : '$appSignature '  });

    http.Response response = await http.post(
      Uri.parse(ApiUtils.BASE_URL + ApiUtils.validate_mobile),
      headers: {
        "Accept": "application/json",
      },
      body: jsonPayload
    ).timeout(
        Duration(seconds: 15),
        onTimeout: () async{
          progressDataLoading(false);
          AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
          // time has run out, do what you wanted to do
          return Future.value();
        });


    print("Enter Number  ::  ${response.body}");
     statusCode = response.statusCode;
    if(response.statusCode == 200 || response.statusCode == 201){
      if(response.body != null){
        numberApiResponse = NumberApiResponse.fromJson(json.decode(response.body));
        progressDataLoading(false);
        return numberApiResponse;
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




  void updateResendTimerShow(bool val){
    isResendTimerShow = val;
    update();
  }

 void progressDataLoading(bool isProgress) {
    isDataLoading = isProgress;
    update();
  }

  void updateTermsOfCond(bool isAgreeTerms1) {
    this.isAgreeTerms = isAgreeTerms1;
    update();
  }
}


