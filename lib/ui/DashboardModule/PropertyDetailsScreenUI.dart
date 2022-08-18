// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:croma_brokrage/ui/DashboardModule/QueryContactListScreenUI.dart';
import 'package:croma_brokrage/ui/DashboardModule/QueryScreenUI.dart';
import 'package:croma_brokrage/ui/MapScreenUI.dart';
import 'package:croma_brokrage/utils/AppColors.dart';
import 'package:croma_brokrage/utils/AppString.dart';
import 'package:croma_brokrage/widgets/RoundedButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/HomeController.dart';
import '../../controller/PropertyDetailsController.dart';
import '../../helper/PreferenceHelper.dart';
import '../../model/EstateListCommonResponse.dart';
import '../../utils/AppCommonFunction.dart';
import '../../widgets/EstateCardList.dart';
import '../../widgets/Txt.dart';


class PropertyDetailsScreenUI extends StatefulWidget {
  EstateList estateList;

  PropertyDetailsScreenUI({
        required this.estateList
  });

  @override
  State<PropertyDetailsScreenUI> createState() => _PropertyDetailsScreenUIState();
}

class _PropertyDetailsScreenUIState extends State<PropertyDetailsScreenUI> {
  PropertyDetailsController propertyDetailsController = Get.put(PropertyDetailsController());
  HomeController homeController = Get.put(HomeController());
  CarouselController carouselController = CarouselController();
  var lat = 0.0000;
  var long = 0.0000;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    getSuggestion();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder(
        init: PropertyDetailsController(),
        builder: (PropertyDetailsController controller) {
          return Scaffold(
            body: controller.isDataLoading
                ? AppCommonFunction.circularIndicator()
                : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [

                      /*AppBar(
                        toolbarHeight: 60,
                        title: Txt("Estate Details",color: Colors.white,fontSize: 18),
                        backgroundColor: AppColors.primaryColor,
                      ),*/


                      Container(
                        height: 60,
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_back_ios,color: AppColors.primaryColor,),
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                print("Estate ID  ::  ${widget.estateList.id}");
                                homeController.selectedEstateList.add(widget.estateList.id!);
                                Get.to(()=> QueryScreenUI() );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.share,color: Colors.blueAccent,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      CarouselSlider(
                        carouselController: carouselController,
                        items: [
                          Image.asset(AppString.imagesAssetPath+"ic_flat_img.jpg",fit: BoxFit.cover,),
                        ],
                        options: CarouselOptions(
                          height: Get.height/3,
                          aspectRatio: 20/9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          pageSnapping: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            //controller.updateDotIndex(index);
                          },

                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: 8),
                            Txt("Address",fontSize: 14),
                            SizedBox(height: 3),
                            Wrap(
                              children: [
                                Txt("${widget.estateList.society.toString().isEmpty ? "N/A" : widget.estateList.society.toString()}",fontSize: 17,fontWeight: FontWeight.w500),
                              ],
                            ),

                            Divider(thickness: 1,endIndent: 5,indent: 5),
                            Txt("Description",fontSize: 14),
                            SizedBox(height: 3),
                            Wrap(
                              children: [
                                Txt("${widget.estateList.estateDescription.toString().isEmpty ? "N/A": widget.estateList.estateDescription.toString()}",
                                    fontSize: 16,fontWeight: FontWeight.w500,maxLines: 7,overflow: TextOverflow.ellipsis),
                              ],
                            ),

                            Divider(thickness: 1,endIndent: 5,indent: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                widget.estateList.numberOfBedrooms == 0
                                  ? estateDetailContainer(icon: FontAwesomeIcons.treeCity, text: widget.estateList.city.toString())
                                  : estateDetailContainer(icon: FontAwesomeIcons.bed, text: widget.estateList.numberOfBedrooms.toString()),
                                Container(height: 40,width: 1,color: Colors.black38),
                                estateDetailContainer(icon: Icons.currency_rupee, text: widget.estateList.budget.toString()),
                                Container(height: 40,width: 1,color: Colors.black38),
                                estateDetailContainer(icon: FontAwesomeIcons.maximize, text: widget.estateList.floorSpace.toString()),

                              ],
                            ),
                            Divider(thickness: 1,endIndent: 20,indent: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                estateDetailContainer(icon: FontAwesomeIcons.cartFlatbed, text: widget.estateList.estateStatus.toString()),
                                Container(height: 40,width: 1,color: Colors.black38),
                                estateDetailContainer(icon: FontAwesomeIcons.locationArrow, text: widget.estateList.area.toString()),
                                Container(height: 40,width: 1,color: Colors.black38),
                                estateDetailContainer(icon: FontAwesomeIcons.city, text: widget.estateList.estateType.toString()),
                              ],
                            ),
                            Divider(thickness: 1,endIndent: 20,indent: 20),


                            SizedBox(height: 20),

                            Container(
                                height: 220,
                                child: controller.suggestionResponse.data!.isNotEmpty
                                  ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left:12.0,top: 10,bottom: 0),
                                      child: Txt("Suggestion",fontSize: 22,fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: EstateCardList(
                                        estateList: controller.suggestionResponse.data!,
                                        scrollDirection: Axis.horizontal,
                                        homeController: homeController,
                                      ),

                                    ),
                                  ],
                                )
                                  : Container(),

                              ),

                            SizedBox(height: 10),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                isLoading
                    ? Center(child: AppCommonFunction.circularIndicator(),)
                    : Container()
              ],
            ),
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


  Widget CardTextContainer({required IconData icon,required String text}){
    return Row(
      children: [
        Icon(icon,color: AppColors.primaryColor,size: 17,),
        SizedBox(width: 5,),
        Txt(text,fontSize: 16,color: AppColors.black,fontWeight: FontWeight.w600),
      ],
    );
  }


  getSuggestion(){

    propertyDetailsController.progressDataLoading(true);

    propertyDetailsController.suggestionListApi(
      token: PreferenceHelper().getUserData().authToken!,
      id: widget.estateList.id.toString()
    ).then((response) {

      if(response != null){
        if(response.success.toString() == "true"){
          if(response.data!.isNotEmpty){
            propertyDetailsController.suggestionResponse.data = response.data;
            propertyDetailsController.progressDataLoading(false);
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

  Widget estateDetailContainer({required IconData icon, required String text}){
    return Container(
      height: 60,
      width: 100,
      child: Column(
        children: [
          FaIcon(icon),
          SizedBox(height: 5),
          Txt(text,overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }


}
