// ignore_for_file: must_be_immutable

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:multi_select_item/multi_select_item.dart';

import '../controller/HomeController.dart';
import '../model/EstateListCommonResponse.dart';
import '../ui/DashboardModule/PropertyDetailsScreenUI.dart';
import '../utils/AppColors.dart';
import '../utils/AppCommonFunction.dart';
import '../utils/AppString.dart';
import 'Txt.dart';

class EstateCardList extends StatelessWidget {
  List<EstateList> estateList;
  HomeController homeController;
  Axis? scrollDirection;
  String? page;
  EstateCardList({required this.estateList, this.scrollDirection = Axis.vertical, required this.homeController,this.page});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: scrollDirection!,
        itemCount: estateList.length,
        itemBuilder: (context, index) {
          if(homeController.myMultiSelectController.isSelected(index)){
            homeController.selectedEstateList.add(estateList[index].id!);
          }
          else{
            for(int i=0; i< estateList.length; i++){
              if(!homeController.myMultiSelectController.isSelected(index)){
                homeController.selectedEstateList.remove(estateList[index].id!);
              }
            }
          }

          return MultiSelectItem(
            isSelecting: homeController.myMultiSelectController.isSelecting,
            onSelected: () {
              homeController.isToggle(index);
            },
            child: index != 0 && index % 4 == 0
              ? Column(
              children: [
                SizedBox(height: 5),
                AppCommonFunction.adsBanner(admobBannerSize: AdmobBannerSize.LARGE_BANNER),
                SizedBox(height: 5),
                cardWidget(index: index),

              ],
            )
              : cardWidget(index: index)



          );
        },
      );

  }


  Widget ListCardContainer({required IconData icon,required String text,double fontSize = 16,double iconSize = 17,Color iconColor = AppColors.primaryColor}){
    return Wrap(
      children: [
        Icon(icon,color: iconColor,size: iconSize,),
        SizedBox(width: 10,),
        Container(
          width: Get.width/2.5,
          child: Txt(text,fontSize: fontSize,color: AppColors.black,fontWeight: FontWeight.w600,
            maxLines: 4,overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }


  Widget cardWidget({required int index}){
    return Card(
      elevation: 10,
      color: homeController.myMultiSelectController.isSelected(index)
          ? Colors.grey.shade400
          : estateList[index].isMyProperty!
          ? Colors.white
          : AppColors.premiumColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)),),
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

                    estateList[index].isMyProperty!
                        ? Container()
                        : ListCardContainer(icon: FontAwesomeIcons.crown,text: "Premium",fontSize: 20,iconSize: 20,iconColor: Colors.black),

                    SizedBox(height: 10),

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
    );
  }

}
