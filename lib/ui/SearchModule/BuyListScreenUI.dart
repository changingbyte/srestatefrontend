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
          return


            controller.isDataLoading
            ? AppCommonFunction.circularIndicator()
            : controller.buyEstateList.length < 1
              ? AppCommonFunction.noDataFound()
              : ListView.builder(
            itemCount: controller.buyEstateList.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(top: 5,bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      child: InkWell(
                        onTap: () {

                          },
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
                                        width: Get.width/2,
                                        child: Txt(controller.buyEstateList[index].estateName.toString(),
                                            fontSize: 20,color: AppColors.black,fontWeight: FontWeight.bold),
                                      ),

                                      SizedBox(height: 13,),

                                      ListCardContainer(icon: Icons.location_on,text: controller.buyEstateList[index].society.toString()),

                                      ListCardContainer(icon: Icons.home_work,text: controller.buyEstateList[index].area.toString()),

                                      ListCardContainer(icon: Icons.photo_size_select_small_outlined,text: " ${controller.buyEstateList[index].floorSpace.toString()}"),

                                      ListCardContainer(icon: Icons.call,text: controller.buyEstateList[index].id.toString()),

                                    ],
                                  ),

                                  Image.asset(AppString.imagesAssetPath+"ic_flat_img.jpg", height: 160,width: 140,fit: BoxFit.cover,),

                                ],
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


  Widget ListCardContainer({required IconData icon,required String text}){
    return Wrap(
      children: [
        Icon(icon,color: AppColors.primaryColor,size: 17,),
        SizedBox(width: 5,),
        Container(
          width: Get.width/2.5,
          child: Txt(text,fontSize: 16,color: AppColors.black,fontWeight: FontWeight.w600,
            maxLines: 4,overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
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
