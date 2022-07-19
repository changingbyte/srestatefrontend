import 'package:get/get_state_manager/get_state_manager.dart';

class DashboardController extends GetxController{
  int bottomSelectedIndex=0;
  String appBarTitle= "Estates";


  void updateBottomSelectedIndex(int index){
    bottomSelectedIndex=index;

    if(index == 0){
      appBarTitle = "Estates";
    }
    else if(index == 1){
      appBarTitle = "Search";
    }
    else if(index == 2){
      appBarTitle = "Add Balance";
    }
    else if(index == 3){
      appBarTitle = "Message Query";
    }
    else{
      appBarTitle = "Profile";
    }

    update();
  }


  void updateAppBarTitle(String title){
    appBarTitle=title;
    //print("appBarTitle="+appBarTitle.toString());
    update();
  }


}