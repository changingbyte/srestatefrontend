
import 'package:animated_text/animated_text.dart';
import 'package:croma_brokrage/utils/AppColors.dart';
import 'package:croma_brokrage/utils/AppString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/PreferenceHelper.dart';
import '../widgets/Txt.dart';
import 'DashboardModule/DashboardScreenUI.dart';
import 'EnterNumberScreenUI.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({Key? key}) : super(key: key);

  @override
  _SplashScreenUiState createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();

    //PreferenceHelper().saveIsUserLoggedIn(true);
    //print("USER LOGGED IN  ::  ${PreferenceHelper().getIsUserLoggedIn()}");

    Future.delayed(Duration(seconds: 3,),(){
      if(PreferenceHelper().getIsUserLoggedIn()){
        Get.off(()=> DashboardScreenUI(),);
      }
      else{
        Get.off(()=> EnterNumberScreenUI(),);
      }

      //Get.off(()=> EnterNumberScreenUI(),);
      //Get.off(()=> DashboardScreenUI(),);

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppString.logoImagesPath+"ic_main_logo.png",
                  height: 140,width: 140,
                ),
                Container(
                  height: 80,
                  child: Txt("Broker Book",fontSize: 28,fontWeight: FontWeight.w600,color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

