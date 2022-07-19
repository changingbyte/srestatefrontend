import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Txt extends StatelessWidget {

  String text;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  TextOverflow overflow;
  int maxLines;
  TextDecoration decoration;

  Txt(
  this.text,
      {
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black87,
    this.overflow = TextOverflow.visible,
    this.maxLines = 1,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(color: color,fontSize: fontSize,fontWeight: fontWeight,decoration: decoration),
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}