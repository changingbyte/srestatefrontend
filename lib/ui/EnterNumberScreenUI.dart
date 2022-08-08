import 'dart:convert';

import 'package:croma_brokrage/controller/OnbordingController.dart';
import 'package:croma_brokrage/utils/AppColors.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/utils/AppString.dart';
import 'package:croma_brokrage/utils/FieldValidator.dart';
import 'package:croma_brokrage/utils/PrefUtils.dart';
import 'package:croma_brokrage/widgets/TextFormInputField.dart';
import 'package:croma_brokrage/widgets/WidgetButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

import '../helper/PreferenceHelper.dart';
import '../widgets/Txt.dart';
import 'EnterOtpScreenUI.dart';

class EnterNumberScreenUI extends StatefulWidget {
  const EnterNumberScreenUI({Key? key}) : super(key: key);

  @override
  State<EnterNumberScreenUI> createState() => _EnterNumberScreenUIState();
}

class _EnterNumberScreenUIState extends State<EnterNumberScreenUI> {

  FocusNode _focusNode1 = FocusNode();
  OnBoardingController onBoardingController = Get.put(OnBoardingController());
  final formKey = GlobalKey<FormState>();
  TextEditingController numberController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(AppColors.primaryColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width:  Get.width,
                  height:  Get.height,
                  //decoration: AppCommonFunction.defaultBackground(),
                  child: Column(
                    children: [
                      topContainer(),
                      middleContainer(),


                    ],

                  ),
                ),
                progressWidget(),
              ],
            ),
          )),
    );
  }


  Widget topContainer() {
    return Container(
      margin: EdgeInsets.only(left: 24.0,right: 12.0,top: Get.width/10),
      child: AppCommonFunction.logoTextContainer("ic_main_logo.png",200,180),);
  }

  Widget middleContainer() {
    return Column(
      children: [
        new Txt("Enter Phone number ",
            fontSize: 22.0,fontWeight: FontWeight.w600,color: AppColors.primaryColor),
        SizedBox(height: 20,),
        Container(
          margin: EdgeInsets.only(left: 24,right: 24),
          child: new Txt("Enter your Number and get OTP on your device",maxLines: 2,
              fontSize: 14.0,fontWeight: FontWeight.w400,color: AppColors.primaryColor
          ),
        ),
        formContainer(),
      ],
    );
  }

  Widget formContainer() {
    return GetBuilder(
      init: OnBoardingController(),
      builder: (OnBoardingController controller) {

        return Container(
          child: new Form(
              key: formKey,
              child: Column(
                children: [

                  Container(
                      margin: EdgeInsets.only(top:18.0,left: 24.0,right: 24.0),
                      child: KeyboardActions(
                        disableScroll: true,
                        autoScroll: false,
                        config: _buildConfig(context),
                        child: TextFormInputField(
                          hintText: "Enter Phone number",iconPrefix: Icons.phone,
                          maxLength: 10,
                          controller: numberController,
                          autofill: [AutofillHints.telephoneNumber],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),focusNode: _focusNode1,
                          validator: (v){
                            return FieldValidator.validateValueIsEmpty(v!);
                          },
                        ),
                      )),




                  SizedBox(height: Get.height/12,),

                  WidgetButton(
                    onPressed: () {

                      callApiFun();

                    },
                    text: AppString.submit,

                  ),

                ],
              )),
        );
      },);
  }

  Widget progressWidget() {
    return GetBuilder(
      init: OnBoardingController(),
      builder: (OnBoardingController controller) {
        if (controller.isDataLoading) {
          return Container(
              width:  Get.width,
              height:  Get.height,
              child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),)));
        } else {
          return new Container();
        }
      },
    );

  }

  void callApiFun(){

    if (formKey.currentState!.validate()) {
      AppCommonFunction.checkInternet().then((value) {
        if(!value){
          onBoardingController.progressDataLoading(false);
          AppCommonFunction.displayDialogOKCallBack(context, "No Internet ","Please, Check Your Internet Connection!");

        }else{
          enterNumberApi();
        }
      });
    }

  }
  void otpCallUser(){


  }




  void resetAllField() {
    numberController.text="";
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _focusNode1,
          toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Container(
                  margin: EdgeInsets.only(left: 12.0, right: 12.0),
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Txt("DONE", color: Colors.black),
                  ),
                ),
              );
            }
          ],
        ),


      ],
    );
  }





  enterNumberApi() async {
    final prefs = await SharedPreferences.getInstance();
    onBoardingController.progressDataLoading(true);

    String? signature = await SmsVerification.getAppSignature();


    onBoardingController.enterNumberApi(number: numberController.text,appSignature: signature!).then((value) async {
      onBoardingController.numberApiResponse = value;

      prefs.setString(PrefUtils.USER_DATA, json.encode(onBoardingController.numberApiResponse));
      PreferenceHelper().saveUserData(onBoardingController.numberApiResponse);

      onBoardingController.progressDataLoading(false);
      AppCommonFunction.flutterToast("Success", true);


      Get.to(()=> EnterOtpScreenUI(
        otp: onBoardingController.numberApiResponse.otp!,
        number: numberController.text,
        statusCode: onBoardingController.statusCode.toString(),
      ) )!.then((value){
        resetAllField();
      });

    });
  }

}





// temp commit