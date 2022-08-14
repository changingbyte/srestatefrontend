import 'package:croma_brokrage/controller/DashboardController.dart';
import 'package:croma_brokrage/helper/PreferenceHelper.dart';
import 'package:croma_brokrage/ui/ChatModule/ChatContactListScreenUI.dart';
import 'package:croma_brokrage/ui/DashboardModule/AddEstateScreenUI.dart';
import 'package:croma_brokrage/ui/DashboardModule/HomeScreenUI.dart';
import 'package:croma_brokrage/ui/DashboardModule/QueryScreenUI.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:croma_brokrage/utils/AppColors.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../controller/HomeController.dart';
import '../../controller/MessageBalanceController.dart';
import '../../utils/AppString.dart';
import '../../widgets/Txt.dart';
import '../MessageBalanceScreenUI.dart';
import '../SearchModule/SearchModuleScreenUI.dart';
import 'UserProfileScreenUI.dart';

class DashboardScreenUI extends StatefulWidget {
  const DashboardScreenUI({Key? key}) : super(key: key);

  @override
  _DashboardScreenUIState createState() => _DashboardScreenUIState();
}

class _DashboardScreenUIState extends State<DashboardScreenUI> {

  HomeController homeController = Get.put(HomeController());
  DashboardController dashboardController = Get.put(DashboardController());
  MessageBalanceController messageBalanceController = Get.put(MessageBalanceController());
  PageController? pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      getMessageBalance();
      dashboardController.updateBottomSelectedIndex(0);
      print("DASHBOARD===========  ${PreferenceHelper().getUserData().authToken}");
    });
    pageController = PageController(initialPage:0,keepPage: true);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder(
        init: HomeController(),
        builder: (HomeController controller) {
          return  Scaffold(
            key: _scaffoldKey,
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: dashboardController.bottomSelectedIndex,
              items:[
                BottomBarItem(text: "Home",icon: Icons.home),
                BottomBarItem(text: "Search",icon: Icons.search),
                BottomBarItem(text: "Estate",icon: Icons.add_box),
                BottomBarItem(text: "Chat",icon: Icons.chat_rounded),
                BottomBarItem(text: "Profile",icon: Icons.account_box),
              ],
              onTap: (index) {
                _onItemTapped(index,dashboardController);
              },
            ),
            body: Column(
              children: [
                controller.myMultiSelectController.isSelecting
                  ? AppBar(
                  toolbarHeight: 60,
                  title: Text("Selected Estates"),
                  backgroundColor: AppColors.primaryColor,
                  actions: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.select_all,size: 24),
                          onPressed: homeController.selectAllItems,
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.shareSquare,size: 20),
                          onPressed:(){
                            Get.to(()=> QueryScreenUI() );
                          },
                        )
                      ],
                    ),
                    SizedBox(width: 8),
                  ]
                )
                  : Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Txt(dashboardController.appBarTitle,fontSize: 20,fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Get.to(()=> MessageBalanceScreenUI() );
                            },
                            child: Row(
                              children: [
                                GetBuilder(
                                  init: MessageBalanceController(),
                                  builder: (MessageBalanceController controller) {
                                    return Text(controller.textBalance != null ? controller.textBalance.toString() : "0",style: TextStyle(color: AppColors.primaryColor,fontSize:20,fontWeight: FontWeight.bold),);
                                  },
                                ),
                                SizedBox(width: 5,),
                                Icon(Icons.messenger_outlined,color:  AppColors.primaryColor,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                Expanded(
                  child: PageView(
                    reverse: false,
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [
                      HomeScreenUI(),
                      SearchModuleScreenUI(),
                      AddEstateScreenUI(),
                      ChatContactListScreenUI(),
                      UserProfileScreenUI(),

                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SalomonBottomBarItem BottomBarItem({required String text,required IconData icon}){
    return SalomonBottomBarItem(
      icon: Icon(icon,color:  AppColors.primaryColor,),
      title: Txt(text),
      selectedColor: AppColors.primaryColor,
    );
  }


  void _onItemTapped(int index,DashboardController dashboardController) {
    print("Page Index  ::  $index");

    dashboardController.updateBottomSelectedIndex(index);
    pageController!.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {

    });
  }

  getMessageBalance(){
    messageBalanceController.messageBalanceApi(token: PreferenceHelper().getUserData().authToken!).then((value) {

      if(value != null){
        if(value["success"].toString() == "true"){
          if(value["data"]['balance'].toString().isNotEmpty){

            messageBalanceController.messageBalanceResponse = value['data'];
            messageBalanceController.textBalance = value['data']['balance'];
            messageBalanceController.whatsappBalance = messageBalanceController.textBalance/2;
            messageBalanceController.whatsappBalance = messageBalanceController.whatsappBalance.toStringAsFixed(0);

            //print("WHATSAPP BAL  ::  ${messageBalanceController.whatsappBalance}");

            messageBalanceController.progressDataLoading(false);
          }
        }
        else{
          AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
        }

      }
      else{
        AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
      }

    });
  }


}

