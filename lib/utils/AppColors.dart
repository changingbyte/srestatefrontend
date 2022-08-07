
import 'package:flutter/material.dart';

class AppColors {


  //static const Color primaryColor = const Color(0xFFA0CFEC);
  static const Color primaryColor = Colors.lightBlue;
  static const Color primaryAccent = const Color(0xFF3EA99F);
  static const Color primaryDarkColor = const Color(0xFFceaa4b);
  static const Color bgColor = const Color(0xFFF9FFF8);
  static const Color hintColor = const Color(0xFF979a9d);
  static const Color bgBottomColor = const Color(0xFF170F0C);

  static const Color redColor = const Color(0xFFe21e26);
  static const Color yellowColor = const Color(0xFFebac10);
  static const Color orangeColor = const Color(0xFFBF9853);
  static const Color orangeLightColor = const Color(0xFFDABF76);
  static const Color skyBlueColor = const Color(0xFF02a1e6);
  static const Color blueColor = const Color(0xFF4049ca);

  static const Color black = const Color(0xFF000000);
  static const Color white = const Color(0xFFffffff);

  static const Color greenColor = const Color(0xFF00ff24);
  static const Color listBgColor = const Color(0xFF0f0f0f);
  static const Color textDisableColor = const Color(0xFF555555);


  static const Color appBarColor = const Color(0xFF252b2d);
  static const Color walletBg = const Color(0xFF222729);

  static const Color dividerTab = const Color(0xFF303030);
  static const Color blackShadow = const Color(0xFF0e0e0e);


  static const Color grayColor = const Color(0xFFa2a2a2);
  static const Color grayFontColor = const Color(0xFFDEDEDE);
  static const Color grayColor1 = const Color(0xFF727677);


  static const Color iconDisableColor = const Color(0xFFffffff);
  static const Color bottomBGColor = const Color(0xFF0c0d0c);
  static const Color yellow = const Color(0xFFbd8e27);


  static const Color darkGray = const Color(0xFF232323);
  static const Color dividerColor = const Color(0xFFE3E9EC);



  static const LinearGradient appBarGradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        AppColors.primaryColor,
        AppColors.primaryColor
      ]);

  static const LinearGradient appBgColor =  LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        AppColors.primaryColor,
        AppColors.primaryColor,
      ],
  );


}
