import 'package:croma_brokrage/helper/PreferenceHelper.dart';
import 'package:croma_brokrage/ui/DashboardModule/DashboardScreenUI.dart';
import 'package:croma_brokrage/ui/DashboardModule/QueryContactListScreenUI.dart';
import 'package:croma_brokrage/utils/AppColors.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/utils/FieldValidator.dart';
import 'package:croma_brokrage/widgets/RoundedButtonWidget.dart';
import 'package:croma_brokrage/widgets/TextFormInputField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/HomeController.dart';
import '../../controller/QueryController.dart';
import '../../utils/AppString.dart';
import '../../widgets/Txt.dart';

class QueryScreenUI extends StatefulWidget {
  const QueryScreenUI({Key? key}) : super(key: key);

  @override
  State<QueryScreenUI> createState() => _QueryScreenUIState();
}

class _QueryScreenUIState extends State<QueryScreenUI> {

  final formKey = GlobalKey<FormState>();
  HomeController homeController = Get.put(HomeController());
  QueryController queryController = Get.put(QueryController());
  TextEditingController numberController = new TextEditingController();

  /*@override
  void initState() {
    super.initState();
    print("LISTTTTTTT+++++++  ::  ${homeController.selectedEstateList.length}");
    if(homeController.selectedEstateList.isNotEmpty){
      for(int i=0; i<homeController.selectedEstateList.length; i++){
        print("estate ID  ::  ${homeController.selectedEstateList} ");
      }
    }
  }*/


  @override
  void initState() {
    super.initState();
    print("LISTTTTTTT+++++++  ::  ${homeController.selectedEstateList.length}");
    if(homeController.selectedEstateList.isNotEmpty){
      homeController.selectedEstateList.forEach((element) {
        print("LISTTTTTTT-------   $element");
        queryController.estateIdList.add(element);

      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder(
          init: QueryController(),
          builder: (QueryController controller) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Stack(
                  children: [
                    Column(
                      children: [

                        SizedBox(height: 20,),

                        Txt("Query Message",fontSize: 22,color: AppColors.black,fontWeight: FontWeight.w600),

                        SizedBox(height: 10,),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            InkWell(
                                onTap: () async {
                                  Get.to(()=> QueryContactListScreenUI() )!.then((value) {

                                    if(value == null){
                                      value = "";
                                    }
                                    value = value.toString().replaceAll(" ","");
                                    value = value.toString().replaceAll("+91","");
                                    numberController.text = value;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,bottom: 15.0),
                                  child: Image.asset(AppString.imagesAssetPath+"ic_contacts.png",height: 35,width: 35,fit: BoxFit.cover,),
                                )),

                            SizedBox(width: 5,),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormInputField(
                                  controller: numberController,
                                  hintText: " Phone number",
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  validator: (value){
                                    return FieldValidator.validatePhoneNumber(value!);
                                  },
                                ),
                              ),
                            ),




                          ],
                        ),

                        SizedBox(height: 20,),


                        controller.estateIdList.isNotEmpty
                            ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.2),
                                border: Border.all(width: 1,color: AppColors.primaryColor)
                            ),
                            padding: EdgeInsets.only(left: 5,right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Txt("Total Estate Selected ",fontSize: 17,fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Txt("${homeController.selectedEstateList.length}",fontSize: 18,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                            : Container(),

                        SizedBox(height: 30,),

                        MessageSwitchContainer(
                          title: "Whatsapp message",
                          switchValue: controller.isWhatsApp,
                          valueChanged: (value){
                            //print("Whatsapp  $value");
                            controller.updateIsWhatsApp(value);
                            controller.updateIsText(false);
                          }
                        ),

                        MessageSwitchContainer(
                          title: "Text message",
                          switchValue: controller.isText,
                          valueChanged: (value){
                            //print("Text  $value");
                            controller.updateIsText(value);
                            controller.updateIsWhatsApp(false);
                          }
                        ),

                        SizedBox(height: 30,),

                        RoundedButtonWidget(
                          text: "Send Message",
                          height: 45,
                          width: Get.width/2,
                          onPressed: () {

                            if(formKey.currentState!.validate()){
                              if(queryController.isText == false  && queryController.isWhatsApp == false ){
                                AppCommonFunction.flutterToast("please select any message method", false);
                              }
                              else{
                                sendSMS();
                              }
                            }

                          },
                        ),


                        /*Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Txt("Whatsapp Quries",fontSize: 22,color: AppColors.black,fontWeight: FontWeight.w600),)
                      ),

                      Expanded(
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(top: 3,bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Txt("Query $index",fontSize: 18,color: AppColors.black,fontWeight: FontWeight.w600),

                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1,color: Colors.red),
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 5,bottom: 5),
                                      child: Txt("Pending",color: Colors.red),
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      border: Border.all(width: 1,color: Colors.red),
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12.0,right: 12,top: 5,bottom: 5),
                                      child: Txt("Update",color: Colors.white),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                        ),
                      ),
*/

                      ],
                    ),

                    controller.isDataLoading
                    ? AppCommonFunction.circularIndicator()
                    : Container(),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget MessageSwitchContainer({required String title,required bool switchValue,required ValueChanged valueChanged}){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0,top: 10,bottom: 10),
            child: Txt(title,fontSize: 15,fontWeight: FontWeight.w500),
          ),

          Switch(
            value: switchValue,
            activeColor: AppColors.primaryColor,
            onChanged: valueChanged
          ),
        ],
      ),
    );
  }


  sendSMS(){
    queryController.progressDataLoading(true);

    queryController.sendMessageApi(
      token: PreferenceHelper().getUserData().authToken!,
      phNumber: numberController.text,
      sms: queryController.isText,
      whatsApp: queryController.isWhatsApp,
      estateId: queryController.estateIdList,
    ).then((response) {
      if(response != null){
        if(response.success.toString() == "true"){
          AppCommonFunction.flutterToast(response.message, true);
          Get.offAll(()=> DashboardScreenUI() );
          clearData();
          queryController.progressDataLoading(false);
        }
        else{
          AppCommonFunction.flutterToast(response.error![0], false);
          queryController.progressDataLoading(false);
        }
      }

    });

  }

  clearData(){
    numberController.clear();
    queryController.estateIdList.clear();
    queryController.updateIsText(false);
    queryController.updateIsWhatsApp(false);

    homeController.estateList.clear();
    homeController.newEstateList.clear();
    homeController.selectedEstateList.clear();

    setState((){});

  }
}
