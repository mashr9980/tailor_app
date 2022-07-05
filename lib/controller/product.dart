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
class ProductController extends GetxController {
  var data=[].obs;
  var login=GetStorage('login');
  var loading=true.obs;
  var name="".obs;
  var price="".obs;
  var unit="".obs;
  var current_country=0.obs;
  set_product(name_,price_){
    name(name_);
    price(price_);
    update();
  }
  Future<bool> get_products() async {
    loading(true);
    update();
    var tailor_id=await login.read('tailor_id');
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.get(api.stitching_prroduct+"/${tailor_id}",

      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    print("json data ${d.data}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);

      data(jsonData['data']['data']);
      unit(jsonData['data']['unit']);
      loading(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> delete_products(id,index) async {
    loading(true);
    update();
    var tailor_id=await login.read('tailor_id');
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.delete(api.stitching_prroduct+"/${tailor_id}",
        data: {
          "id":id
          // "tailor_id":tailor_id
        }
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      print("jason ${jsonData}");
      data.value.removeAt(index);
      // data(jsonData['data']);
      loading(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> update_products(id,index) async {
    loading(true);
    update();
    var tailor_id=await login.read('tailor_id');
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.put(api.stitching_prroduct+"/${tailor_id}",
        data: {
          "name":name.value,
          "price":price.value,
          "id":id
          // "tailor_id":tailor_id
        }
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      // print("jason ${jsonData}");
      if(jsonData['message']['error']=="") {
        data.value[index]=jsonData['data'];
        loading(false);
        update();
        return true;
      }
      else{
        loading(false);
        update();
        return false;
      }





    }
    return false;
  }
  Future<bool> create_products() async {
    loading(true);
    update();
    var tailor_id=await login.read('tailor_id');
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.post(api.stitching_prroduct+"/${tailor_id}",
      data: {
        "name":name.value,
        "price":price.value,
        // "tailor_id":tailor_id
      }
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    print("Response ${d.data}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      print("indside json");
      final jsonData = json.decode(d.data);

      if(jsonData['message']['error']=="") {
        data.add(jsonData['data']);
        loading(false);
        update();
        return true;
      }
      else{
        loading(false);
        update();
        return false;
      }
      // data(jsonData['data']);

    }
    return false;
  }
}