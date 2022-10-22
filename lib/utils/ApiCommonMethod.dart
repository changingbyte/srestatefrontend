import 'package:http/http.dart' as http;
import 'dart:convert';
import 'AppString.dart';
import '../../model/FilterDataResponse.dart';


Future<dynamic> globalGetApiMethod({String? moduleName,String? operationType,String? argument,String? token,dynamic responseClass}) async {
  //try{

    http.Response response = await http.get(
        Uri.parse("http://srestateapi.herokuapp.com/api/v1/property/estate/filter_details/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Token 27ac81090a85f2194417dda31f1eb0f8f90e30db",
        }
    ).timeout(
        Duration(seconds: 30),
        onTimeout: () async{
          //AppCommonFunction.flutterToast("Temporary site in under maintenance!", false);
          return Future.value();
        });

    print("RESPONSE  ::  ${response.body}");
    print("TYPEE  ::  ${responseClass}");
    print("TYPEE  ::  ${responseClass.runtimeType}");
    if(response.statusCode == 200){
      if(response.body != null){
        return json.decode(response.body);
      }
      else{
        //progressDataLoading(false);
        //return AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
      }
    }
    else{
      //progressDataLoading(false);
      //AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
      throw Exception(AppString.somethingWentWrong);
    }


  /*}
  catch (e){
    //progressDataLoading(false);
    //AppCommonFunction.flutterToast(AppString.somethingWentWrong, false);
    print("ERROR  ::  $e");
    throw Exception(AppString.somethingWentWrong);

  }*/
}



