import 'dart:convert';
// import 'dart:html';

// import 'package:avunja_business/API/verify_number.dart';
import 'package:dio/dio.dart' as r;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart' as http;
// import 'package:mime_type/mime_type.dart';
import 'api_main.dart';
// import 'package:tailorapp/api/main.dart';
// import 'package:http/http.dart' as http;
// import 'package:avunja_business/API/languages.dart';
// var n=NewUser();
var api=ApisSetup();
class MeasurementsController extends GetxController {
  var drawings="".obs;
  var green=0.obs;
  var red=0.obs;
  var blue=0.obs;
  var thickness=0.0.obs;
  var p_type="".obs;
  var p_id="1".obs;
  var p_name="".obs;
  var desc="".obs;
  var data_my=[].obs;
  var data_single=[].obs;
  var loading=true.obs;
  var loading_single=true.obs;
  var loading_search=true.obs;
  var login=GetStorage('login');
  var data_search=[].obs;
  var current_country=0.obs;
  var current_customer_single=0.obs;
  var add_loading=true.obs;
  var up_loading=true.obs;
  var add_status="".obs;
  var current_draw = 0.obs;
  var customer_order=0.obs;
  // var sele
  // var current_customer=0.obs;
  var code="".obs;
  set_customer_oder(id){
    customer_order(id);
    update();
  }
  set_product_name(name,desc_){
    p_name(name);
    desc(desc_);
    update();
  }
  set_product_id(p_id_){
    p_id(p_id_);
    update();
  }
set_product_type(p_type_){
  p_type(p_type_);
  update();
}
set_current_draw(index){
  current_draw(index);
  update();
}
  set_data(draw,red_,green_,blue_,thick_){
    print(red_);
    // ,green_,blue_,thick_);
    print(green_);
    print(blue_);
    print(thick_);
    drawings(draw);
    red(red_);
    green(green_);
    blue(blue_);
    thickness(thick_);
  }
  set_customer(index){
    current_customer_single(index);
    // print(data_my.value[current_customer.value]);
    update();
  }
  set_country(index){
    current_country(index);
    update();
  }
  Future<bool> dellete_measurement(index) async {
    up_loading(true);
    update();
    // var tailor_id=await login.read('bus_id');
    // var tailor_id2=await login.read('tailor_id');
    // print(tailor_id);
    // print(tailor_id2);
    // Future<Response> callAPI(param) async {

    r.Response d = await api.dio.delete(api.add_measure_my,
      data: {
        'id': data_single.value[index]['measure_id'],
      },

      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    print("data ${d}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      data_single.removeAt(index);
      // data_search(jsonData['data']);
      // print("data my ${data_my}");
      up_loading(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> update_measurement(image) async {
    up_loading(true);
    update();
    // var tailor_id=await login.read('bus_id');
    // var tailor_id2=await login.read('tailor_id');
    // print(tailor_id);
    // print(tailor_id2);
    // Future<Response> callAPI(param) async {

    r.Response d = await api.dio.put(api.add_measure_my,
      data: {
        'id': data_single.value[current_draw.value]['measure_id'],
        'draw':drawings.value,
        "image":image
      },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    print("data ${d}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      // data_search(jsonData['data']);
      // print("data my ${data_my}");
      up_loading(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> get_measurement_my() async {
    loading(false);
    update();
    var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');
    print(tailor_id);
    print(tailor_id2);
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.get(api.add_measure_my+"/${tailor_id}",
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
  Future<bool> get_measurement_single({id=null}) async {
    loading_single(false);
    update();
    var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');
    print(tailor_id);
    print(tailor_id2);
    // Future<Response> callAPI(param) async {
    r.Response d;
    if(id==null) {
      d = await api.dio.get(api.add_measure_my + "/${tailor_id}" +
          "/${data_my.value[current_customer_single.value]['id']}",
        // data: {
        //   'username': email.value,
        //   'password': password.value,
        //   'grant_type': "password"
        // },
        // options: r.Options(headers: <String, String>{'authorization': api.auth},
        //     contentType: r.Headers.formUrlEncodedContentType)
      );
    }
    else{
     d = await api.dio.get(api.add_measure_my + "/${tailor_id}" +
          "/${customer_order.value}",
        // data: {
        //   'username': email.value,
        //   'password': password.value,
        //   'grant_type': "password"
        // },
        // options: r.Options(headers: <String, String>{'authorization': api.auth},
        //     contentType: r.Headers.formUrlEncodedContentType)
      );
    }
    print("data ${d}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      data_single(jsonData['data']);
      print("datamy ${jsonData['data']}");
      loading_single(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> add_measurements_my(image,use_from_orders) async {
    // add_loading(true);
    // data_search.value[index]['add_load']=true;
    update();
    var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');
    // print(tailor_id);
    // print(tailor_id2);
    // var cus_id = data_search.value[index]['id'];

    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.post(api.add_measure_my,
      data: {
        'tailor_id':tailor_id,
        'cus_id': use_from_orders? customer_order.value:data_my.value[current_customer_single.value]['id'],
        'p_id':p_id.value,
        "desc":desc.value,
        "p_name":p_name.value,
        "draw":drawings.value,
        "p_type":p_type.value,
        "thick":thickness.value,
        "red":red.value,
        "green":green.value,
        "image":image,
        "blue":blue.value

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
      // data_my.add(jsonData['data']);

      // data_search.value[index]['add_status']="Added Successfully";
      // }
      // data_search.value[index]['add_load']=false;

      // print("data my ${data_my}");
      // add_loading(false);
      update();
      return true;
    }

    return false;
  }
}