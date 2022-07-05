import 'dart:convert';
// import 'dart:html';

// import 'package:avunja_business/API/verify_number.dart';
import 'package:dio/dio.dart' as r;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'api_main.dart';
var api=ApisSetup();
class ForgetPwdController extends GetxController {
  var fullname="".obs;
  var email="".obs;
  var phone="".obs;
  var number="".obs;
  var whatsapp="".obs;
  var pwd="".obs;
  var country =0.obs;
  var data=[].obs;
  var status="".obs;
  var bus_status="".obs;
  var tailor_id=7.obs;
  var response_busin={}.obs;
  var lat="".obs;
  var long="".obs;
  var google_address="".obs;
  var business_lat="".obs;
  var business_long="".obs;
  var business_google_address="".obs;
  var response={}.obs;
  var status_code="".obs;
  // var e
  var login =GetStorage('login');
  // var current_country=0.obs;
  void set_login_email(email_,password_){
    email(email_);
    pwd(password_);
    update();
  }
  void set_login_phone(phone_,password){
    phone(phone_);
    pwd(password);
  }
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
  Future<bool> forget_pwd(device_id,manufacturer,model,os,androidId,name,email_) async {
    // Future<Response> callAPI(param) async {
    // print(phone.value);
    // print("code of signin ${code}");
    email(email_);
    r.Response d = await api.dio.post(api.forget_pwd,
      data: {
        'device_id':device_id,
        'manufacturer':manufacturer,
        'name':name,
        'model':model,
        'os':os,
        'androidId':androidId,
        'email': email_,
        // 'code':code,
        // 'password':pwd.value,
      },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      print("json data ${jsonData}");
      if(jsonData['message']['success']=="Otp done"){
        // tailor_id(jsonData['data']['account_id']);
        // await login.write('tailor_id', jsonData['data']['tailor_id']);
        // await login.write('bus_id', jsonData['data']['app_id']);
        update();
        return true;
      }
      else{
        status(jsonData['message']['error']);

        // response(jsonData['data']);
        update();
        return false;

      }
      // data(jsonData['data']);
      update();
      return true;
    }
    // print("sign up response ${d.data}");
    status("Something went wrong");
    return false;
    return false;
  }
  Future<bool> check_otp(otp) async {
    // Future<Response> callAPI(param) async {
    // print(phone.value);
    // print("code of signin ${code}");
    r.Response d = await api.dio.get(api.forget_pwd+"?code=$otp",
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      print("json data ${jsonData}");
      if(jsonData['message']['success']=="Matched"){
        // tailor_id(jsonData['data']['account_id']);
        // await login.write('tailor_id', jsonData['data']['tailor_id']);
        // await login.write('bus_id', jsonData['data']['app_id']);
        update();
        return true;
      }
      else{
        status_code(jsonData['message']['error']);
        // response(jsonData['data']);
        update();
        return false;

      }
    }
    // print("sign up response ${d.data}");
    status("Something went wrong");
    return false;
    return false;
  }
  Future<bool> change_pwd(pwd) async {
    // Future<Response> callAPI(param) async {
    // print(phone.value);
    // print("code of signin ${code}");
    r.Response d = await api.dio.put(api.forget_pwd,
      data: {
      'password':pwd,'email':email.value
      }

      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      print("json data ${jsonData}");
      if(jsonData['message']['success']=="Done"){
        // tailor_id(jsonData['data']['account_id']);
        // await login.write('tailor_id', jsonData['data']['tailor_id']);
        // await login.write('bus_id', jsonData['data']['app_id']);
        update();
        return true;
      }
      else{

        status_code(jsonData['message']['error']);

        // response(jsonData['data']);
        update();
        return false;

      }
      // data(jsonData['data']);
      update();
      return true;
    }
    // print("sign up response ${d.data}");
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
        'category':category,
        'service':service,
        'interested':interested,
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