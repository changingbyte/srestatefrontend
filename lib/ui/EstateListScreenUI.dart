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


  ///SELECTED TITLE BAR DISPLAY IN THIS SCREEN IS PENDING...
  @override
  void initState() {
    super.initState();
    getEstateApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder(
        init: EstateListController(),
        builder: (EstateListController controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              title: Text(widget.estateName),
              centerTitle: true,
              actions: [
                (controller.myMultiSelectController.isSelecting)
                    ? Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.select_all,size: 24),
                      onPressed: controller.selectAllItems,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.shareSquare,size: 20),
                      onPressed:(){
                        Get.to(()=> QueryScreenUI() );
                      },
                    )
                  ],
                )
                    : Container(),

                SizedBox(width: 8),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormInputField(
                    hintText: "Search Your Estate",
                    iconSuffix: Icons.search,
                  ),
                  Expanded(
                    child: GetBuilder(
                      init: EstateListController(),
                      builder: (EstateListController controller) {
                        return controller.isDataLoading
                            ? Center(child: CircularProgressIndicator())
                            : Column(
                          children: [
                            Expanded(
                              child: controller.estateList == null
                                  ? Center(child: CircularProgressIndicator())
                                  : controller.estateList.length < 1
                                  ? Center(
                                      child: Txt("No Data Found!", color: AppColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                                    )
                                  :

                              EstateCardList(
                                homeController: homeController,
                                estateList: controller.estateList,
                              ),


/*
                              ListView.builder(
                                itemCount: estateListController.estateList.length,
                                itemBuilder: (context, index) {

                                  if(controller.myMultiSelectController.isSelected(index)){
                                    controller.selectedEstateList.add(controller.estateList[index]['id']);
                                  }
                                  else{
                                    for(int i=0; i< controller.estateList.length; i++){
                                      if(!controller.myMultiSelectController.isSelected(index)){
                                        controller.selectedEstateList.remove(controller.estateList[index]['id']);
                                      }
                                    }
                                  }


                                  return MultiSelectItem(
                                    isSelecting: controller.myMultiSelectController.isSelecting,
                                    onSelected: () {
                                      setState(() {
                                        controller.isToggle(index);
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 3, bottom: 5),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Card(
                                          elevation: 10,
                                          color:  controller.myMultiSelectController.isSelected(index)
                                              ? Colors.grey.shade400
                                              : Colors.white,
                                          child: Container(
                                            width: Get.width,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: Get.width / 2,
                                                        child: Txt(estateListController.estateList[index]["estate_name"],
                                                          fontSize: 20, color: AppColors.black, fontWeight: FontWeight.bold),
                                                      ),

                                                      SizedBox(height: 13),

                                                      ListCardContainer(
                                                        icon: Icons.location_on, text: controller.estateList[index]["city"].toString()),
                                                      ListCardContainer(
                                                        icon: Icons.home_work, text: controller.estateList[index]["area"].toString()),
                                                      ListCardContainer(
                                                        icon: Icons.home, text: controller.estateList[index]["estate_type"].toString()),
                                                      ListCardContainer(
                                                        icon: Icons.account_circle, text: controller.estateList[index]["id"].toString()),
                                                      ListCardContainer(
                                                        icon: Icons.description, text: " ${controller.estateList[index]["estate_description"].toString()}"),
                                                    ],
                                                  ),
                                                  Image.asset(
                                                    controller.estateList[index]["Images"] == null
                                                      ? AppString.imagesAssetPath + "ic_flat_img.jpg"
                                                      : controller.estateList[index]["Images"],
                                                    height: 160,
                                                    width: 140,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
*/






                            ),
                          ],
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
          child: Txt(text,
            fontSize: 16,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
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
}
