import 'package:croma_brokrage/helper/PreferenceHelper.dart';
import 'package:croma_brokrage/utils/AppColors.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/widgets/TextFormInputField.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:multi_select_item/multi_select_item.dart';
import '../../utils/AppString.dart';
import '../controller/EstateListController.dart';
import '../controller/HomeController.dart';
import '../widgets/EstateCardList.dart';
import '../widgets/Txt.dart';
import 'DashboardModule/PropertyDetailsScreenUI.dart';
import 'DashboardModule/QueryScreenUI.dart';

class EstateListScreenUI extends StatefulWidget {
  String estateName;

  EstateListScreenUI({this.estateName = ""});

  @override
  State<EstateListScreenUI> createState() => _EstateListScreenUIState();
}

class _EstateListScreenUIState extends State<EstateListScreenUI> {
  EstateListController estateListController = Get.put(EstateListController());
  HomeController homeController = Get.put(HomeController());


  @override
  void initState() {
    super.initState();
    getEstateApi();
    Future.delayed(Duration.zero,(){
      print("---ESTATE LIST CLEAR---");
      homeController.deselectItems();
      homeController.estateList.clear();
      homeController.selectedEstateList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder(
        builder: (HomeController homeController) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              title: Text(widget.estateName),
              centerTitle: true,
              actions: [
                (homeController.myMultiSelectController.isSelecting)
                    ? Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.select_all, size: 24),
                      onPressed: homeController.selectAllItems,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.shareFromSquare, size: 20),
                      onPressed: () {
                        Get.to(() => QueryScreenUI());
                      },
                    )
                  ],
                )
                    : Container(),
                SizedBox(width: 8),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormInputField(
                    hintText: "Search Your Estate",
                    iconSuffix: Icons.search,
                  ),
                  Expanded(
                    child: GetBuilder(
                      init: EstateListController(),
                      builder: (EstateListController estateListController) {
                        return estateListController.isDataLoading
                          ? Center(child: CircularProgressIndicator())
                          : estateListController.estateList.isEmpty
                              ? AppCommonFunction.noDataFound()
                              : EstateCardList(
                            homeController: homeController,
                            estateList: estateListController.estateList,
                            page: "estateType",
                          );
                      },
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

  Widget ListCardContainer({required IconData icon, required String text}) {
    return Wrap(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 17,),
        SizedBox(width: 5),
        Container(
          width: Get.width / 2.5,
          child: Txt(text, fontSize: 16, color: AppColors.black,
            fontWeight: FontWeight.w600, maxLines: 4, overflow: TextOverflow.ellipsis,),
        ),
      ],
    );
  }

  getEstateApi() {
    estateListController.estateListApi(token: PreferenceHelper().getUserData().authToken!, estateName: widget.estateName).then((value) {
      if (value != null) {
        if (value.success.toString() == "true") {
          if (value.data!.isNotEmpty) {
            estateListController.estateList = value.data!;
            print("Estate Listtttt  ::  ${estateListController.estateList}");

            estateListController.progressDataLoading(false);
          }
        } else {
          AppCommonFunction.flutterToast("Something went wrong", false);
        }
      } else {
        AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
      }
    });
  }

  /*@override
  void dispose() {
    super.dispose();
    homeController.deselectItems();
  }*/

}
