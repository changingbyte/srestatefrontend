import 'package:flutter/material.dart';
import 'package:brokerBook/utils/AppColors.dart';


class RoundedButtonWidget extends StatelessWidget {

  final double height;
  final double width;

  final String text;
  final GestureTapCallback onPressed;

  RoundedButtonWidget({ required this.height,required this.width, required this.text, required this.onPressed,});

  @override
  Widget build(BuildContext context,) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child:  Text(text,style: TextStyle(
            fontSize: 15,fontWeight: FontWeight.w700,color: AppColors.white
        ),),

      ),
    );
  }
}