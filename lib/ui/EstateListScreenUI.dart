import 'package:croma_brokrage/helper/PreferenceHelper.dart';
import 'package:croma_brokrage/utils/AppColors.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/widgets/TextFormInputField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/AppString.dart';
import '../controller/EstateListController.dart';
import '../widgets/Txt.dart';
import 'DashboardModule/PropertyDetailsScreenUI.dart';

class EstateListScreenUI extends StatefulWidget {
  String estateName;

  EstateListScreenUI({this.estateName = ""});

  @override
  State<EstateListScreenUI> createState() => _EstateListScreenUIState();
}

class _EstateListScreenUIState extends State<EstateListScreenUI> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  EstateListController estateListController = Get.put(EstateListController());


  @override
  void initState() {
    super.initState();
    getEstateApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                          child:
                          controller.estateList == null
                              ? Center(child: CircularProgressIndicator())
                              : controller.estateList.length < 1
                              ? Center(
                            child: Txt("No Data Found!",
                              color: AppColors.primaryColor,fontSize: 20,fontWeight: FontWeight.bold),
                          )
                              : ListView.builder(
                            itemCount: estateListController.estateList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 3,bottom: 5),
                                child: InkWell(
                                  onTap: () {

                                    //send data
                                    /*Get.to(() =>
                                        PropertyDetailsScreenUI(
                                          area: controller.estateList[index]["area"].toString(),
                                          balconies_space: controller.estateList[index]["balconies_space"].toString(),
                                          broker_mobile: controller.estateList[index]["broker_mobile"].toString(),
                                          broker_name: controller.estateList[index]["broker_name"].toString(),
                                          city: controller.estateList[index]["city"].toString(),
                                          estate_description: controller.estateList[index]["estate_description"].toString(),
                                          estate_name: controller.estateList[index]["estate_name"].toString(),
                                          estate_status: controller.estateList[index]["estate_status"].toString(),
                                          estate_type: controller.estateList[index]["estate_type"].toString(),
                                          floor_space: controller.estateList[index]["floor_space"].toString(),
                                          number_of_balconies: controller.estateList[index]["number_of_balconies"].toString(),
                                          number_of_bathrooms: controller.estateList[index]["number_of_bathrooms"].toString(),
                                          number_of_bedrooms: controller.estateList[index]["number_of_bedrooms"].toString(),
                                          number_of_garages: controller.estateList[index]["number_of_garages"].toString(),
                                          number_of_parking_spaces: controller.estateList[index]["number_of_parking_spaces"].toString(),
                                          pets_allowed: controller.estateList[index]["pets_allowed"].toString(),
                                          society: controller.estateList[index]["society"].toString(),
                                        )
                                    );*/
                                  },
                                  child: Card(
                                    elevation: 10,
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
                                                  child: Txt(estateListController.estateList[index]["estate_name"],
                                                    fontSize: 20,color: AppColors.black,fontWeight: FontWeight.bold),
                                                ),

                                                SizedBox(height: 13,),

                                                ListCardContainer(icon: Icons.location_on,text: controller.estateList[index]["city"].toString()),

                                                ListCardContainer(icon: Icons.home_work,text: controller.estateList[index]["area"].toString()),

                                                ListCardContainer(icon: Icons.home,text: controller.estateList[index]["estate_type"].toString()),

                                                ListCardContainer(icon: Icons.account_circle,text: controller.estateList[index]["broker_name"].toString()),

                                                ListCardContainer(icon: Icons.description,text: " ${controller.estateList[index]["estate_description"].toString()}"),


                                              ],
                                            ),

                                            Image.asset(
                                              controller.estateList[index]["Images"] == null
                                                  ? AppString.imagesAssetPath+"ic_flat_img.jpg"
                                                  : controller.estateList[index]["Images"],
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
                    );
                  },
                ),
              ),

            ],
          ),
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

  getEstateApi(){
    estateListController.estateListApi(token: PreferenceHelper().getUserData().authToken!,estateName: widget.estateName).then((value) {

      if(value != null){
        if(value["success"].toString() == "true"){
          if(value["data"].isNotEmpty){
            estateListController.estateList = value["data"];
            print("Estate Listtttt  ::  ${estateListController.estateList}");

            estateListController.progressDataLoading(false);
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
