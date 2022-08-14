import 'package:get/get_state_manager/get_state_manager.dart';

class DashboardController extends GetxController{
  int bottomSelectedIndex=0;
  String appBarTitle= "Estates";


  void updateBottomSelectedIndex(int index){
    bottomSelectedIndex=index;

    if(index == 0){
      appBarTitle = "Estates";
      bottomSelectedIndex = 0;
    }
    else if(index == 1){
      appBarTitle = "Search";
      bottomSelectedIndex = 1;
    }
    else if(index == 2){
      appBarTitle = "Add Estate";
      bottomSelectedIndex = 2;
    }
    else if(index == 3){
      appBarTitle = "Chat";
      bottomSelectedIndex = 3;
    }
    else if(index == 4){
      appBarTitle = "Profile";
      bottomSelectedIndex = 4;
    }
    else{
      appBarTitle = "";
    }
    update();
  }


}