import 'dart:convert';
// import 'dart:html';

// import 'package:avunja_business/API/verify_number.dart';
import 'package:dio/dio.dart' as r;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'api_main.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:tailorapp/api/main.dart';
// import 'package:http/http.dart' as http;
// import 'package:avunja_business/API/languages.dart';
// var n=NewUser();
var api=ApisSetup();
class profileController extends GetxController {
  var data_profile= {}.obs;
  var loading=true.obs;
  var loading_profile=true.obs;
  var login=GetStorage('login');
  var data_search=[].obs;
  var current_country=0.obs;
  var add_loading=true.obs;
  var add_status="".obs;
  var code="".obs;
  var mapaddrerss="".obs;
  var longitude="".obs;
  var latitude="".obs;

  set_country(index){
    current_country(index);
    update();
  }
  set_google(add){
    mapaddrerss(add);
    update();
  }
  set_mapaddress(add,long,lat){
    mapaddrerss(add);
    longitude(long.toString());
    latitude(lat.toString());
    update();
  }
  Future<bool> update_profile(address,days,cat,service,appoint,deliver,per) async {
    print("appoint ${appoint} deliver ${deliver}");
    var tailor_id=await login.read('bus_id');
    r.Response d = await api.dio.post(api.get_bus_profile+"${tailor_id}",
      data: {
        'address': address,
        'days':days,
        "category_":cat,
        "service_":service,
        "appointment":appoint,
        "delivery":deliver,
        "per_hour":int.parse(per),
        'googleaddress':mapaddrerss.value,
        "latitude":latitude.value.toString(),
        "longitude":longitude.value.toString(),
        'tailor_id':tailor_id
      },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    print("json resp ${d.data}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      // print("jason data ${jsonData}");
      // data_profile(jsonData['data']);
      // print("data my ${data_my}");
      loading_profile(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> get_my_business() async {
    loading_profile(true);
    update();
    var tailor_id=await login.read('bus_id');
    print("tailor if ${tailor_id}");
    var tailor_id2=await login.read('tailor_id');
    // print(tailor_id);
    // print(tailor_id2);
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.get(api.get_bus_profile+"${tailor_id}",
      // data: {
      //   'phone': number,
      //   'code':code,
      //   'tailor_id':tailor_id
      // },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    print("data ${d}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      print("jason data ${jsonData}");
      data_profile(jsonData['data']);
      // print("data my ${data_my}");
      loading_profile(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> get_customers_my() async {
    loading(true);
    update();
    var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');
    print(tailor_id);
    print(tailor_id2);
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.get(api.get_customers_my+"/${tailor_id}",
      // data: {
      //   'username': email.value,
      //   'password': password.value,
      //   'grant_type': "password"
      // },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    print("data ${d}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      // data_my(jsonData['data']);
      // print("data my ${data_my}");
      loading(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> add_customers_my(index) async {
    // add_loading(true);
    data_search.value[index]['add_load']=true;
    update();
    var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');
    print(tailor_id);
    print(tailor_id2);
    var cus_id = data_search.value[index]['id'];

    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.post(api.get_customers_my+"/${tailor_id}",
      data: {
        'cus_id': cus_id,

      },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    print("data ${d}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);

      // if(jsonData['message']['error']=="This customer already added in your shop"){
      //   print("inside error");
      //   data_search.value[index]['add_status']="Customer already exist";
      //   update();
      // }
      // else {
      // data_my.add(jsonData['data']);/

      data_search.value[index]['add_status']="Added Successfully";
      // }
      data_search.value[index]['add_load']=false;

      // print("data my ${data_my}");
      // add_loading(false);
      update();
      return true;
    }

    return false;
  }
}