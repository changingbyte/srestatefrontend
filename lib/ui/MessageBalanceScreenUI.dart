import 'package:admob_flutter/admob_flutter.dart';
import 'package:croma_brokrage/helper/PreferenceHelper.dart';
import 'package:croma_brokrage/utils/AppColors.dart';
import 'package:croma_brokrage/widgets/RoundedButtonWidget.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controller/MessageBalanceController.dart';
import '../utils/AppCommonFunction.dart';
import '../utils/AppString.dart';
import '../widgets/Txt.dart';

class MessageBalanceScreenUI extends StatefulWidget {
  const MessageBalanceScreenUI ({Key? key}) : super(key: key);

  @override
  State<MessageBalanceScreenUI> createState() => _MessageBalanceScreenUIState();
}
class _MessageBalanceScreenUIState extends State<MessageBalanceScreenUI> {

  MessageBalanceController messageBalanceController = Get.put(MessageBalanceController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      messageBalanceController.progressDataLoading(true);
      callApi();
    });
  }

  callApi(){
    AppCommonFunction.checkInternet().then((value) {
      if(value){
        getMessageBalanceApi();

      }
      else{
        AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [

            Expanded(
              child: Column(
                children: [
                  SizedBox(height: Get.height/20,),

                  Center(child: Txt("Message Balance",fontSize: 24,fontWeight: FontWeight.bold,),),

                  SizedBox(height: Get.height/10,),
                  GetBuilder(
                    init: MessageBalanceController(),
                    builder: (MessageBalanceController controller) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          CardContainer(text1: "Text", balance: controller.textBalance.toString(), icon: Icons.message_outlined),
                          CardContainer(text1: "WhatsApp", balance: controller.whatsappBalance.toString(), icon: FontAwesomeIcons.whatsapp),

                        ],
                      );
                    },
                  ),

                  SizedBox(height: Get.height/10,),


                  RoundedButtonWidget(
                    text: "Add Messages",
                    height: 50,
                    width: Get.width/1.5,
                    onPressed: () {

                    },
                  ),
                ],
              ),
            ),

            AppCommonFunction.adsBanner(admobBannerSize: AdmobBannerSize.BANNER),

          ],
        ),
      ),
    );
  }

  Widget CardContainer({required String text1,required String balance,required IconData icon}){
    return Card(
      color: AppColors.primaryColor,
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10),
          )),
      child: Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon,size: 45,color: Colors.white,),

            Column(
              children: [
                Txt(balance == null ? "0" : balance,fontSize: 27,color: AppColors.white,fontWeight: FontWeight.bold),
                SizedBox(height: 3,),
                Txt(text1+" ",fontSize: 16,color: AppColors.white,fontWeight: FontWeight.w500),
              ],
            ),



          ],
        )),
      ),
    );
  }


  getMessageBalanceApi(){
    //  messageBalanceController
    messageBalanceController.messageBalanceApi(token: PreferenceHelper().getUserData().authToken!).then((value) {

      if(value != null){
        if(value["success"].toString() == "true"){
          if(value["data"]['balance'].toString().isNotEmpty){

            messageBalanceController.messageBalanceResponse = value['data'];
            messageBalanceController.textBalance = value['data']['balance'];
            messageBalanceController.whatsappBalance = messageBalanceController.textBalance/2;
            messageBalanceController.whatsappBalance = messageBalanceController.whatsappBalance.toStringAsFixed(0);

            //print("WHATSAPP BAL  ::  ${messageBalanceController.whatsappBalance}");

            messageBalanceController.progressDataLoading(false);
          }
        }
        else{
          AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
        }

      }
      else{
        AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
      }

    });
  }

}
