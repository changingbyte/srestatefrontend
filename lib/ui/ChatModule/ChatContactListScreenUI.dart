// ignore_for_file: unnecessary_null_comparison

import 'package:croma_brokrage/helper/PreferenceHelper.dart';
import 'package:croma_brokrage/ui/ChatModule/ChatScreenUI.dart';
import 'package:croma_brokrage/widgets/Txt.dart';
import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
            title: Txt("Query History",color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
            flexibleSpace: Container(
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    AppColors.primaryColor,
                    AppColors.primaryColor,
                    AppColors.primaryAccent
                  ],

                ),
              ),
            ),

        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:

          GetBuilder(
            init: ContactListController(),
            builder: (ContactListController controller) {
              return
                controller.isDataLoading
                ? AppCommonFunction.circularIndicator()
                : ListView.builder(
                itemCount: controller.contactListResponse.results!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(()=> ChatScreenUI(
                          reciver: controller.contactListResponse.results![index].lastMessage!.receiverName!,
                          webSocketUrl: controller.contactListResponse.results![index].websocketUrl!,
                          sender: controller.contactListResponse.results![index].owner!,
                        )
                        );
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(backgroundColor: AppColors.primaryColor,radius: 25,child: Icon(Icons.account_circle,color: Colors.white,size: 35,)),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Txt("${controller.contactListResponse.results![index].lastMessage!.receiverName}",fontWeight: FontWeight.w600,fontSize: 18),
                                      Txt("${controller.contactListResponse.results![index].lastMessage!.description}",maxLines: 1,overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ],
                              ),
                              //Txt("${controller.chatListResponse[index].timestamp!.substring(0,10)}",fontSize: 13,color: Colors.black38),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(height: 3,indent: 10),
                        ],
                      ),
                    ),
                  );
                },
              );
            },

          ),
        ),
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
