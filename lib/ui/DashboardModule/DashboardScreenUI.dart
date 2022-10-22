import 'package:brokerBook/controller/DashboardController.dart';
import 'package:brokerBook/helper/PreferenceHelper.dart';
import 'package:brokerBook/ui/AreaPropertyScreenUI.dart';
import 'package:brokerBook/ui/ChatModule/ChatContactListScreenUI.dart';
import 'package:brokerBook/ui/DashboardModule/AddEstateScreenUI.dart';
import 'package:brokerBook/ui/DashboardModule/HomeScreenUI.dart';
import 'package:brokerBook/ui/DashboardModule/QueryScreenUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:brokerBook/utils/AppColors.dart';
import 'package:brokerBook/utils/AppCommonFunction.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../controller/HomeController.dart';
import '../../controller/MessageBalanceController.dart';
import '../../utils/AppString.dart';
import '../../widgets/Txt.dart';
import '../MessageBalanceScreenUI.dart';
import '../SearchModule/SearchModuleScreenUI.dart';
import 'TempScreenUI.dart';
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
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,() {
      print("Profile COmpleted :: ");

      if (PreferenceHelper().getIsProfileCompleted()) {
        getMessageBalance();
        dashboardController.updateBottomSelectedIndex(0);
        print("DASHBOARD===========  ${PreferenceHelper().getUserData().authToken}");
      }
      else {
        Get.offAll(() => AreaPropertyScreenUI());
      }
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
                onItemTapped(index,dashboardController,pageController!);
              },
            ),
            body: WillPopScope(

              onWillPop: onWillPop,
              child: Column(
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
                            icon: Icon(FontAwesomeIcons.shareFromSquare,size: 20),
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
                                  //Get.to(()=> TempScreenUI() );
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


  void onItemTapped(int index,DashboardController dashboardController,PageController pageController) {
    print("Page Index  ::  $index");
    print("Page Index  ::  $pageController");

    dashboardController.updateBottomSelectedIndex(index);
    pageController.animateToPage(index,
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


 /* Future<bool> _onWillPop() {
    showDialog(
        context: context,
        builder: (BuildContext context)=> exitAppConfirmationDialog()
    );
    return Future<bool>.value(true);
  }*/




  Widget exitAppConfirmationDialog() {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 220,
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: AppColors.white,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(

                  border: Border.all(color: AppColors.primaryColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),

                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new  Container(

                        padding: EdgeInsets.only(
                          bottom: 12,
                          top: 12,
                          left:12,
                        ),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                            color:AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            AppString.APP_NAME,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white),
                          ),
                        ),
                      ),



                      Center(
                        child: Container(
                          color: AppColors.white,
                          padding: EdgeInsets.all(12),
                          child: new Text(
                            "Are you sure you want to exit application?",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontSize: 16, color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(top: 16),
                        height:3,
                        color: AppColors.primaryColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.back(canPop: true);

                              },
                              child: Container(
                                height: 44,
                                padding: EdgeInsets.only(
                                    top: 12,
                                    bottom:12),
                                child: Center(
                                  child: new Text(
                                    'No',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:AppColors.primaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new Container(
                            width: 3,
                            height: 40,
                            color: AppColors.primaryColor,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                SystemNavigator.pop();
                              },
                              child: Container(
                                height: 44,
                                padding: EdgeInsets.only(
                                    top: 12,
                                    bottom: 12),
                                child: Center(
                                  child: new Text(
                                    'Yes',
                                    style: TextStyle(
                                        fontSize:16,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }


  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "press again for exit");
      return Future.value(false);
    }
    return Future.value(true);
  }


}

