import 'dart:convert';

import 'package:dio/dio.dart' as r;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'api_main.dart';
// import '../main_api_url.dart';
// var api=initial_api();
var api=ApisSetup();
class country_controller_ extends GetxController{
  var data=[].obs;
  var province=[].obs;
  var area=[].obs;
  var current_country="".obs;
  var current_city="".obs;
  var current_province="".obs;
  var cur_province_index=0.obs;
  var cur_city_index=0.obs;

  // var current_area="".obs;
  var loading=false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
  Future <dynamic> city(cit) async {
    current_city(cit);
    update();
  }
  Future<dynamic> getcountery() async{

    loading(true);
    r.Response response =
    await api.dio.post('api/v1/countries/');
    if(response.statusMessage!='OK'){
      // return Future.error(response.);
    } else {
      print("jason ${response.data}");
      data(response.data['data']);
      loading(false);
      update();
      // return response.data;
    }
  }
  Future<dynamic> getprovance(country_name,selected) async{
    province([]);
    current_country(country_name);
    loading(true);
    update();
    r.Response response = await api.dio.post('api/v1/province/',data: {"country":current_country.value});
    if(response.statusMessage!='OK'){
      // return Future.error(response.);
    } else {
      // print("jason ${response.data}");
      final jsonData = json.decode(response.data);
      var flag=false;
      for(int i=0;i<jsonData['data'].length;i++){

        // if(selected!=""){
          if(jsonData['data'][i]['province']==selected){
            cur_province_index(i);
            flag=true;
          }
          // else{
          //   cur_province_index(jsonData['data'].length+1);
          // }
        // }
        // else{
        //   cur_province_index(jsonData['data'].length+1);
        // }
        // cur_province_index
        province.add({"label":jsonData['data'][i]['province'],'value':jsonData['data'][i]['id']});
      }
      if(!flag){
        cur_province_index(jsonData['data'].length+1);
      }
      print("prinive ${province}");
      // province(response.data['data']);
      loading(false);
      update();
      // return response.data;
    }
  }
  Future<dynamic> getarea(pro,selected) async{
    area([]);
    current_province(pro);

    loading(true);
    update();

    r.Response response =
    await api.dio.post('api/v1/area/',data: {"country":current_country.value,"province":current_province.value});
    if(response.statusMessage!='OK'){

    } else {
      var flag=false;
      final jsonData = json.decode(response.data);
      for(int i=0;i<jsonData['data'].length;i++){

        // if(selected!=""){
          print("sleec ted ${selected} ${jsonData['data'][i]['city']}");
          if(jsonData['data'][i]['city']==selected){
            cur_city_index(i);
            flag=true;
          }

        // }
        // else{
        //   cur_city_index(jsonData['data'].length+1);
        // }
        area.add({"label":jsonData['data'][i]['city'],'value':jsonData['data'][i]['id']});
      }
      if(!flag){
        cur_city_index(jsonData['data'].length+1);
      }
      print("current city ${cur_city_index.value}");
      loading(false);
      update();
      // return response.data;
    }
  }


}