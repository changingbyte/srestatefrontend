import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/BrokerProfileResponse.dart';
import '../utils/ApiUtils.dart';
import '../utils/AppCommonFunction.dart';
import '../utils/AppString.dart';


class ViewBrokerProfileController extends GetxController{
  bool isDataLoading = true;
  late BrokerProfileResponse brokerProfileResponse;
  BrokerProfileData? brokerProfileData;




  Future<BrokerProfileResponse> brokerProfileApi({required String token}) async {
    try{

      http.Response response = await http.get(
        Uri.parse("${ApiUtils.BASE_URL}api/v1/property/brokerDetails/"),
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

      printWrapped("View Chat Profile  --::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          brokerProfileResponse = BrokerProfileResponse.fromJson(json.decode(response.body));
          progressDataLoading(false);
          return brokerProfileResponse;
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


// comment ANil code is here