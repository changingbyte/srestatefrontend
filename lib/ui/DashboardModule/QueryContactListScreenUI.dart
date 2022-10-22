import 'package:brokerBook/utils/AppCommonFunction.dart';
import 'package:brokerBook/widgets/Txt.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../controller/QueryContactListController.dart';
import '../../utils/AppColors.dart';
import '../../widgets/TextFormInputField.dart';

class QueryContactListScreenUI extends StatefulWidget {
  const QueryContactListScreenUI({Key? key}) : super(key: key);

  @override
  State<QueryContactListScreenUI> createState() => _QueryContactListScreenUIState();
}

class _QueryContactListScreenUIState extends State<QueryContactListScreenUI> {
  QueryContactListController queryContactListController = Get.put(QueryContactListController());

  @override
  initState() {
    super.initState();
    checkPermission();
  }

  checkPermission() async {
    var status = await Permission.contacts.status;
    Fluttertoast.showToast(msg: status.toString());
    if (status.isDenied) {
      await Permission.contacts.request();
      checkPermission();
    }

    if (status.isPermanentlyDenied) {
      await Permission.contacts.request();
      checkPermission();
    }

    if (status.isGranted) {
      getContacts();
    }
  }

  getContacts() async {
    print("---Get Contacts---");

    var temp = await ContactsService.getContacts();

    for(int i=0; i<temp.length; i++){

      if(temp[i].displayName != null && temp[i].phones!.length > 1){
        queryContactListController.updateContacts(temp[i]);
        queryContactListController.updateTempContacts(temp[i]);
      }

    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contact List"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                AppColors.primaryColor,
                Colors.black,
              ]),
            ),
          ),
        ),
        body: GetBuilder(
          init: QueryContactListController(),
          builder: (QueryContactListController controller) {
            return controller.contacts.isEmpty
                ? AppCommonFunction.circularIndicator()
                : Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormInputField(
                        hintText: "Search Contact",
                        iconSuffix: Icons.search,
                        onChanged: (String val){
                          onItemSearch(val,controller);
                        },
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          itemCount: controller.contacts.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                    onTap: () {
                                      Navigator.pop(context, controller.contacts[index].phones![0].value.toString());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: CircleAvatar(
                                                radius: 20,
                                                child: Txt("${controller.contacts[index].displayName!.substring(0, 1)}",
                                                    fontWeight: FontWeight.w500, fontSize: 16),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Txt("${controller.contacts[index].displayName}", fontWeight: FontWeight.w500, fontSize: 16),
                                                  SizedBox(height: 6),
                                                  Txt("${controller.contacts[index].phones![0].value}", fontWeight: FontWeight.w500, fontSize: 17),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                    ),
                  ],
                );
          },
        ),
      ),
    );
  }



  onItemSearch(String value,QueryContactListController queryContactListController) {
    print("VALUE  ::  ${value}");

    queryContactListController.contacts =
        queryContactListController.tempContacts.where((string) => string.displayName!.toLowerCase().contains(value.toLowerCase())).toList();
    setState((){});


    /*if(queryContactListController.contacts.isEmpty){
      queryContactListController.contacts = tempContact.where((string) => string.phones![0].toString().toLowerCase().contains(value.toLowerCase())).toList();
    }*/


  }

}
