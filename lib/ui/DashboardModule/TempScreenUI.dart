import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TempScreenUI extends StatefulWidget {
  const TempScreenUI({Key? key}) : super(key: key);

  @override
  State<TempScreenUI> createState() => _TempScreenUIState();
}

class _TempScreenUIState extends State<TempScreenUI> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl: 'https://cricketscoregully.herokuapp.com/admin/',
        ),
      ),
    );
  }
}
