import 'package:flutter/material.dart';

import '../../utils/AppColors.dart';
import '../../widgets/Txt.dart';

class AreaProfileTypeScreenUI extends StatefulWidget {
  List data;
  String title;
   AreaProfileTypeScreenUI({Key? key,required this.data,required this.title}) : super(key: key);

  @override
  State<AreaProfileTypeScreenUI> createState() => _AreaProfileTypeScreenUIState();
}

class _AreaProfileTypeScreenUIState extends State<AreaProfileTypeScreenUI> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                widget.data.isEmpty
                    ? Expanded(child: Center(child: Txt("No Data Found",color: AppColors.primaryColor,fontSize: 20,fontWeight: FontWeight.bold),))
                    :
                Flexible(
                  child: ListView.builder(
                    itemCount: widget.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.menu),
                                  SizedBox(width: 15,),
                                  Txt(widget.data[index].toString().toUpperCase(),fontSize: 18,fontWeight: FontWeight.w600,),
                                ],
                              ),
                            ));
                      },
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
