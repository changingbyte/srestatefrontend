// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_item/multi_select_item.dart';

import '../controller/HomeController.dart';
import '../model/EstateListResponse.dart';
import '../ui/DashboardModule/PropertyDetailsScreenUI.dart';
import '../utils/AppColors.dart';
import '../utils/AppString.dart';
import 'Txt.dart';

class EstateCardList extends StatelessWidget {
  List<EstateList> estateList;
  HomeController? homeController;

  EstateCardList({required this.estateList, this.homeController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: estateList.length,
        itemBuilder: (context, index) {
          if(homeController!.myMultiSelectController.isSelected(index)){
            homeController!.selectedEstateList.add(estateList[index].id!);
          }
          else{
            for(int i=0; i< estateList.length; i++){
              if(!homeController!.myMultiSelectController.isSelected(index)){
                homeController!.selectedEstateList.remove(estateList[index].id!);
              }
            }
          }

          return MultiSelectItem(
            isSelecting: homeController!.myMultiSelectController.isSelecting,
            onSelected: () {
                homeController!.isToggle(index);
            },
            child: Card(
              elevation: 10,
              color: homeController!.myMultiSelectController.isSelected(index)
                  ? Colors.grey.shade400
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(() => PropertyDetailsScreenUI(estateList: estateList[index],),);
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

                            estateList[index].area!.isEmpty
                                ? Container()
                                : ListCardContainer(icon: Icons.location_on,text: estateList[index].area!),

                            SizedBox(height: 7),

                            estateList[index].estateType!.isEmpty
                                ? Container()
                                : ListCardContainer(icon: Icons.home_work,text: estateList[index].estateType!),

                            SizedBox(height: 7),

                            estateList[index].estateStatus!.isEmpty
                                ? Container()
                                : ListCardContainer(icon: Icons.account_balance_sharp,text: estateList[index].estateStatus!),

                            SizedBox(height: 7),

                            estateList[index].budget!.toString() == "0"
                                ? Container()
                                : ListCardContainer(icon: Icons.currency_rupee,text: estateList[index].budget!.toString()),

                            SizedBox(height: 7),

                            estateList[index].numberOfBedrooms!.toString() == "0"
                                ? Container()
                                : ListCardContainer(icon: Icons.add_business_outlined,text: estateList[index].numberOfBedrooms.toString(),),

                          ],
                        ),

                        Image.asset(AppString.imagesAssetPath+"ic_flat_img.jpg", height: 160,width: 140,fit: BoxFit.cover,),

                      ],
                    ),
                  ),
                ),
              ),
            )

          );
        },
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

}