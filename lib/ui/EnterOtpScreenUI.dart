import 'dart:async';

import 'package:brokerBook/controller/OnbordingController.dart';
import 'package:brokerBook/ui/DashboardModule/DashboardScreenUI.dart';
import 'package:brokerBook/utils/AppColors.dart';
import 'package:brokerBook/utils/AppCommonFunction.dart';
import 'package:brokerBook/utils/AppString.dart';
import 'package:brokerBook/utils/FieldValidator.dart';
import 'package:brokerBook/widgets/TextFormInputField.dart';
import 'package:brokerBook/widgets/WidgetBackArrow.dart';
import 'package:brokerBook/widgets/WidgetButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';


import '../helper/PreferenceHelper.dart';
import '../widgets/Txt.dart';
import 'AreaPropertyScreenUI.dart';

class EnterOtpScreenUI extends StatefulWidget {
  final String otp;
  final String number;
  final String statusCode;
  EnterOtpScreenUI({required this.otp,required this.number,required this.statusCode});

  @override
  _EnterOtpScreenUIState createState() => _EnterOtpScreenUIState();
}

class _EnterOtpScreenUIState extends State<EnterOtpScreenUI> {

  int timer = 1;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  int _otpCodeLength = 6;
  FocusNode _focusNode1 = FocusNode();
  OnBoardingController onBoardingController = Get.put(OnBoardingController());
  final formKey = GlobalKey<FormState>();
  //TextEditingController otpController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      numberController.text = widget.number;
    });
    _getSignatureCode();
    _startListeningSms();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    SmsAutoFill().unregisterListener();
  }

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
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(left: 18.0,top: 0),
            child: WidgetBackArrow(onPressed: (){
              Navigator.pop(context);
            },),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 24.0,right: 12.0,top: 0),
          child: AppCommonFunction.logoTextContainer("ic_main_logo.png",200,180),),
      ],
    );
  }

  Widget middleContainer() {
    return Column(
      children: [
        Txt("Enter OTP ", fontSize: 22.0,fontWeight: FontWeight.w600,color: AppColors.primaryColor),
        SizedBox(height: 20,),
        Container(
          margin: EdgeInsets.only(left: 24,right: 24),
          child: Txt("Check your SMS and enter valid OTP",maxLines: 2,
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
                    child: TextFormInputField(
                      iconPrefix: Icons.call,
                      controller: numberController,
                      enable: false,
                      autofill: [AutofillHints.oneTimeCode],
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 20,bottom: 10),
                    child: TextFieldPin(
                        textController: controller.otpController,
                        autoFocus: true,
                        codeLength: 6,
                        alignment: MainAxisAlignment.center,
                        defaultBoxSize: 40.0,
                        margin: 7,
                        selectedBoxSize: 40.0,
                        textStyle: TextStyle(fontSize: 16),
                        defaultDecoration: _pinPutDecoration.copyWith(
                            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.6))),
                        selectedDecoration: _pinPutDecoration,
                        onChange: (code) {
                          if(code.length >= 6){
                            FocusScope.of(context).unfocus();
                          }
                          setState((){});
                        }),
                  ),



                  AbsorbPointer(
                    absorbing: controller.isResendTimerShow  ? true : false,
                    child: Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(right: 12,top: 10,bottom: 10),
                        child: InkWell(
                          onTap: () async {
                            final signature = await SmsAutoFill().getAppSignature;
                            controller.progressDataLoading(true);
                            controller.enterNumberApi(number: widget.number,appSignature: signature);
                            //resendSMS();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Txt(
                              "Resend OTP",
                                  color: AppColors.primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline
                            ),
                          ),
                        )),
                  ),





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
          AppCommonFunction.displayDialogOKCallBack(context, "No Internet ","Please, Check Your Internet Connection!");

        }else{
          otpCallUser();
        }
      });
    }

  }

  void otpCallUser(){
      if(widget.otp == onBoardingController.otpController.text){

        if(widget.statusCode == "200"){
          AppCommonFunction.flutterToast("Success", true);
          PreferenceHelper().saveIsUserLoggedIn(true);
          print("----USER SAVED----");

          if(PreferenceHelper().getIsProfileCompleted()){
            Get.offAll(()=>  DashboardScreenUI() );
          }
          else{
            Get.offAll(()=>  AreaPropertyScreenUI() );
          }

        }
        else {
          AppCommonFunction.flutterToast("Success", true);
          PreferenceHelper().saveIsUserLoggedIn(true);
          print("----USER SAVED----");

          AppCommonFunction.showRewardDialog(
            rewardAmount: "1000",
            onPressed: (){
              Get.offAll(() => AreaPropertyScreenUI());
            }
          );
        }

      }
      else{
        AppCommonFunction.flutterToast("Invalid OTP please try again.", false);
      }

  }



  /*showRewardDialog(){
    Get.defaultDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppCommonFunction.lottieAnimation(path: "ic_reward_coins.json",height: 180),

          Center(child: Txt("Congratulation!!!",fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,)),
          SizedBox(height: 5),
          Center(child: Wrap(
            children: [
              Txt("1000 Free Messages",fontSize: 17,color: Colors.black,fontWeight: FontWeight.w500,),
            ],
          )),

          SizedBox(height: 20),

          WidgetButton(
              text: "Collect",
              onPressed: (){
                Get.offAll(() => AreaPropertyScreenUI());
              }
          ),
        ],
      ),
    );
  }*/

  /// resend sms
  void resendSMS(){
    Get.to(()=> AreaPropertyScreenUI() );
  }

  void resetAllField() {
    onBoardingController.otpController.clear();
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
                    child: Txt("DONE",color: Colors.black),
                  ),
                ),
              );
            }
          ],
        ),


      ],
    );
  }


  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    print("signature $signature");
  }

  /// listen sms
  _startListeningSms()  {
    print("---OTP READING---");

    SmsVerification.startListeningSms().then((message) {

      if(message != null){
        print("OTP MSG  ::  ${message}");
        String otp = message.toString().substring(message.length-6,message.length);

        onBoardingController.updateOtp(otp);
        print("CONTROLLER  ::  ${onBoardingController.otpController.text}");
        print("LAST 6 DIGIT  :: ${otp}");

      }

    });
  }

  /*_onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      }else{
        _enableButton = false;
      }
    });
  }*/

  /*_verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });

    });
  }*/


}
