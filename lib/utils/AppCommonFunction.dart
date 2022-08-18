import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:croma_brokrage/ui/EstateListScreenUI.dart';
import 'package:croma_brokrage/widgets/TextFormInputField.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/Txt.dart';
import 'AppColors.dart';
import 'AppString.dart';
import 'package:get/get.dart';


class AppCommonFunction {

  static flutterToast(String? msg, bool isSuccess) {
      Fluttertoast.showToast(
        msg: msg.toString(),
        fontSize: 14.0,
        backgroundColor: isSuccess ? AppColors.primaryColor : Colors.redAccent,
        textColor: AppColors.white,
        toastLength: Toast.LENGTH_SHORT
      );
  }


  static bool isLargeDeviceHeight(){
    print("Get.height ${Get.height}");
    return Get.height>600 ? true :false;
  }

  static bool isLargeDeviceWidth(){
    return Get.width>350 ? true :false;
  }


  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }


  static Future<void> launchURL(url) async {
    await launch(url);
  }

  static unFocusKeyboard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  ///for internet
  static Future<bool> checkInternet() async {

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return true;
      }
      return false;

  }


  static Future<bool?> displayDialogOKCallBack(BuildContext context, String title, String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title, style: TextStyle(fontSize: 16.0),),
          content:  Text(message, style: TextStyle(fontSize: 14.0),),
          actions: <Widget>[

            TextButton (
              child:  Text("Cancel"),
              onPressed: () {
                checkInternet().then((value){
                  if(value){
                    Navigator.of(context).pop(false);
                  }
                });
                // true here means you clicked ok
              },
            ),

            TextButton (
              child:  Txt("Ok"),
              onPressed: () {
                checkInternet().then((value){
                  if(value){
                    Navigator.of(context).pop(true);
                  }
                });

                // true here means you clicked ok
              },
            ),
          ],
        );
      },
    );
  }



  static BoxDecoration splashBackground(){
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AppString.imagesBackgroundPath+"ic_splash_bg.png"),
        fit: BoxFit.cover,
      ),
    );
  }

  static Widget logoTextContainer(String img,double imgHeight,double imgWidth){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Center(
          child: Image.asset(AppString.logoImagesPath+ img,
            height: AppCommonFunction.isLargeDeviceHeight() ? imgHeight: 100,
            width: AppCommonFunction.isLargeDeviceWidth() ? imgWidth: 100,
          ),
        ),

      ],
    );
  }


static FormContainer(TextEditingController controller, String text) {
    return  TextFormInputField(
      controller: controller,
      hintText: text,
    );
}

static TextFormContainer(TextEditingController controller, String text){
  return  TextFormInputField(
    controller: controller,
    hintText: text,
  );
}


static circularIndicator(){
    return Center(
      child: CircularProgressIndicator(),
    );
}


static noDataFound({String text = "No Data Found!"}){
    return Center(
      child: Txt(text,color: AppColors.primaryColor,fontSize: 20,fontWeight: FontWeight.bold),
    );
}



static lottieAnimation({required String path,double height = 150}){
    return Center(
      child: Lottie.asset(
        AppString.lottiePath+path,
        height: height,
      ),
    );
}

static adsBanner({required AdmobBannerSize admobBannerSize}){
    return AdmobBanner(adUnitId: BannerAd.testAdUnitId, adSize: admobBannerSize);
}


static String timestampToDatetime(int timestamp){
  var date = DateFormat('dd/MM/yyyy, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
  print("DATEEE  ::  ${date}");
  return date;
}




}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

