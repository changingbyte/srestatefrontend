import 'package:flutter/material.dart';
import 'package:brokerBook/utils/AppColors.dart';

class TextFormNumberField extends StatelessWidget {

  final String? hintText;
  final IconData? iconSuffix;
  final int? maxLength;


  TextFormNumberField({ this.hintText, this.iconSuffix, this.maxLength});

  @override
  Widget build(BuildContext context,) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        style: TextStyle(color: AppColors.primaryColor),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        maxLength: maxLength==null?null:maxLength,
        decoration:  InputDecoration(
          hintText: hintText, contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
          hintStyle: TextStyle(color: AppColors.orangeLightColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: AppColors.primaryColor,width: 0.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: AppColors.primaryColor,width: 0.5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: AppColors.primaryColor,width: 0.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: AppColors.redColor,width: 0.5)),
          prefixIcon: iconSuffix==null? null: Icon(iconSuffix,color: AppColors.primaryColor)

        ),



      )
    );
  }
}







