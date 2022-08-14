import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:croma_brokrage/utils/AppColors.dart';

class TextFormInputField extends StatelessWidget {

  final TextEditingController? controller;
  final String? hintText;
  final IconData? iconSuffix;
  final IconData? iconPrefix;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool enable;
  final int? minLine;
  final int? maxLine;
  Iterable<String>? autofill;
  final GestureTapCallback? onPressedSuffix;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final FocusNode? focusNode;
  ValueChanged<String>? onChanged;
  VoidCallback? onEditingComplete;
  double borderRadius;

  TextFormInputField({ this.hintText,
     this.controller,
     this.iconSuffix,
     this.iconPrefix,
     this.onPressedSuffix,
     this.keyboardType,
     this.maxLength,
     this.autofill,
     this.minLine,
     this.maxLine,
    this.borderRadius = 50,
     this.enable = true,
     this.validator,
     this.onChanged,
     this.onEditingComplete,
     this.onSaved,
     this.focusNode});

  @override
  Widget build(BuildContext context,) {
    return Stack(

      children: [
        Container(
          width: Get.width,
          height:Get.height/16,

        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            cursorColor: AppColors.primaryColor,
            style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w400),
            validator: validator==null?null:validator,
            onSaved: onSaved==null?null:onSaved,
            onChanged: onChanged==null?null:onChanged,
            controller: controller==null?null:controller,
            focusNode: focusNode==null?null:focusNode,
            keyboardType: keyboardType==null?TextInputType.text : keyboardType,
            maxLength: maxLength==null?null:maxLength,
            minLines: minLine==null?null:minLine,
            maxLines: maxLine==null?null:maxLine,
            enabled: enable,
            autofillHints: autofill,
            enableSuggestions: true,
            onEditingComplete: onEditingComplete == null ? null : onEditingComplete,
            decoration:  InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              fillColor: Colors.black12.withOpacity(0.05),
              contentPadding:  EdgeInsets.symmetric(vertical: 10.0,horizontal:8.0),
              hintStyle: TextStyle(color: AppColors.grayColor), filled: true,
              disabledBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: Colors.transparent,width: 0.5)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: Colors.transparent,width: 0.5)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: Colors.transparent,width: 0.5)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: Colors.transparent,width: 0.5)),
              prefixIcon: iconPrefix==null? null: Icon(iconPrefix,color: AppColors.primaryColor),
              suffixIcon:  iconSuffix==null? null: InkWell(
                  onTap: onPressedSuffix,
                  child: Icon(iconSuffix,color: AppColors.primaryColor)),
              /*  errorStyle: TextStyle(fontSize: 11, height: 0.3,
               ),*/
              //counterStyle: TextStyle(color: AppColors.primaryColor,height: 0.3),
            ),



          ),
        ),

      ],
    );
  }
}







