// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
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
import '../../model/EstateListResponse.dart';
import '../../utils/AppCommonFunction.dart';
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
            appBar: AppBar(
              title: Txt("Estate Details",color: Colors.white,fontSize: 18),
              backgroundColor: AppColors.primaryColor,
            ),
            body:

            controller.isDataLoading
                ? AppCommonFunction.circularIndicator()
                : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [

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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              height: 120,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [

                                  Column(
                                    children: [
                                      FaIcon(FontAwesomeIcons.city),
                                      Txt("${widget.estateList.city}"),
                                    ],
                                  ),


                                  SizedBox(width: 30),


                                  Column(
                                    children: [
                                      FaIcon(FontAwesomeIcons.locationArrow),
                                      Txt("${widget.estateList.area}"),
                                    ],
                                  ),


                                  SizedBox(width: 30),

                                  Column(
                                    children: [
                                      FaIcon(FontAwesomeIcons.building),
                                      Txt("${widget.estateList.society}"),
                                    ],
                                  ),

                                  SizedBox(width: 30),

                                  Column(
                                    children: [
                                      FaIcon(FontAwesomeIcons.rupeeSign),
                                      Txt("${widget.estateList.budget}"),
                                    ],
                                  ),



                                ],
                              ),
                            ),


                            /*
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CardTextContainer(icon: Icons.photo_size_select_small_outlined,text: widget.estateList.floorSpace.toString()),

                                      CardTextContainer(icon: Icons.location_on,text: widget.estateList.city.toString()),
                                    ],
                                  ),

                                  SizedBox(height: 5,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CardTextContainer(icon: FontAwesomeIcons.layerGroup,text: widget.estateList.area.toString()),

                                      CardTextContainer(icon: Icons.home_work,text: widget.estateList.society.toString()),
                                    ],
                                  ),

                                  SizedBox(height: 5,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CardTextContainer(icon: Icons.description,text: widget.estateList.estateDescription.toString()),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
*/


                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,top: 10,bottom: 10),
                                    child: Txt("Available",fontSize: 18,fontWeight: FontWeight.w500),
                                  ),

                                  Switch(
                                    value:  widget.estateList.estateStatus == "available" ? true :  false,
                                    activeColor: AppColors.primaryColor,
                                    onChanged:(value) {
                                    },),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 30,
                            ),

                            Center(
                              child: RoundedButtonWidget(
                                text: "Share",
                                height: 45,
                                width: Get.width/1.5,
                                onPressed: () {
                                  AppCommonFunction.flutterToast("Navigate", true);
                                  Get.to(()=> PropertyDetailsScreenUI(estateList: widget.estateList,),);
                                },
                              ),
                            ),

                            SizedBox(height: 10),

                            /*
                          Center(
                            child: RoundedButtonWidget(
                              text: "View in Map",
                              height: 45,
                              width: Get.width/1.5,
                              onPressed: () {

                              },
                            ),
                          ),
                          */



                            Container(
                                height: 80,
                                child:
                                controller.suggestionResponse.data!.isNotEmpty
                                  ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left:18.0,top: 10,bottom: 0),
                                      child: Txt("Suggestion",fontSize: 25,fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: controller.suggestionResponse.data!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.only(top: 0,bottom: 5,left: 10,right: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Card(
                                              elevation: 8,
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
                                                              child: Txt(controller.suggestionResponse.data![index].estateName!.toString(),
                                                                  fontSize: 20,color: AppColors.black,fontWeight: FontWeight.bold),
                                                            ),

                                                            SizedBox(height: 13,),

                                                            ListCardContainer(icon: Icons.location_on,text: "${controller.suggestionResponse.data![index].society!}"),

                                                            ListCardContainer(icon: Icons.home_work,text: "${controller.suggestionResponse.data![index].area!}"),

                                                            ListCardContainer(icon: Icons.photo_size_select_small_outlined,text: "floor_space"),


                                                          ],
                                                        ),

                                                        Image.asset(AppString.imagesAssetPath+"ic_flat_img.jpg",
                                                          height: 160,width: 140,fit: BoxFit.cover,),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                                  : Container(),


                              )


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

}
