// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:croma_brokrage/utils/AppColors.dart';

import 'Txt.dart';


class WidgetButton extends StatelessWidget {
  WidgetButton({
    required this.text,
    this.width = 0,
    required this.onPressed,
  });

  final String text;
  double width;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context,) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 44,
        width: width == 0 ? Get.width/2.5 : width ,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(25))
        ),

        child: Center(
          child: Txt( text,fontSize: 20,color: AppColors.bgColor,fontWeight: FontWeight.bold),
        ),
        ),
    );
  }
}