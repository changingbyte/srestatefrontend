import 'package:croma_brokrage/controller/ViewProfileController.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/PreferenceHelper.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppString.dart';
import '../../widgets/Txt.dart';

class ViewProfileScreenUI extends StatefulWidget {
  String contactNumber;
  ViewProfileScreenUI({required this.contactNumber});

  @override
  State<ViewProfileScreenUI> createState() => _ViewProfileScreenUIState();
}

class _ViewProfileScreenUIState extends State<ViewProfileScreenUI> {

  ViewProfileController viewProfileController = Get.put(ViewProfileController());


  @override
  void initState() {
    super.initState();
    getChatProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              backgroundColor: AppColors.primaryColor,
              centerTitle: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(widget.contactNumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      )),
                  background: Image.network(
                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body:

          GetBuilder(
            init: ViewProfileController(),
            builder: (ViewProfileController controller) {
              return Container(
                child: viewProfileController.isDataLoading
                    ? AppCommonFunction.circularIndicator()
                    : viewProfileController.chatProfileData!.eststateList!.isEmpty
                    ? AppCommonFunction.noDataFound()
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left:18.0,top: 10,bottom: 0),
                      child: Txt("Estates",fontSize: 25,fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: viewProfileController.chatProfileData!.eststateList!.length,
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
                                              child: Txt(viewProfileController.chatProfileData!.eststateList![index].estateName.toString(),
                                                  fontSize: 20,color: AppColors.black,fontWeight: FontWeight.bold),
                                            ),

                                            SizedBox(height: 13,),

                                            ListCardContainer(icon: Icons.location_on,text: "${viewProfileController.chatProfileData!.eststateList![index].society}"),

                                            ListCardContainer(icon: Icons.home_work,text: "${viewProfileController.chatProfileData!.eststateList![index].area}"),

                                            ListCardContainer(icon: Icons.photo_size_select_small_outlined,text: "floor_space"),

                                            ListCardContainer(icon: Icons.call,text:"broker_mobile"),


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
                ),
              );
            },

          ),

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




  getChatProfile(){
    viewProfileController.progressDataLoading(true);
    viewProfileController.chatProfileApi(token: PreferenceHelper().getUserData().authToken!,).then((value) {

      if(value != null){
        if(value.success.toString() == "true"){
          if(value.data != null ){
            viewProfileController.chatProfileData = value.data;
            viewProfileController.progressDataLoading(false);
          }
        }
        else{
          AppCommonFunction.flutterToast("Something went wrong", false);
        }


      }
      else{
        AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
      }

    });
  }


}






