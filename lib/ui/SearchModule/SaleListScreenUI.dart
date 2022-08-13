import 'package:croma_brokrage/helper/PreferenceHelper.dart';
import 'package:croma_brokrage/widgets/Txt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_item/multi_select_item.dart';

import '../../controller/HomeController.dart';
import '../../controller/SearchModuleController.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppCommonFunction.dart';
import '../../utils/AppString.dart';

class SaleListScreenUI extends StatefulWidget {
  const SaleListScreenUI({Key? key}) : super(key: key);

  @override
  State<SaleListScreenUI> createState() => _SaleListScreenUIState();
}

class _SaleListScreenUIState extends State<SaleListScreenUI> {
  SearchModuleController searchModuleController = Get.put(SearchModuleController());
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
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
              : controller.saleEstateList.length < 1
                  ? AppCommonFunction.noDataFound()
                  : ListView.builder(
                      itemCount: controller.saleEstateList.length,
                      itemBuilder: (context, index) {

                        if(homeController.myMultiSelectController.isSelected(index)){
                          homeController.selectedEstateList.add(controller.saleEstateList[index]['id']);
                        }
                        else{
                          for(int i=0; i< controller.buyEstateList.length; i++){
                            if(!homeController.myMultiSelectController.isSelected(index)){
                              homeController.selectedEstateList.remove(controller.saleEstateList[index]['id']);
                            }
                          }
                        }


                        return MultiSelectItem(
                          isSelecting: homeController.myMultiSelectController.isSelecting,
                          onSelected: () {

                            setState(() {
                              homeController.isToggle(index);
                            });

                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              child: Card(
                                color: homeController.myMultiSelectController.isSelected(index)
                                    ? Colors.grey.shade400
                                    : Colors.white,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(7)),
                                ),
                                child: InkWell(
                                  onTap: () {},
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
                                                child: Txt(controller.saleEstateList[index]["estate_name"].toString(),
                                                    fontSize: 20, color: AppColors.black, fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 13,
                                              ),
                                              ListCardContainer(icon: Icons.location_on, text: controller.saleEstateList[index]["society"].toString()),
                                              ListCardContainer(icon: Icons.home_work, text: controller.saleEstateList[index]["area"].toString()),
                                              ListCardContainer(
                                                  icon: Icons.photo_size_select_small_outlined,
                                                  text: " ${controller.saleEstateList[index]["floor_space"].toString()}"),
                                              ListCardContainer(icon: Icons.call, text: controller.saleEstateList[index]["id"].toString()),
                                            ],
                                          ),
                                          Image.asset(
                                            controller.saleEstateList[index]["Images"] == null
                                                ? AppString.imagesAssetPath + "ic_flat_img.jpg"
                                                : controller.saleEstateList[index]["Images"],
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
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }

  Widget ListCardContainer({required IconData icon, required String text}) {
    return Wrap(
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
          size: 17,
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          width: Get.width / 2.5,
          child: Txt(
            text,
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

  getEstateBuyListApi() {
    searchModuleController.saleEstateListApi(token: PreferenceHelper().getUserData().authToken!).then((value) {
      if (value != null) {
        if (value["success"].toString() == "true") {
          if (value["data"].isNotEmpty) {
            searchModuleController.saleEstateList = value["data"];
            searchModuleController.progressDataLoading(false);
          }
        } else {
          AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
        }
      } else {
        AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
      }
    });
  }
}
