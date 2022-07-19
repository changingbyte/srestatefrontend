import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/AppColors.dart';

class ViewChatImageScreenUi extends StatefulWidget {
  final email;
  final pwd;
  final ticketId;
  final file;

  ViewChatImageScreenUi({this.email, this.pwd, this.ticketId, required this.file});

  @override
  _ViewChatImageScreenUiState createState() => _ViewChatImageScreenUiState();
}

class _ViewChatImageScreenUiState extends State<ViewChatImageScreenUi> {
  StreamController<bool> progressController =  StreamController<bool>();


  TextEditingController textController = TextEditingController();

  String temp ="";
  String msg="";
  int minutes = 0;
  int hours = 0;


  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    progressController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Stack(
          children: [
            Center(child: Image.file(File(widget.file!))),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(5.0),
              child: Row(
                children:[
                  Flexible(
                    child: Theme(
                      data: ThemeData(
                        primaryColor: AppColors.primaryColor,
                      ),
                      child: TextFormField(
                        controller: textController,
                        enableSuggestions: true,
                        style: TextStyle(color: Colors.white),
                        minLines: 1,
                        maxLines: 5,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.5),
                          hintText: "Enter your message..",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onChanged: (value) {
                          temp = value.trim();
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),

                  InkWell(
                    onTap: () {
                      setState(() {
                          minutes = DateTime.now().minute;
                          hours = DateTime.now().hour;
                          temp == "" ? temp = "" : msg=textController.text.trim().toString();
                          if(temp != null){
                            progressController.sink.add(true);
                            onSend();
                          }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,),
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],),
            ),

          ],
        ),
        ),
    ));
  }

  void onSend()async {}
}
