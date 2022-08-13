// ignore_for_file: null_argument_to_non_null_type, unnecessary_null_comparison

import 'dart:convert';

import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/utils/AppString.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/ContactListResponse.dart';

class ContactListController extends GetxController{

  bool isDataLoading = true;
  //List<ContactListResponse> contactListResponse = [];
  late ContactListResponse contactListResponse;


  Future<ContactListResponse> contactListApi({required String token}) async {
    try{

      http.Response response = await http.get(
        Uri.parse("http://srestateapi.herokuapp.com/chats/contactlist/"),
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

      printWrapped("Contact List  --::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          //Iterable l = json.decode(response.body);
          //contactListResponse = List<ContactListResponse>.from(l.map((model)=> ContactListResponse.fromJson(model)));
          contactListResponse = ContactListResponse.fromJson(json.decode(response.body));
          progressDataLoading(false);
          return contactListResponse;
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

