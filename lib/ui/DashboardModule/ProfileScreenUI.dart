import 'package:croma_brokrage/ui/ChatModule/ChatListScreenUI.dart';
import 'package:croma_brokrage/ui/DashboardModule/UserProfileScreenUI.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreenUI extends StatefulWidget {
  const ProfileScreenUI({Key? key}) : super(key: key);

  @override
  State<ProfileScreenUI> createState() => _ProfileScreenUIState();
}

class _ProfileScreenUIState extends State<ProfileScreenUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text("Chat List UI"),
                  onPressed: () {
                    Get.to(()=> ContactListScreenUI() );
                },),


                ElevatedButton(
                  child: Text("User Profile"),
                  onPressed: () {
                  Get.to(()=> UserProfileScreenUI() );
                },),
              ],
            )
          ],
        ),
      ),
    );
  }
}
