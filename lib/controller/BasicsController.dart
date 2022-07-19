import 'package:get/get.dart';


class BasicsController extends GetxController{
  var img;

  int   categoryVal = -1;
  String categoryTitle = "Select Categories";

  int languageVal = -1;
  String languageTitle = "Select Language";

  void setUploadImage(var imgPath){
    img = imgPath;
    //print("$img");
    update();
  }



}