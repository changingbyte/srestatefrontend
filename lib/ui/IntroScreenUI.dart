import 'package:brokerBook/ui/EnterNumberScreenUI.dart';
import 'package:brokerBook/utils/AppColors.dart';
import 'package:brokerBook/utils/AppColors.dart';
import 'package:brokerBook/utils/AppColors.dart';
import 'package:brokerBook/utils/AppColors.dart';
import 'package:brokerBook/widgets/ScaffoldWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../utils/AppString.dart';

class IntroScreenUI extends StatefulWidget {
  const IntroScreenUI({Key? key}) : super(key: key);

  @override
  State<IntroScreenUI> createState() => _IntroScreenUIState();
}

class _IntroScreenUIState extends State<IntroScreenUI> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: IntroductionScreen(
            //globalBackgroundColor: Colors.deepOrangeAccent,
            pages: [
              PageViewModel(
                title: "Estate ",
                body: "Instead of having to buy an entire share, invest any amount you want.",
                image: introImage(AppString.imagesAssetPath+"ic_illustrator_1.png"),
                //decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Industry Experiance",
                body: "Instead of having to buy an entire share, invest any amount you want.",
                image: introImage(AppString.imagesAssetPath+"ic_illustrator_2.png"),
                //decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Fractional shares",
                body: "Instead of having to buy an entire share, invest any amount you want.",
                image: introImage(AppString.imagesAssetPath+"ic_illustrator_3.jpg"),
                //decoration: pageDecoration,
              ),

              //add more screen here
            ],

            onDone:() {
              Get.offAll(()=> EnterNumberScreenUI());
            },
            onSkip:() {
              Get.offAll(()=> EnterNumberScreenUI());
            }, // You can override on skip
            showSkipButton: true,
            skip: Text('Skip', style: TextStyle(color: AppColors.primaryColor),),
            next: Icon(Icons.arrow_forward, color: AppColors.primaryColor,),
            done: Text('Let Begin', style: TextStyle(
                fontWeight: FontWeight.w600, color:AppColors.primaryColor
            ),),
            dotsDecorator:DotsDecorator(
              size: Size(10.0, 10.0), //size of dots
              color: AppColors.primaryColor, //color of dots
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder( //shave of active dot
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget introImage(String assetName, ) {
    return Align(
      child: Image.asset('$assetName', width: 300.0,scale: 0.25,),
      alignment: Alignment.bottomCenter,
    );
  }
}