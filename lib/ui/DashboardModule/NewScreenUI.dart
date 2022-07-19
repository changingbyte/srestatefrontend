import 'package:flutter/material.dart';

import '../../widgets/Txt.dart';

class NewScreenUI extends StatefulWidget {
  const NewScreenUI({Key? key}) : super(key: key);

  @override
  State<NewScreenUI> createState() => _NewScreenUIState();
}

class _NewScreenUIState extends State<NewScreenUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Txt("NewScreenUI")
        ],
      ),
    );
  }
}
