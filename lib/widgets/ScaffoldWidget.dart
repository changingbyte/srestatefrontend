// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  Widget? body;
  Widget? floatingActionButton;
  PreferredSizeWidget? appBar;
  ScaffoldWidget({this.body,this.floatingActionButton,this.appBar});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        appBar: appBar,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: body,
        ),
      )
    );
  }
}
