import 'dart:async';

import 'package:croma_brokrage/controller/OnbordingController.dart';
import 'package:croma_brokrage/ui/DashboardModule/DashboardScreenUI.dart';
import 'package:croma_brokrage/utils/AppColors.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/utils/AppString.dart';
import 'package:croma_brokrage/utils/FieldValidator.dart';
import 'package:croma_brokrage/widgets/TextFormInputField.dart';
import 'package:croma_brokrage/widgets/WidgetBackArrow.dart';
import 'package:croma_brokrage/widgets/WidgetButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import 'package:get/get.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

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
  FocusNode _focusNode1 = FocusNode();
  OnBoardingController onBoardingController = Get.put(OnBoardingController());
  final formKey = GlobalKey<FormState>();
  TextEditingController otpController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  int _otpCodeLength = 6;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = new TextEditingController(text: "");



  @override
  void initState() {
    //_listenOtp();
    Future.delayed(Duration.zero,(){
      numberController.text = widget.number;
    });
    _getSignatureCode();
    _startListeningSms();
    super.initState();
  }

  late TextEditingController textEditingController1;

  @override
  void dispose(){
    super.dispose();
    SmsAutoFill().unregisterListener();
  }


  /*_listenOtp() async {
   var temp = await SmsAutoFill().listenForCode;
   String? signature = await SmsVerification.getAppSignature();

   await SmsVerification.getAppSignature().then((otp) => textEditingController.text = otp!);

   print("AUTO READ  ::  ${temp}");
  }*/

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

      child: Column(

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
      ),
    );
  }

  Widget middleContainer() {
    return Column(
      children: [
        Txt("Enter OTP ", fontSize: 22.0,fontWeight: FontWeight.w600,color: AppColors.primaryColor),
        SizedBox(height: 20,),
        Container(
          margin: EdgeInsets.only(left: 24,right: 24),
          child: Txt("Check your email address and enter valid OTP",maxLines: 2,
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
                        textController: textEditingController,
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



                  /*
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                    child: PinFieldAutoFill(
                      controller: otpController,
                      autoFocus: true,
                      decoration: UnderlineDecoration(
                          colorBuilder: FixedColorBuilder(AppColors.primaryColor)),
                      currentCode: "      ",
                      codeLength: 6,
                      onCodeSubmitted: (code){

                      },
                      onCodeChanged: (code){
                        if(code!.length == 6){
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                    ),
                  ),
*/


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


                  controller.isResendTimerShow
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Txt("Resend Sms in ",color: AppColors.black,fontSize: 16),

                      SlideCountdownClock(
                        duration: Duration(minutes: timer),
                        slideDirection: SlideDirection.Up,
                        separator: ":",
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        shouldShowDays: false,
                        onDone: () {
                          controller.updateResendTimerShow(false);

                        },
                      ),

                    ],
                  )
                      : Container(),



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
      if(widget.otp == textEditingController.text){

        if(widget.statusCode == "200"){
          AppCommonFunction.flutterToast("Success", true);
          PreferenceHelper().saveIsUserLoggedIn(true);
          print("----USER SAVED----");
          Get.offAll(()=> DashboardScreenUI() );
        }
        else {
          AppCommonFunction.flutterToast("Success", true);
          PreferenceHelper().saveIsUserLoggedIn(true);
          print("----USER SAVED----");
          showRewardDialog();
        }

      }
      else{
        AppCommonFunction.flutterToast("Invalid OTP please try again.", false);
      }

  }

  showRewardDialog(){
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
  }

  /// resend sms
  void resendSMS(){
    Get.to(()=> AreaPropertyScreenUI() );
  }

  void resetAllField() {
    otpController.clear();
    textEditingController.clear();
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
    SmsVerification.startListeningSms().then((message) {

      if(message != null){
        print("OTP MSG  ::  ${message}");
        String otp = message.toString().substring(message.length-6,message.length);

        print("START  :: ${message.length-6}");
        print("END  :: ${message.length}");
        print("LAST 6 DIGIT  :: ${otp}");

        textEditingController.text = otp;
      }

    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }


}
