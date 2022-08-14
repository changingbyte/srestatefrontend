import 'package:croma_brokrage/controller/SearchModuleController.dart';
import 'package:croma_brokrage/helper/PreferenceHelper.dart';
import 'package:croma_brokrage/widgets/EstateCardList.dart';
import 'package:croma_brokrage/widgets/Txt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_item/multi_select_item.dart';

import '../../controller/HomeController.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppCommonFunction.dart';
import '../../utils/AppString.dart';

class BuyListScreenUI extends StatefulWidget {
  const  BuyListScreenUI({Key? key}) : super(key: key);

  @override
  State<BuyListScreenUI> createState() => _BuyListScreenUIState();
}

class _BuyListScreenUIState extends State<BuyListScreenUI> {
  SearchModuleController searchModuleController = Get.put(SearchModuleController());
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero,(){
      print("---SEARCH CLEAR---");
      homeController.deselectItems();
      homeController.selectedEstateList.clear();
      searchModuleController.progressDataLoading(true);
    });

    getEstateBuyListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: SearchModuleController(),
        builder: (SearchModuleController controller) {
          return controller.isDataLoading
            ? AppCommonFunction.circularIndicator()
            : controller.buyEstateList.isEmpty
              ? AppCommonFunction.noDataFound()
              : EstateCardList(
                homeController: homeController,
                estateList: controller.buyEstateList
              );

        },
      ),
    );
  }


  getEstateBuyListApi(){
    searchModuleController.buyEstateListApi(token: PreferenceHelper().getUserData().authToken!).then((value) {

      if(value != null){
        if(value.success.toString() == "true"){
          if(value.data!.isNotEmpty){
            searchModuleController.buyEstateListResponse = value;
            searchModuleController.buyEstateList = value.data!;
            searchModuleController.progressDataLoading(false);
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
