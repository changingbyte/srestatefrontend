import 'dart:convert';
import 'package:contacts_service/contacts_service.dart';
import 'package:brokerBook/utils/AppCommonFunction.dart';
import 'package:brokerBook/utils/AppString.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class QueryContactListController  extends GetxController{

  List<Contact> contacts = [];
  List<Contact> tempContacts = [];
  bool isDataLoading = true;




  void updateContacts(Contact contact) {
    contacts.add(contact);
    update();
  }

  void updateTempContacts(Contact val) {
    tempContacts.add(val);
    update();
  }

  void progressDataLoading(bool isProgress) {
    isDataLoading = isProgress;
    update();
  }

}