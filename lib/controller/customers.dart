import 'dart:convert';
// import 'dart:html';

// import 'package:avunja_business/API/verify_number.dart';
import 'package:dio/dio.dart' as r;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'api_main.dart';
// import 'package:tailorapp/api/main.dart';
// import 'package:http/http.dart' as http;
// import 'package:avunja_business/API/languages.dart';
// var n=NewUser();
var api=ApisSetup();
class CustomerController extends GetxController {
  var data_my=[].obs;
  var loading=true.obs;
  var loading_search=true.obs;
  var login=GetStorage('login');
  var data_search=[].obs;
  var current_country=0.obs;
  var current_customer=0.obs;
  var current_customer_s=0.obs;
  var add_loading=true.obs;
  var add_status="".obs;
  var code="".obs;
  var current_pop_data={}.obs;
  var current_sort="".obs;
  set_sort(sort){
    current_sort(sort);
    update();
  }
  set_current_data(d){
    current_pop_data(d);
    update();
  }
  set_customer(index){
    current_customer(index);
    // print(data_my.value[current_customer.value]);
    update();
  }
  set_customer_s(index){
    current_customer_s(index);
    // print(data_my.value[current_customer.value]);
    update();
  }
  set_country(index){
    current_country(index);
    update();
  }

  Future<bool> get_customers_search(number,code) async {
    loading_search(true);
    update();
    var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');
    // print(tailor_id);
    // print(tailor_id2);
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.post(api.get_customers,
      data: {
        'phone': number,
        'code':code,
        'tailor_id':tailor_id
      },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    print("data ${d}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      data_search(jsonData['data']);
      print("data my ${data_my}");
      loading_search(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> get_customers_my() async {
    // loading(true);
    // update();
    var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');
    // print(tailor_id);
    // print(tailor_id2);
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.get(api.get_customers_my+"/${tailor_id}"+"?sort=${current_sort.value}",
    );
    print("data ${d}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      data_my(jsonData['data']);
      print("data my ${data_my}");
      loading(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> add_customers_my(index_) async {
    // add_loading(true);
    print("index ${index_}");
    print("customer ${current_customer_s.value}");
    data_search.value[current_customer_s.value]['add_load']=true;
    print("data search ${data_search.value}");
    update();
    var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');

    print(tailor_id);
    print(tailor_id2);
    var cus_id = data_search.value[current_customer_s.value]['id'];
    print("cus id ${cus_id}");
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.post(api.get_customers_my+"/${tailor_id}",
      data: {
        'cus_id': cus_id,

      },
    );
    // print("data ${d}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      print("Respoonse of apis ${jsonData['data']}");
      if(jsonData['message']['error']=="This customer already added in your shop"){
        print("inside error");
        data_search.value[current_customer_s.value]['add_status']="Customer already exist";
        update();
      }
      else {

        data_my.add(jsonData['data']);

        data_search.value[current_customer_s.value]['add_status']="Added Successfully";
      }
      data_search.value[current_customer_s.value]['add_load']=false;

      // print("data my ${data_my}");
      // add_loading(false);
      update();
      return true;
    }

    return false;
  }
}