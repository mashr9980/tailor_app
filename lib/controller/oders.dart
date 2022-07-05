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
class OrdersController extends GetxController {
  var data_my=[].obs;
  var loading=true.obs;
  var loading_search=true.obs;
  var login=GetStorage('login');
  var data_search=[].obs;
  var current_country=0.obs;
  var current_customer=0.obs;
  var add_loading=true.obs;
  var add_status="".obs;
  var data_search_phone=[].obs;
  var data_search_id=[].obs;
  var loading_id=true.obs;
  RxString sp_inst="".obs;
  var sp_image="".obs;
  var code="".obs;
  @override
  void onInit() {
    super.onInit();
    //Change value to name2
    get_order();
  }


   set_sp_(sp_inst_,sp_img_){
     print(sp_inst_);
  sp_inst(sp_inst_);
  print("Cur ${sp_inst.value}");
  sp_image(sp_img_);
  update();
  }
  set_customer(index){
    current_customer(index);
    print(data_my.value[current_customer.value]);
    update();
  }
  set_country(index){
    current_country(index);
    update();
  }
  Future<bool> change_order(id,status) async {
    // loading(true);
    update();
    // var tailor_id=await login.read('bus_id');
    // var tailor_id2=await login.read('tailor_id');
    // print(tailor_id);
    // print(tailor_id2);
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.put(api.oders,
      data: {
        'order_id': id,
        'status':status,

      },

      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      // final jsonData = json.decode(d.data);
      // data_my(jsonData['data']);
      // print("data my ${data_my}");/
      // loading(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> get_order_by_id(e) async {
    loading_id(true);
    update();
    var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');
    // print(tailor_id);
    // print(tailor_id2);
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.post(api.orders_filter+"/${tailor_id}",
      data: {
        'oder_id': e,

      },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      data_search_id(jsonData['data']);
      // print("data my ${data_my}");/
      loading_id(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> get_order_by_number(phone) async {
    loading_search(true);
    update();
    var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');
    // print(tailor_id);
    // print(tailor_id2);
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.post(api.orders_filter+"/${tailor_id}",
      data: {
        'phone': phone,

      },

      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      data_search_phone(jsonData['data']);
      // print("data my ${data_my}");/
      loading_search(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> get_order() async {
    loading(true);
    update();
    var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');
    // print(tailor_id);
    // print(tailor_id2);
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.get(api.oders+"/${tailor_id}",

      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      data_my(jsonData['data']);
      // print("data my ${data_my}");/
      loading(false);
      update();
      return true;
    }
     return false;
  }
  Future<bool> add_order(m_id,cus_id,date,qnt,price,advance,rem,type,pay,fabric,) async {
    add_loading(true);
    update();
    var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');
    // print(tailor_id);
    // print(tailor_id2);
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.post(api.oders,
      data: {
        'tailor_id': tailor_id,
        'cus_id':cus_id,
        "measure_id":m_id,
        'delivery_date':date,
        'qnty':qnt,
        "price":price,
        "adavnce":advance,
        "remaining":rem,
        "special_instruction":sp_inst.value,
        "delivery_type":type,
        "payment_method":pay,
        "fabric":fabric,
        "instruction_image":sp_image.value,

      },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      // data_search(jsonData['data']);
      // print("data my ${data_my}");/
      add_loading(false);
      update();
      return true;
    }
    return false;
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
    // print("data ${d}");
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
      data_my(jsonData['data']);
      print("data my ${data_my}");
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
    // print("data ${d}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);

      // if(jsonData['message']['error']=="This customer already added in your shop"){
      //   print("inside error");
      //   data_search.value[index]['add_status']="Customer already exist";
      //   update();
      // }
      // else {
      data_my.add(jsonData['data']);

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