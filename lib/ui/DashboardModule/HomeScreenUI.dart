import 'package:admob_flutter/admob_flutter.dart';
import 'package:croma_brokrage/helper/PreferenceHelper.dart';
import 'package:croma_brokrage/ui/DashboardModule/AddEstateScreenUI.dart';
import 'package:croma_brokrage/ui/EstateListScreenUI.dart';
import 'package:croma_brokrage/utils/AppColors.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:croma_brokrage/widgets/EstateCardList.dart';
import 'package:croma_brokrage/widgets/ScaffoldWidget.dart';
import 'package:croma_brokrage/widgets/TextFormInputField.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../controller/DashboardController.dart';
import '../../controller/HomeController.dart';
import '../../model/EstateListCommonResponse.dart';
import '../../utils/AppString.dart';
import '../../widgets/Txt.dart';
import 'PropertyDetailsScreenUI.dart';

class HomeScreenUI extends StatefulWidget {
  const HomeScreenUI({Key? key}) : super(key: key);

  @override
  State<HomeScreenUI> createState() => _HomeScreenUIState();
}

class _HomeScreenUIState extends State<HomeScreenUI> {
  HomeController homeController = Get.put(HomeController());
  DashboardController dashboardController = Get.put(DashboardController());
  var budgetValue = SfRangeValues(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      print("---HOME CLEAR---");
      homeController.deselectItems();
      homeController.selectedEstateList.clear();

      getEstateApi();
      getFilterApi();
    });

  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: () {
          Get.to(()=> AddEstateScreenUI(), );
        },
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormInputField(
                    hintText: "Search Estates",
                    iconPrefix: Icons.search,
                    onChanged: (val){
                      onItemSearch(val,homeController.newEstateList,homeController);
                    },
                  ),
                ),
              ),

              InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => filterDialog()
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Icon(Icons.filter_alt_outlined,color: AppColors.white,size: 24),
                  )
              ),
            ],
          ),


          Container(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CardContainer(text: "flat",icon: FontAwesomeIcons.building),
                CardContainer(text: "shop",icon: FontAwesomeIcons.shop),
                CardContainer(text: "plot",icon: FontAwesomeIcons.houseChimney),
                CardContainer(text: "bunglow",icon: FontAwesomeIcons.houseChimney),
                CardContainer(text: "rowhouse",icon: FontAwesomeIcons.houseMedicalCircleExclamation),
                CardContainer(text: "land",icon: FontAwesomeIcons.houseChimney),
              ],
            ),
          ),


          Expanded(
            child: GetBuilder(
              init: HomeController(),
              builder: (HomeController controller) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: controller.isDataLoading
                      ? AppCommonFunction.circularIndicator()
                      : controller.estateList.isEmpty
                        ? AppCommonFunction.noDataFound()
                        : EstateCardList(
                        estateList: controller.estateList,
                        homeController: homeController,
                      ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }


  Widget CardContainer({required String text,required IconData icon}){
    return Container(
      padding: EdgeInsets.only(left: 7, right: 7),
      child: InkWell(
        onTap: () {
          Get.to(()=> EstateListScreenUI(estateName: text,))!.then((value){
            print("--------ABCD------------");
            homeController.deselectItems();
            homeController.selectedEstateList.clear();
            getEstateApi();
            getFilterApi();
          });
        },
        child: Column(
          children: [
            Card(
              color: AppColors.primaryColor.withOpacity(0.3),
              elevation: 25,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10),)),
              child: Container(
                height: 65,
                width: 65,
                alignment: Alignment.center,
                child: FaIcon(icon,color: Colors.white,size: 30),
              ),
            ),
            SizedBox(height: 5),
            Center(child: Txt(text,fontSize: 17,color: AppColors.primaryColor,fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }

  Widget filterDialog() {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: GetBuilder(
            init: HomeController(),
            builder: (HomeController controller) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: AppColors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 12, top: 12, left:12,),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color:AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                topLeft: Radius.circular(8))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "Filter",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white),
                          ),
                        ),
                      ),

                      filterDropdownWidget(
                        title: controller.filterAreaListTitle.toString(),
                        list: controller.filterAreaList,
                        onChanged: (newValue){
                          controller.updateAreaListTitle(newValue);
                        }
                      ),

                      SizedBox(height: 10),

                      filterDropdownWidget(
                          title: controller.filterPropertyTypeTitle.toString(),
                          list: controller.filterPropertyTypeList,
                          onChanged: (newValue){
                            controller.updatePropertyTypeTitle(newValue);
                          }
                      ),


                      SizedBox(height: 10),

                      filterDropdownWidget(
                          title: controller.filterFurnitureTitle.toString(),
                          list: controller.filterFurnitureList,
                          onChanged: (newValue){
                            controller.updateFurnitureTitle(newValue);
                          }
                      ),


                      SizedBox(height: 10),

                      filterDropdownWidget(
                          title: controller.filterEstateCategoryTitle.toString(),
                          list: controller.filterEstateCategoryList,
                          onChanged: (newValue){
                            controller.updateEstateCategoryTitle(newValue);
                          }
                      ),

                      SizedBox(height: 10),

                      filterDropdownWidget(
                          title: controller.filterBHKTitle.toString(),
                          list: controller.filterBHKList,
                          onChanged: (newValue){
                            controller.updateBHKTitle(newValue.toString());
                          }
                      ),

                      SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          TextButton(
                              onPressed: () {
                                controller.progressDataLoading(true);

                                getEstateApi(
                                  area: [controller.filterAreaListTitle],
                                  furniture: [controller.filterFurnitureTitle],
                                  no_of_bedrooms: [controller.filterBHKTitle],
                                  estateStatus: [controller.filterEstateCategoryTitle],
                                );

                                Get.back();
                              },
                              child: Text("Ok")),

                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Cancel")),
                        ],
                      ),

                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  getEstateApi({List<String>? area = const [],List<String>? apartment = const [],List<String>?  budget = const [],
    List<String>? estateStatus = const [],List<String>? furniture = const [],List<String>? no_of_bedrooms = const []}){
    homeController.progressDataLoading(true);
    homeController.estateList.clear();
    homeController.newEstateList.clear();

    if(area!.contains("Area") ){area.clear();}
    if(furniture!.contains("Furniture Type") ){furniture.clear();}
    if(no_of_bedrooms!.contains("BHK")){no_of_bedrooms.clear();}
    if(estateStatus!.contains("Estate Status")){estateStatus.clear();}


    homeController.estateListApi(
      token: PreferenceHelper().getUserData().authToken!,
      area: area,
      apartment: apartment,
      budget: budget,
      estate_status: estateStatus,
      furniture: furniture,
      no_of_bedrooms: no_of_bedrooms,
    ).then((value) {

      if(value != null){
        if(value.success.toString() == "true"){
          if(value.data!.isNotEmpty){

            homeController.estateList = value.data!.reversed.toList();
            homeController.newEstateList = value.data!.reversed.toList();
            homeController.myMultiSelectController.disableEditingWhenNoneSelected = true;
            homeController.myMultiSelectController.set(homeController.estateList.length);
            homeController.progressDataLoading(false);

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

  getFilterApi(){
    homeController.filterApi(token: PreferenceHelper().getUserData().authToken!).then((response) {

      if(response != null){
        if(response.success.toString() == "true"){

          homeController.data = response.data;
          homeController.filterAreaList.addAll(homeController.data!.area!);
          homeController.filterPropertyTypeList.addAll(homeController.data!.estateStatus!);
          homeController.filterFurnitureList.addAll(homeController.data!.furniture!);
          homeController.filterEstateCategoryList.addAll(homeController.data!.estateType!);
          homeController.filterBudgetList.addAll(homeController.data!.budget!);

          for(int i=0 ;i<homeController.data!.rooms!.length; i++){
            homeController.filterBHKList.add(homeController.data!.rooms![i].toString());
          }

          homeController.intervalValue = homeController.filterBudgetList.last / 4;
          budgetValue = SfRangeValues(homeController.filterBudgetList.first, homeController.intervalValue);

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

  onItemSearch(String value,List<EstateList> newEstateList,HomeController homeController) {
    homeController.estateList = newEstateList.where((string) => string.estateName!.toLowerCase().contains(value.toLowerCase())).toList();
    setState((){});
  }

  filterDropdownWidget({required String title,required List<String> list,required ValueChanged onChanged}){
    return DropdownButton(
      hint: Txt(title,fontWeight: FontWeight.w500),
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      items: list.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items.toString()),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

}
