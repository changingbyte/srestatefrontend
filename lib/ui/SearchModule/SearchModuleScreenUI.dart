import 'package:brokerBook/controller/SearchModuleController.dart';
import 'package:brokerBook/ui/SearchModule/BuyListScreenUI.dart';
import 'package:brokerBook/ui/SearchModule/SaleListScreenUI.dart';
import 'package:brokerBook/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:get/get.dart';


class SearchModuleScreenUI extends StatefulWidget {
  const SearchModuleScreenUI({Key? key}) : super(key: key);

  @override
  State<SearchModuleScreenUI> createState() => _SearchModuleScreenUIState();
}

class _SearchModuleScreenUIState extends State<SearchModuleScreenUI> {
  SearchModuleController searchController = Get.put(SearchModuleController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: "Buy",),
                Tab(text: "Sale",),
              ],
              labelColor: Colors.black,
              indicator: MaterialIndicator(
                height: 5,
                horizontalPadding: 40,
                color: AppColors.primaryColor,
                paintingStyle: PaintingStyle.fill,
              ),

            ),

            Expanded(
              child: TabBarView(
                children: [
                  BuyListScreenUI(),
                  SaleListScreenUI(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}






