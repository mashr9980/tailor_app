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
class CountryController extends GetxController {
var data=[].obs;
var current_country=0.obs;

// var current_country=0.obs;
set_country(index){
current_country(index);
update();
}

  Future<bool> get_county() async {
    // Future<Response> callAPI(param) async {
    r.Response d = await api.dio.post(api.country,
        // data: {
        //   'username': email.value,
        //   'password': password.value,
        //   'grant_type': "password"
        // },
        // options: r.Options(headers: <String, String>{'authorization': api.auth},
        //     contentType: r.Headers.formUrlEncodedContentType)
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      data(jsonData['data']);
      update();
      return true;
    }
    return false;
  }
}