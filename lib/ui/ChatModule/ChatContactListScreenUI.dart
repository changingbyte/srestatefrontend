// ignore_for_file: unnecessary_null_comparison

import 'package:croma_brokrage/helper/PreferenceHelper.dart';
import 'package:croma_brokrage/ui/ChatModule/ChatScreenUI.dart';
import 'package:croma_brokrage/widgets/ScaffoldWidget.dart';
import 'package:croma_brokrage/widgets/Txt.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/ContactListController.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppCommonFunction.dart';
import '../../utils/AppString.dart';

class ChatContactListScreenUI extends StatefulWidget {
  const ChatContactListScreenUI({Key? key}) : super(key: key);

  @override
  State<ChatContactListScreenUI> createState() => _ChatContactListScreenUIState();
}

class _ChatContactListScreenUIState extends State<ChatContactListScreenUI> {
  ContactListController contactListController = Get.put(ContactListController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      getChatList();
    });

  }


  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: GetBuilder(
        init: ContactListController(),
        builder: (ContactListController controller) {
          return controller.isDataLoading
            ? AppCommonFunction.circularIndicator()
            : ListView.builder(
            itemCount: controller.contactListResponse.results!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 6),
                child: InkWell(
                  onTap: () {
                    var callApi = Get.to(()=> ChatScreenUI(
                      reciver: controller.contactListResponse.results![index].lastMessage!.receiverName!,
                      webSocketUrl: controller.contactListResponse.results![index].websocketUrl!,
                      sender: controller.contactListResponse.results![index].owner!,
                      abs_url: controller.contactListResponse.results![index].absoluteUrl!,
                    )
                    )!.then((value) {
                        getChatList();
                    });




                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(backgroundColor: AppColors.primaryColor,radius: 23,child: Icon(Icons.account_circle,color: Colors.white,size: 35,)),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Txt("${controller.contactListResponse.results![index].lastMessage == ""
                                    ? ""
                                    : controller.contactListResponse.results![index].lastMessage!.receiverName}",fontWeight: FontWeight.w600,fontSize: 18),

                               Txt("${AppCommonFunction.timestampToDatetime(controller.contactListResponse.results![index].timestamp!)}",maxLines: 1,overflow: TextOverflow.ellipsis,fontSize: 14),
                              ],
                            ),


                            Row(
                              children: [
                                Container(
                                    width: Get.width/1.5,
                                    child: Txt("${controller.contactListResponse.results![index].lastMessage!.description}",fontSize: 15,maxLines: 1,overflow: TextOverflow.ellipsis)),

                                controller.contactListResponse.results![index].unseen! == 0
                                    ? Container()
                                    : CircleAvatar(radius: 13,backgroundColor: AppColors.primaryColor,child: Txt("${controller.contactListResponse.results![index].unseen}",maxLines: 1,overflow: TextOverflow.ellipsis,color: Colors.white,fontWeight: FontWeight.bold,)),

                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },

      ),
    );
  }


  getChatList(){
    contactListController.progressDataLoading(true);
    contactListController.contactListApi(token: PreferenceHelper().getUserData().authToken!).then((response) {

      if(response != null){
        contactListController.contactListResponse = response;
        contactListController.progressDataLoading(false);
      }
      else{
        AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
        contactListController.progressDataLoading(false);
      }

    });
  }

}
