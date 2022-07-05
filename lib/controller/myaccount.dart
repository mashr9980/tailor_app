import 'dart:convert';
import 'package:dio/dio.dart' as r;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'api_main.dart';

var api=ApisSetup();
class MyAccountCon extends GetxController {
  var data_profile= {}.obs;
  var loading=true.obs;
  var loading_profile=true.obs;
  var login=GetStorage('login');
  var data_search=[].obs;
  var current_country=0.obs;
  var add_loading=true.obs;
  var add_status="".obs;
  var code="".obs;
  var update_error={}.obs;

  set_country(index){
    current_country(index);
    update();
  }

  Future<bool> get_my_account() async {
    // loading_profile(true);
    // update();
    // var tailor_id=await login.read('bus_id');
    var tailor_id2=await login.read('tailor_id');
    print("tailorid${tailor_id2}");
    r.Response d = await api.dio.get(api.account+"${tailor_id2}",
      // data: {
      //   'phone': number,
      //   'code':code,
      //   'tailor_id':tailor_id
      // },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    // print("data ${d}");
    // print("data my ${d.data}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      print("jason data ${jsonData}");
      data_profile(jsonData['data']);
      print("data my ${data_profile}");
      loading_profile(false);
      update();
      return true;
    }
    return false;
  }
  Future<bool> update_my_account(full_name,email,phone,whatsapp,country,province,city,gender,zip_code,image,dob) async {
    print("city ${city}",);
    print("dob ${dob}");
    var tailor_id2=await login.read('tailor_id');
    // print("tailorid${tailor_id2}");
    r.Response d = await api.dio.post(api.account+"${tailor_id2}",
      data: {
        'full_name':full_name,
        'email':email,
        'phone':phone,
        "whatsapp":whatsapp,
        "country":country,
        "province":province,
        "city":city,
        "zip_code":zip_code,
        "image":image,
        "dob":dob,
        'gender':gender
      },
      // options: r.Options(headers: <String, String>{'authorization': api.auth},
      //     contentType: r.Headers.formUrlEncodedContentType)
    );
    print("data ${d}");
    print("data my ${d.data}");
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      print("jason data ${jsonData}");
      if(jsonData['message']['success']==""){
        update_error(jsonData['data']);

        return false;
      }
      else{
        return true;
      }
    }

    return false;
  }

}