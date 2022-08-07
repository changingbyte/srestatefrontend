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
  HomeController homeController = Get.put(HomeController());
  CarouselController carouselController = CarouselController();
  var lat = 0.0000;
  var long = 0.0000;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Txt("Estate Details",color: Colors.white,fontSize: 18),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Stack(
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
                      height: Get.height/2,
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
      ),
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

}
