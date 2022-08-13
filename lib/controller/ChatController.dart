import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/ChatListResponse.dart';
import '../model/CreateChatMessegeResponse.dart';
import '../model/ReminderResponse.dart';
import '../utils/AppCommonFunction.dart';
import '../utils/AppString.dart';


class ChatController  extends GetxController{

  var selectedDateTime = "Please Select Date";
  bool isDataLoading = true;
  bool isStackDataLoading = false;
  late ChatListResponse chatListResponse;
  late ReminderResponse reminderResponse;
  List<ChatListData> chatDataList = [];

  late CreateChatMessageResponse chatMessageResponse;

  Future<ChatListResponse> chatListApi({required String token,required String phNumber}) async {
    try{

      http.Response response = await http.get(
        Uri.parse("http://srestateapi.herokuapp.com/chats/chatbymobile/?mobile=$phNumber"),
        headers: {
          "Authorization" : "Token $token"
          //"Authorization" : "Token $token"
        },
      ).timeout(
          Duration(seconds: 30),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            return Future.value();
          });

      printWrapped("chat List  --::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          chatListResponse = ChatListResponse.fromJson(json.decode(response.body));
          progressDataLoading(false);
          return chatListResponse;
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


  Future<ReminderResponse> reminderApi({required String token,required String receiver, required String sender, required String time, required String description}) async {
    try{
      var payload = json.encode({
        "reciver_name": receiver,
        "sender_name": sender,
        "time":time,
        "description": description
      });


      http.Response response = await http.post(
        Uri.parse("http://srestateapi.herokuapp.com/chats/create/reminder/"),
        headers: {
          "Authorization" : "Token $token",
          "Content-Type" : "application/json",
        },
        body: payload
      ).timeout(
          Duration(seconds: 30),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            return Future.value();
          });

      printWrapped("Reminder API  --::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          reminderResponse = ReminderResponse.fromJson(json.decode(response.body));
          progressDataLoading(false);
          return reminderResponse;
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


  Future<CreateChatMessageResponse> sendChatMsgApi({required String token,required String description, required String receiver_name, required String seen}) async {
    try{

      var payload = json.encode({
        "description" : description,
        "receiver_name" : receiver_name,
        "seen" : "false"
      });


      http.Response response = await http.post(
        Uri.parse("http://srestateapi.herokuapp.com/chats/create/?"),
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Token $token"
          //"Authorization" : "Token $token"
        },
        body: payload
      ).timeout(
          Duration(seconds: 30),
          onTimeout: () async{
            progressDataLoading(false);
            AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
            return Future.value();
          });

      printWrapped("Send Chat msg  --::  ${response.body}");

      if(response.statusCode == 200){
        if(response.body != null){
          chatMessageResponse = CreateChatMessageResponse.fromJson(json.decode(response.body));
          progressDataLoading(false);
          return chatMessageResponse;
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

  void updateSelectedDateTime(String val) {
    selectedDateTime = val;
    update();
  }

  void updateIsStackDataLoading(bool isProgress) {
    isStackDataLoading = isProgress;
    update();
  }

}

