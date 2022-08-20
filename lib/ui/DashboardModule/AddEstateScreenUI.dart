import 'package:croma_brokrage/controller/AddEstateController.dart';
import 'package:croma_brokrage/controller/HomeController.dart';
import 'package:croma_brokrage/ui/DashboardModule/DashboardScreenUI.dart';
import 'package:croma_brokrage/utils/AppColors.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/widgets/RoundedButtonWidget.dart';
import 'package:croma_brokrage/widgets/ScaffoldWidget.dart';
import 'package:croma_brokrage/widgets/TextFormInputField.dart';
import 'package:croma_brokrage/widgets/Txt.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/PreferenceHelper.dart';
import '../../utils/FieldValidator.dart';

class AddEstateScreenUI extends StatefulWidget {
  const AddEstateScreenUI({Key? key}) : super(key: key);

  @override
  State<AddEstateScreenUI> createState() => _AddEstateScreenUIState();
}

class _AddEstateScreenUIState extends State<AddEstateScreenUI> {

  String cityDropDownVal = "Select City";
  int radioListVal = 0;
  final formKey = GlobalKey<FormState>();
  AddEstateController addEstateController = Get.put(AddEstateController());
  HomeController homeController = Get.put(HomeController());
  TextEditingController whatsAppMsgController = TextEditingController(text: "   ");

  FlipCardController flipCardController = FlipCardController();

  final flatKey = GlobalKey<FlipCardState>();
  final shopKey = GlobalKey<FlipCardState>();
  final bunglowKey = GlobalKey<FlipCardState>();
  final rowHouseKey = GlobalKey<FlipCardState>();
  final landKey = GlobalKey<FlipCardState>();
  final plotKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
    getFilterApi();
  }
  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: SingleChildScrollView(
        child: GetBuilder(
          init: AddEstateController(),
          builder: (AddEstateController controller) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Txt("Create by Whatsapp",fontSize: 20,color: AppColors.black,fontWeight: FontWeight.w600),

                      TextFormInputField(
                        controller: whatsAppMsgController,
                        hintText: "  Enter whatsapp message",
                        minLine: 3,
                        maxLine: 5,
                        borderRadius: 10,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: RoundedButtonWidget(
                          height: 40,
                          width: 60,
                          text: "Add",
                          onPressed: () {
                            if(whatsAppMsgController.text.toString().length >= 2){
                              onChangeWhatsAppMsg(whatsAppMsgController.text.toString());
                            }
                        },),
                      ),
                      Txt("Property Type",fontSize: 20,color: AppColors.black,fontWeight: FontWeight.w600),

                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          estateTypeContainer(
                            text: "SHOP",
                            onTap: () {
                              addEstateController.updateEstateType( "SHOP");
                            },
                          ),
                          estateTypeContainer(
                            text: "LAND",
                            onTap: () {
                              addEstateController.updateEstateType( "LAND");
                            },
                          ),
                          estateTypeContainer(
                            text: "PLOT",
                            onTap: () {
                              addEstateController.updateEstateType( "PLOT");
                            },
                          ),

                        ],
                      ),

                      SizedBox(height: 15,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          estateTypeContainer(
                            text: "FLAT",
                            onTap: () {
                              addEstateController.updateEstateType( "FLAT");
                            },
                          ),
                          estateTypeContainer(
                            text: "BUNGALOW",
                            onTap: () {
                              addEstateController.updateEstateType( "BUNGALOW");
                            },
                          ),
                          estateTypeContainer(
                            text: "ROW HOUSE",
                            onTap: () {
                              addEstateController.updateEstateType( "ROW HOUSE");
                            },
                          ),


                        ],
                      ),

                      SizedBox(height: 30,),


                      Txt("Property Status",fontSize: 20,color: AppColors.black,fontWeight: FontWeight.w600),
                      SizedBox(height: 15,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          estateTypeContainer(
                            text: "BUY",
                            onTap: () {
                              addEstateController.updateEstateStatus("BUY");
                            },
                          ),
                          estateTypeContainer(
                            text: "SELL",
                            onTap: () {
                              addEstateController.updateEstateStatus("SELL");
                            },
                          ),
                          estateTypeContainer(
                            text: "RENT",
                            onTap: () {
                              addEstateController.updateEstateStatus("RENT");
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

                      AppCommonFunction.FormContainer(addEstateController.sizeController,"Size (sqft)"),

                      SizedBox(height: 5,),


                      controller.estateStatus !=  "RENT"
                        ? Container()
                        : TextFormInputField(
                        controller: addEstateController.rentstatusController,
                        hintText: "available or required",
                        validator: (value) {
                          return FieldValidator.validateRentValue(value!,addEstateController.estateStatus);
                        },
                      ),

                      controller.estateStatus !=  "RENT"
                          ? Container()
                          : SizedBox(height: 5,),

                      /*Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          return _kOptions.where((String option) {
                            return option.contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          debugPrint('You just selected $selection');
                        },
                      ),*/

                      TextFormInputField(
                        controller: addEstateController.areaController,
                        hintText: "Area",
                        validator: (value) {
                          return FieldValidator.validateValueIsEmpty(value!);
                        },
                      ),

                      SizedBox(height: 5,),

                      AppCommonFunction.TextFormContainer(addEstateController.societyController,"Society"),

                      SizedBox(height: 5,),

                      TextFormInputField(
                        controller: controller.budgetController,
                        hintText: "Budget (in Lakhs)",
                      ),

                      SizedBox(height: 5,),

                      controller.estateType !=  "FLAT" && controller.estateType !=  "BUNGALOW" && controller.estateType !=  "ROW HOUSE"
                        ? Container()
                        : TextFormInputField(
                          controller: controller.noOfBedroomController,
                          hintText: "Number Of Bedrooms",
                          keyboardType: TextInputType.number,
                        ),

                      controller.estateType !=  "FLAT" && controller.estateType !=  "BUNGALOW" && controller.estateType !=  "ROW HOUSE"
                          ? Container()
                          : SizedBox(height: 50,),


                      Center(
                        child: RoundedButtonWidget(
                          text: "Add",
                          height: 45,
                          width: Get.width/1.5,
                          onPressed: () {

                            if(formKey.currentState!.validate()){
                              if(controller.estateStatus == ""){
                                AppCommonFunction.flutterToast("Please select status", false);
                              }
                              else if(controller.estateType == ""){
                                AppCommonFunction.flutterToast("Please select Estate Type", false);
                              }
                              else{
                                addEstate();
                              }
                            }


                          },
                        ),
                      ),

                    ],
                  ),
                ),

                controller.isDataLoading
                  ? AppCommonFunction.circularIndicator()
                  : Container(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget estateTypeContainer({required String text,GestureTapCallback? onTap,}){
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width/3.8,
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: addEstateController.estateType.toUpperCase() == text.toUpperCase()  || addEstateController.estateStatus.toUpperCase() == text.toUpperCase() ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: AppColors.primaryColor,width: 1.5)
        ),
        child: Txt(text,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: addEstateController.estateType.toUpperCase() == text.toUpperCase() || addEstateController.estateStatus.toUpperCase() == text.toUpperCase() ? Colors.white : Colors.black87),
      ),
    );
  }

  onChangeWhatsAppMsg(String val){
    print("STRIx4NG  :: ${val}");
    addEstateController.progressDataLoading(true);
    addEstateController.enterWhatsAppMsgApi(
      token: PreferenceHelper().getUserData().authToken,
      message: whatsAppMsgController.text,
    ).then((response){
      if(response != null){
        addEstateController.readByWhatsApp = response;

        if(addEstateController.readByWhatsApp["data"][0]["number_of_bedrooms"].toString() != "null"){
          //print("BEDROOMMM  : ${addEstateController.readByWhatsApp["data"][0]["number_of_bedrooms"][0].toString()}");
          addEstateController.updateNoOfBedrooms(addEstateController.readByWhatsApp["data"][0]["number_of_bedrooms"][0].toString());
        }
        if(addEstateController.readByWhatsApp["data"][0]["area"].toString() != "null"){
          //print("BEDROOMMM  : ${addEstateController.readByWhatsApp["data"][0]["area"][0].toString()}");
          addEstateController.updateAreaController(addEstateController.readByWhatsApp["data"][0]["area"][0].toString());
        }
        if(addEstateController.readByWhatsApp["data"][0]["floor_space"].toString() != "null"){
          //print("BEDROOMMM  : ${addEstateController.readByWhatsApp["data"][0]["floor_space"][0].toString()}");
          addEstateController.updateSizeController(addEstateController.readByWhatsApp["data"][0]["floor_space"][0].toString());
        }
        if(addEstateController.readByWhatsApp["data"][0]["estate_status"].toString() != "null"){
          //print("BEDROOMMM  : ${addEstateController.readByWhatsApp["data"][0]["estate_status"][0].toString()}");
          addEstateController.updateEstateStatus(addEstateController.readByWhatsApp["data"][0]["estate_status"][0].toString().toUpperCase());
        }
        if(addEstateController.readByWhatsApp["data"][0]["estate_type"].toString() != "null"){
          //print("BEDROOMMM  : ${addEstateController.readByWhatsApp["data"][0]["estate_type"][0].toString()}");
          addEstateController.updateEstateType(addEstateController.readByWhatsApp["data"][0]["estate_type"][0].toString().toUpperCase());
        }
        if(addEstateController.readByWhatsApp["data"][0]["budget"].toString() != "null"){
          //print("BEDROOMMM  : ${addEstateController.readByWhatsApp["data"][0]["estate_type"][0].toString()}");
          addEstateController.updateEstateBudget(addEstateController.readByWhatsApp["data"][0]["budget"][0].toString().toUpperCase());
        }
        if(addEstateController.readByWhatsApp["data"][0]["apartment"].toString() != "null"){
          //print("BEDROOMMM  : ${addEstateController.readByWhatsApp["data"][0]["estate_type"][0].toString()}");
          addEstateController.updateEstateSociety(addEstateController.readByWhatsApp["data"][0]["apartment"][0].toString().toUpperCase());
        }

        addEstateController.progressDataLoading(false);
      }
    });


  }

  getFilterApi(){
    homeController.filterApi(token: PreferenceHelper().getUserData().authToken!).then((value){

    });
  }

  addEstate(){
    addEstateController.progressDataLoading(true);

    print("No bedroom ::  ${addEstateController.noOfBedroomController.text}");

    addEstateController.addEstateApi(
      token: PreferenceHelper().getUserData().authToken,
      floor_space: addEstateController.sizeController.text,
      area: addEstateController.areaController.text,
      budget: int.parse(addEstateController.budgetController.text),
      society: addEstateController.societyController.text,
      estate_status: addEstateController.estateStatus,
      rent_status:addEstateController.rentstatusController.text, 
      city: "surat",
      no_of_bedroom: addEstateController.noOfBedroomController.text.isEmpty ? 0 : int.parse(addEstateController.noOfBedroomController.text),
      estate_type: addEstateController.estateType
    ).then((resposne) {

      if(resposne.success == true){
        AppCommonFunction.flutterToast(resposne.message, true);
        Get.offAll(DashboardScreenUI());
      }
      else{
        AppCommonFunction.flutterToast(resposne.error![0], false);
      }

      addEstateController.progressDataLoading(false);

    });

  }

  clearData(){
    addEstateController.sizeController.clear();
    addEstateController.budgetController.clear();
    addEstateController.societyController.clear();
    addEstateController.areaController.clear();
    addEstateController.noOfBedroomController.clear();
  }


}

