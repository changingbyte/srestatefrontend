import 'package:croma_brokrage/controller/AddEstateController.dart';
import 'package:croma_brokrage/ui/DashboardModule/DashboardScreenUI.dart';
import 'package:croma_brokrage/utils/AppColors.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/widgets/RoundedButtonWidget.dart';
import 'package:croma_brokrage/widgets/TextFormInputField.dart';
import 'package:croma_brokrage/widgets/Txt.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/PreferenceHelper.dart';

class AddEstateScreenUI extends StatefulWidget {
  const AddEstateScreenUI({Key? key}) : super(key: key);

  @override
  State<AddEstateScreenUI> createState() => _AddEstateScreenUIState();
}

class _AddEstateScreenUIState extends State<AddEstateScreenUI> {

  String cityDropDownVal = "Select City";
  int radioListVal = 0;

  AddEstateController addEstateController = Get.put(AddEstateController());

  TextEditingController sizeController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController societyController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController noOfBedroomController = TextEditingController();

  FlipCardController flipCardController = FlipCardController();

  final flatKey = GlobalKey<FlipCardState>();
  final shopKey = GlobalKey<FlipCardState>();
  final bunglowKey = GlobalKey<FlipCardState>();
  final rowHouseKey = GlobalKey<FlipCardState>();
  final landKey = GlobalKey<FlipCardState>();
  final plotKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Txt("Add Estate",color: Colors.white,fontSize: 18),
          backgroundColor: AppColors.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GetBuilder(
              init: AddEstateController(),
              builder: (AddEstateController controller) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Txt("Property Type",fontSize: 20,color: AppColors.black,fontWeight: FontWeight.w600),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            FlipCard(
                              key: flatKey,
                              front: EstateTypeContainer(text: "FLAT",color: Colors.red,controller: controller,bgColor: Colors.white),
                              back: EstateTypeContainer(text: "FLAT",color: Colors.red,controller: controller,bgColor: AppColors.redColor),
                              onFlip: (){
                                if(!flatKey.currentState!.isFront){
                                  controller.estateType = "FLAT";
                                }
                                else{
                                  controller.estateType = "";
                                }

                                if(!shopKey.currentState!.isFront){shopKey.currentState!.toggleCard();}
                                if(!bunglowKey.currentState!.isFront){bunglowKey.currentState!.toggleCard();}
                                if(!rowHouseKey.currentState!.isFront){rowHouseKey.currentState!.toggleCard();}
                                if(!landKey.currentState!.isFront){landKey.currentState!.toggleCard();}
                                if(!plotKey.currentState!.isFront){plotKey.currentState!.toggleCard();}
                              },
                            ),

                            FlipCard(
                              key: shopKey,
                              front: EstateTypeContainer(text: "Shop",color: Colors.red,controller: controller,bgColor: Colors.white),
                              back: EstateTypeContainer(text: "Shop",color: Colors.red,controller: controller,bgColor: AppColors.redColor),
                              onFlip: (){
                                if(!shopKey.currentState!.isFront){
                                  controller.estateType = "Shop";
                                }
                                else{
                                  controller.estateType = "";
                                }
                                if(!flatKey.currentState!.isFront){flatKey.currentState!.toggleCard();}
                                if(!bunglowKey.currentState!.isFront){bunglowKey.currentState!.toggleCard();}
                                if(!rowHouseKey.currentState!.isFront){rowHouseKey.currentState!.toggleCard();}
                                if(!landKey.currentState!.isFront){landKey.currentState!.toggleCard();}
                                if(!plotKey.currentState!.isFront){plotKey.currentState!.toggleCard();}
                              },
                            ),
                            FlipCard(
                                key: bunglowKey,
                                front: EstateTypeContainer(text: "Bunglow",color: Colors.red,controller: controller,bgColor: Colors.white),
                                back: EstateTypeContainer(text: "Bunglow",color: Colors.red,controller: controller,bgColor: AppColors.redColor),
                                onFlip: (){
                                  if(!bunglowKey.currentState!.isFront){
                                    controller.estateType = "Bunglow";
                                  }
                                  else{
                                    controller.estateType = "";
                                  }
                                  if(!flatKey.currentState!.isFront){flatKey.currentState!.toggleCard();}
                                  if(!shopKey.currentState!.isFront){shopKey.currentState!.toggleCard();}
                                  if(!rowHouseKey.currentState!.isFront){rowHouseKey.currentState!.toggleCard();}
                                  if(!landKey.currentState!.isFront){landKey.currentState!.toggleCard();}
                                  if(!plotKey.currentState!.isFront){plotKey.currentState!.toggleCard();}
                                },
                            ),

                          ],
                        ),

                        SizedBox(height: 15,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlipCard(
                              key: rowHouseKey,
                                front: EstateTypeContainer(text: "Row house",color: Colors.red,controller: controller,bgColor: Colors.white),
                                back: EstateTypeContainer(text: "Row house",color: Colors.red,controller: controller,bgColor: AppColors.redColor),
                                onFlip: (){
                                  if(!rowHouseKey.currentState!.isFront){
                                    controller.estateType = "Row house";
                                  }
                                  else{
                                    controller.estateType = "";
                                  }
                                  if(!flatKey.currentState!.isFront){flatKey.currentState!.toggleCard();}
                                  if(!bunglowKey.currentState!.isFront){bunglowKey.currentState!.toggleCard();}
                                  if(!shopKey.currentState!.isFront){shopKey.currentState!.toggleCard();}
                                  if(!landKey.currentState!.isFront){landKey.currentState!.toggleCard();}
                                  if(!plotKey.currentState!.isFront){plotKey.currentState!.toggleCard();}
                                },
                            ),
                            FlipCard(
                              key: landKey,
                                front: EstateTypeContainer(text: "Land",color: Colors.red,controller: controller,bgColor: Colors.white),
                                back: EstateTypeContainer(text: "Land",color: Colors.red,controller: controller,bgColor: AppColors.redColor),
                              onFlip: (){
                                if(!landKey.currentState!.isFront){
                                  controller.estateType = "Land";
                                }
                                else{
                                  controller.estateType = "";
                                }
                                if(!flatKey.currentState!.isFront){flatKey.currentState!.toggleCard();}
                                if(!bunglowKey.currentState!.isFront){bunglowKey.currentState!.toggleCard();}
                                if(!rowHouseKey.currentState!.isFront){rowHouseKey.currentState!.toggleCard();}
                                if(!shopKey.currentState!.isFront){shopKey.currentState!.toggleCard();}
                                if(!plotKey.currentState!.isFront){plotKey.currentState!.toggleCard();}
                              },
                            ),
                            FlipCard(
                              key: plotKey,
                                front: EstateTypeContainer(text: "Plot",color: Colors.red,controller: controller,bgColor: Colors.white),
                                back: EstateTypeContainer(text: "Plot",color: Colors.red,controller: controller,bgColor: AppColors.redColor),
                              onFlip: (){
                                if(!plotKey.currentState!.isFront){
                                  controller.estateType = "Plot";
                                }
                                else{
                                  controller.estateType = "";
                                }
                                if(!flatKey.currentState!.isFront){flatKey.currentState!.toggleCard();}
                                if(!bunglowKey.currentState!.isFront){bunglowKey.currentState!.toggleCard();}
                                if(!rowHouseKey.currentState!.isFront){rowHouseKey.currentState!.toggleCard();}
                                if(!shopKey.currentState!.isFront){shopKey.currentState!.toggleCard();}
                                if(!landKey.currentState!.isFront){landKey.currentState!.toggleCard();}
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 30,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Txt("Details",fontSize: 20,color: AppColors.black,fontWeight: FontWeight.w600),
                            Icon(Icons.info_rounded,),
                          ],
                        ),

                        SizedBox(height: 5,),

                        AppCommonFunction.FormContainer(sizeController,"Size (sqft)"),

                        SizedBox(height: 5,),

                        Container(
                          padding: EdgeInsets.only(left: 8,right: 8),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton(
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down_circle,
                              color: AppColors.primaryColor,
                            ),
                            items: [
                              DropdownMenuItem(value: "sell", child: Text("sell")),
                              DropdownMenuItem(value: "buy", child: Text("buy")),
                              DropdownMenuItem(value: "rent", child: Text("rent")),
                            ],
                            hint: Txt(controller.estateStatusVal,color: AppColors.primaryColor,fontWeight: FontWeight.w600,fontSize: 18,
                            ),
                            onChanged: (value) {
                              setState(() {
                                controller.estateStatusVal = value.toString();

                                if(radioListVal  == 3){
                                  cityDropDownVal = "Select Designation";
                                }


                              });
                            },
                          ),
                        ),


                        SizedBox(height: 5,),

                        AppCommonFunction.TextFormContainer(areaController,"Area"),

                        SizedBox(height: 5,),

                        AppCommonFunction.TextFormContainer(societyController,"Society"),

                        SizedBox(height: 5,),

                        TextFormInputField(
                          controller: budgetController,
                          hintText: "Budget (in Lakhs)",
                        ),

                        SizedBox(height: 5,),

                        TextFormInputField(
                          controller: noOfBedroomController,
                          hintText: "Number Of Badrooms",
                          keyboardType: TextInputType.number,
                        ),


                        SizedBox(height: 50,),


                        Center(
                          child: RoundedButtonWidget(
                            text: "Add",
                            height: 45,
                            width: Get.width/1.5,
                            onPressed: () {
                              addEstate();
                            },
                          ),
                        ),



                      ],
                    ),

                    controller.isDataLoading
                      ? AppCommonFunction.circularIndicator()
                      : Container(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget EstateTypeContainer({required String text,required Color color,required AddEstateController controller,required Color bgColor}){
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: color),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Center(
        child: Txt(text,fontSize: 15,color:bgColor == AppColors.redColor ? Colors.white : AppColors.redColor ,fontWeight: FontWeight.w600),
      ),
    );
  }



  addEstate(){

    addEstateController.progressDataLoading(true);

    addEstateController.addEstateApi(
      token: PreferenceHelper().getUserData().authToken,
      floor_space: sizeController.text,
      area: areaController.text,
      budget: budgetController.text,
      society: societyController.text,
      estate_status: addEstateController.estateStatusVal,
      city: "surat",
      no_of_bedroom: noOfBedroomController.text,
      estate_type: addEstateController.estateType
    ).then((resposne) {

      if(resposne.success == true){
        AppCommonFunction.flutterToast(resposne.message, true);
        Get.offAll(DashboardScreenUI());
      }
      else{
        AppCommonFunction.flutterToast(resposne.message, false);
      }



      addEstateController.progressDataLoading(false);

    });

  }

  clearData(){
    sizeController.clear();
    budgetController.clear();
    societyController.clear();
    areaController.clear();
    noOfBedroomController.clear();
    addEstateController.updateEstateStatusVal("Status");
  }


  cardCondition(){
    if(!shopKey.currentState!.isFront){shopKey.currentState!.toggleCard();}
    if(!bunglowKey.currentState!.isFront){bunglowKey.currentState!.toggleCard();}
    if(!rowHouseKey.currentState!.isFront){rowHouseKey.currentState!.toggleCard();}
    if(!landKey.currentState!.isFront){landKey.currentState!.toggleCard();}
    if(!plotKey.currentState!.isFront){plotKey.currentState!.toggleCard();}
  }
  
}
