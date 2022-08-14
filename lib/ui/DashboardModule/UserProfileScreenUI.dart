import 'package:croma_brokrage/ui/AreaPropertyScreenUI.dart';
import 'package:croma_brokrage/widgets/RoundedButtonWidget.dart';
import 'package:croma_brokrage/widgets/Txt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/ViewBrokerProfileController.dart';
import '../../helper/PreferenceHelper.dart';
import '../../utils/AppCommonFunction.dart';
import '../../utils/AppString.dart';
import '../ChatModule/ChatContactListScreenUI.dart';

class UserProfileScreenUI extends StatefulWidget {
  const UserProfileScreenUI({Key? key}) : super(key: key);

  @override
  State<UserProfileScreenUI> createState() => _UserProfileScreenUIState();
}

class _UserProfileScreenUIState extends State<UserProfileScreenUI> {
  
  ViewBrokerProfileController viewBrokerProfileController = Get.put(ViewBrokerProfileController());

  @override
  void initState() {
    super.initState();
    getBrokerProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: Get.height,
              width: Get.width,
              child: GetBuilder(
                init: ViewBrokerProfileController(),
                builder: (ViewBrokerProfileController controller) {
                  return controller.isDataLoading
                    ? Center(child: AppCommonFunction.circularIndicator(),)
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SizedBox(height: 20),

                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.account_circle,size: 100),
                        ),
                        SizedBox(height: 40),

                        Txt(viewBrokerProfileController.brokerProfileData!.name.toString(),fontSize: 22,fontWeight: FontWeight.w600),
                        SizedBox(height: 8),
                        Txt(viewBrokerProfileController.brokerProfileData!.mobile.toString(),fontSize: 20,fontWeight: FontWeight.w500),

                        SizedBox(height: 15),

                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFC8862),
                            //borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              StateContainer(title: "Estates", value: viewBrokerProfileController.brokerProfileData!.estates.toString()),
                              InkWell(
                                onTap: () {
                                  Get.to(()=> ChatContactListScreenUI() );
                                },
                                child: StateContainer(title: "Contacts", value: viewBrokerProfileController.brokerProfileData!.contacts.toString())),
                              StateContainer(title: "Balance", value: viewBrokerProfileController.brokerProfileData!.balance.toString()),
                            ],
                          ),
                        ),


                        viewBrokerProfileController.brokerProfileData!.area!.isEmpty
                            ? Container()
                            : Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            child: Txt("Area",fontSize: 20,fontWeight: FontWeight.w600,)),

                        viewBrokerProfileController.brokerProfileData!.area!.isEmpty
                            ? Container()
                            : Container(
                          height: 140,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: viewBrokerProfileController.brokerProfileData!.area!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 10,
                                  color: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    height: 140,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      image: DecorationImage(image: AssetImage(AppString.imagesBackgroundPath+"ic_area_bg.jpg",),fit: BoxFit.cover),
                                    ),
                                    child: Center(child: Txt("${viewBrokerProfileController.brokerProfileData!.area![index]}",fontSize: 30,fontWeight: FontWeight.w600,color: Colors.white)),
                                  ),

                                ),
                              );
                            },),
                        ),

                        SizedBox(height: 15,),

                        viewBrokerProfileController.brokerProfileData!.estate_type!.isEmpty
                            ? Container()
                            : Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            child: Txt("Type",fontSize: 20,fontWeight: FontWeight.w600,)),

                        viewBrokerProfileController.brokerProfileData!.estate_type!.isEmpty
                            ? Container()
                            : Container(
                          height: 140,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: viewBrokerProfileController.brokerProfileData!.estate_type!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 10,
                                  color: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    height: 140,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      image: DecorationImage(image: AssetImage(AppString.imagesBackgroundPath+"ic_type_bg.jpg",),fit: BoxFit.cover),
                                    ),
                                    child: Center(child: Txt("${viewBrokerProfileController.brokerProfileData!.estate_type![index]}",fontSize: 30,fontWeight: FontWeight.w600,color: Colors.white)),
                                  ),

                                ),
                              );
                            },),
                        ),



                        viewBrokerProfileController.brokerProfileData!.estate_type!.isEmpty && viewBrokerProfileController.brokerProfileData!.area!.isEmpty
                          ? Expanded(
                            child: Center(
                              child: RoundedButtonWidget(height: 45, width: Get.width/2, text: "Please Enter details", onPressed: (){
                                Get.offAll(()=> AreaPropertyScreenUI());
                              }),
                            ),
                          )
                          : Container(),

                        SizedBox(height: 100),

                      ]
                  );
                },

              ),
            ),


          ),
        ),
      ),
    );
  }

  Widget StateContainer({required String title,required String value}){
    return Column(
      children: [
        Txt(title,fontSize: 20,fontWeight: FontWeight.w500),
        SizedBox(height: 8),
        Txt(value,fontSize: 17,fontWeight: FontWeight.w500),
      ],
    );
  }

  getBrokerProfile(){
    viewBrokerProfileController.progressDataLoading(true);

    viewBrokerProfileController.brokerProfileApi(token: PreferenceHelper().getUserData().authToken!,).then((value) {

      if(value != null){
        if(value.success.toString() == "true"){
          if(value.data != null ){
            viewBrokerProfileController.brokerProfileData = value.data;
            viewBrokerProfileController.progressDataLoading(false);
          }
        }
        else{
          AppCommonFunction.flutterToast("Something went wrong", false);
        }

      }
      else{
        AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
      }

    });
  }
}
