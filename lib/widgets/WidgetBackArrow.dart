import 'package:flutter/material.dart';
import 'package:brokerBook/utils/AppColors.dart';

class WidgetBackArrow extends StatelessWidget {
  final GestureTapCallback onPressed;

  WidgetBackArrow({required this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 40,width: 40,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(14.0))
          ),
          child: Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Center(child: Icon(Icons.arrow_back_ios,color: AppColors.white,size: 28,)),
          )),
    );
  }
}
