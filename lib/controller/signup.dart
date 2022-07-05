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
class SignupController extends GetxController {
  var fullname="".obs;
  var email="".obs;
  var number="".obs;
  var whatsapp="".obs;
  var pwd="".obs;
  var country =0.obs;
  var data=[].obs;
  var status="".obs;
  var bus_status="".obs;
  var tailor_id=7.obs;
  var response_busin={}.obs;
  var phone="".obs;
  var lat="".obs;
  var long="".obs;
  var google_address="".obs;
  var business_lat="".obs;
  var business_long="".obs;
  var business_google_address="".obs;
  // var current_country=0.obs;
  set_country(cont){
    country(cont);
    update();
  }
  set_location(lat_,long_,go){
    lat(lat_);
    long(long_);
    google_address(go);
    update();
  }
  set_location_bus(lat_,long_,go){
    business_lat(lat_);
    business_long(long_);
    business_google_address(go);
    update();
  }
  set_signup(full_name_,email_,number_,whatsapp_,pwd_,){
    fullname(full_name_);
    email(email_);
    number(number_);
    whatsapp(whatsapp_);
    pwd(pwd_);

    // current_country(index);
    update();
  }
  Future<bool> signup(device_id,manufacturer,model,os,androidId,name) async {
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.post(api.tailor_signup,
      data: {
        'device_id':device_id,
        'manufacturer':manufacturer,
        'name':name,
        'model':model,
        'os':os,
        'androidId':androidId,
        'full_name': fullname.value,
        'email': email.value,
        'phone': number.value,
        'whatsapp': whatsapp.value,
        'password':pwd.value,
        'country':country.value,
        'latitude':lat.value,
        'longitude':long.value,
        'googleaddress':google_address.value
      },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    print("Response from server ${d.data}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      print("json data ${jsonData}");
      if(jsonData['message']['success']=="Account Created Successfully"){
        tailor_id(jsonData['data']['account_id']);
        update();
        return true;
      }
      else{
        status(jsonData['message']['error']);
        return false;

      }
      // data(jsonData['data']);
      update();
      return true;
    }
    print("sign up response ${d.data}");
    status("Something went wrong");
    return false;
    return false;
  }

  Future<bool> shopdetail(shop_name,address,category,service,interested) async {
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.post(api.tailor_business,
      data: {
      'tailor_user':tailor_id.value,
        'shop_name':shop_name,
        'address':address,
        'category_':category,
        'service_':service,
        'interested_':interested,
        'googleaddress':business_google_address.value,
        'latitude':business_lat.value,
        'longitude':business_long.value
      },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      print("json data ${jsonData}");
      if(jsonData['message']['success']=="Business Created"){

        response_busin(jsonData['data']);
        update();
        return true;
      }
      else{
        bus_status(jsonData['message']['error']);
        return false;

      }
      // data(jsonData['data']);
      update();
      return true;
    }
    print("sign up response ${d.data}");
    status("Something went wrong");
    return false;
    return false;
  }
}