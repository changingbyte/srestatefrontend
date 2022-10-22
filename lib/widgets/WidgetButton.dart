// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brokerBook/utils/AppColors.dart';

import 'Txt.dart';


class WidgetButton extends StatelessWidget {
  WidgetButton({
    required this.text,
    this.width = 0,
    required this.onPressed,
    this.fontsize =20,
    this.height =44,
  });

  final String text;
  double width;
  final GestureTapCallback onPressed;
  double fontsize;
  double height;

  @override
  Widget build(BuildContext context,) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width == 0 ? Get.width/2.5 : width ,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(25))
        ),

        child: Center(
          child: Txt( text,fontSize: fontsize,color: AppColors.bgColor,fontWeight: FontWeight.bold),
        ),
        ),
    );
  }
}