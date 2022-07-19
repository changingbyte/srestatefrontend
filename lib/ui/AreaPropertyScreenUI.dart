import 'package:croma_brokrage/controller/AreaPropertyController.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/utils/AppString.dart';
import 'package:croma_brokrage/widgets/RoundedButtonWidget.dart';
import 'package:croma_brokrage/widgets/TextFormInputField.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:croma_brokrage/utils/AppColors.dart';

import '../helper/PreferenceHelper.dart';
import '../widgets/Txt.dart';
import 'DashboardModule/DashboardScreenUI.dart';

class AreaPropertyScreenUI extends StatefulWidget {
  const AreaPropertyScreenUI({Key? key}) : super(key: key);

  @override
  _AreaPropertyScreenUIState createState() => _AreaPropertyScreenUIState();
}

class _AreaPropertyScreenUIState extends State<AreaPropertyScreenUI> {

  AreaPropertyController areaPropertyController = Get.put(AreaPropertyController());
  TextEditingController nameController = new TextEditingController();


  @override
  void initState() {
    super.initState();
    areaPropertyController.progressDataLoading(true);
    apiCall();
  }

  apiCall(){
    AppCommonFunction.checkInternet().then((value) {
      if(value){
        getAreaListApi();

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
        appBar: AppBar(
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
          title: Text(""),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder(
            init: AreaPropertyController(),
            builder: (AreaPropertyController controller) {
              return
                controller.isDataLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 20,),

                  TextFormInputField(
                    controller: nameController,
                    hintText: "Enter Your Name",
                    onChanged: (val){
                      //getAreaListApi();
                    },
                  ),

                  SizedBox(height: 20,),

                  Txt("Area", fontSize: 20,fontWeight: FontWeight.bold),

                  SizedBox(height: 20,),

                  Expanded(
                    child: areaPropertyController.areaList.length < 1
                        ? Center(child: Txt("No Data Found!",fontSize: 20,fontWeight: FontWeight.w600),)
                        : GridView.builder(
                      itemCount: areaPropertyController.areaList.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3.5 / 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                          itemBuilder: (context, index) {
                        return FlipCard(
                          flipOnTouch: true,
                          onFlipDone: (flip){
                            if(flip){
                              areaPropertyController.selectedAreaList.add(areaPropertyController.areaList[index]["area_name"].toString());
                            }
                            else{
                              areaPropertyController.selectedAreaList.remove(areaPropertyController.areaList[index]["area_name"].toString());
                            }
                            print("AREA  ::  ${areaPropertyController.selectedAreaList}");
                          },
                          front: CardCommonContainer(
                              text: areaPropertyController.areaList[index]["area_name"].toString(),
                              color: Colors.transparent,
                              index: index),
                          back: CardCommonContainer(
                              text: areaPropertyController.areaList[index]["area_name"].toString(),
                              color: AppColors.primaryColor,
                              index: index),
                        );
                      },
                    ),
                  ),

                  Txt("Estate Type",fontSize: 20,fontWeight: FontWeight.bold),

                  SizedBox(height: 20,),

                  Expanded(
                    child:
                    areaPropertyController.estateTypeList.length < 1
                        ? Center(child: Txt("No Data Found!",fontSize: 20,fontWeight: FontWeight.w600),)
                        : GridView.builder(
                          itemCount: areaPropertyController.estateTypeList.length,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3.5 / 1,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                          itemBuilder: (context, index) {
                          return FlipCard(
                          flipOnTouch: true,
                          onFlipDone: (flip){
                            if(flip){
                              areaPropertyController.selectedEstateTypeList.add(areaPropertyController.estateTypeList[index]["type_name"].toString());
                            }
                            else{
                              areaPropertyController.selectedEstateTypeList.remove(areaPropertyController.estateTypeList[index]["type_name"].toString());
                            }
                            print("Estate Type  ::  ${areaPropertyController.selectedEstateTypeList}");

                          },
                          front: CardCommonContainer(
                              text: areaPropertyController.estateTypeList[index]["type_name"].toString(),
                              color: Colors.transparent,
                              index: index,
                          ),
                          back: CardCommonContainer(
                              text: areaPropertyController.estateTypeList[index]["type_name"].toString(),
                              color: AppColors.primaryColor,
                              index: index
                          ),
                        );
                      },
                    ),
                  ),


                  SizedBox(height: 10,),


                  Center(
                    child: RoundedButtonWidget(
                      text: "Submit",
                      height: 45,
                      width: Get.width/2.5,
                      onPressed:  () {

                        //Get.to(()=> MainScreenUI() );
                        onSubmitCreateUser();

                      },
                    ),
                  ),


                  SizedBox(height: 30,),

                ],
              );
            },
          ),
        ),
      ),
    );
  }


  Widget CardCommonContainer({required String text,required Color color, required int index,}){
    return  Container(
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Center(
        child: Txt(text,fontSize: 17,color: color == Colors.transparent ? AppColors.primaryColor : Colors.white,fontWeight: FontWeight.w600),
      ),
    );
  }


  getAreaListApi(){
      areaPropertyController.areaListApi(token: PreferenceHelper().getUserData().authToken!).then((value) {

        if(value != null){
          areaPropertyController.areaList = value["data"];
        }
        else{
          AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
        }

      }).whenComplete(() {
        getEstateTypeListApi();
      });
  }

  getEstateTypeListApi(){
    areaPropertyController.estateTypeListApi(token: PreferenceHelper().getUserData().authToken!).then((value) {
      if(value != null){
        areaPropertyController.estateTypeList = value['data'];
        areaPropertyController.progressDataLoading(false);
      }
      else{
        AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
      }

    });
  }

  onSubmitCreateUser(){
    areaPropertyController.createBrokerApi(
      token: PreferenceHelper().getUserData().authToken!,
      name: nameController.text,
      area: areaPropertyController.selectedAreaList,
      estate_type: areaPropertyController.selectedEstateTypeList
    ).then((value) {
      if(value != null){
        if(value["success"] == true){
          AppCommonFunction.flutterToast(value["message"], true);
          clearData();
          Get.to( ()=> DashboardScreenUI() );
        }
        else{
          AppCommonFunction.flutterToast(value["message"], false);
        }
        //areaPropertyController.progressDataLoading(false);
      }
      else{
        AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
      }

    });
  }

  clearData(){
    nameController.clear();
    areaPropertyController.selectedAreaList.clear();
    areaPropertyController.selectedEstateTypeList.clear();
  }

}
