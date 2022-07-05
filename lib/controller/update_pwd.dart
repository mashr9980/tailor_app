import 'dart:convert';
// import 'dart:html';

// import 'package:avunja_business/API/verify_number.dart';
import 'package:dio/dio.dart' as r;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'api_main.dart';
var api=ApisSetup();
var login=GetStorage('login');
class UpdatepwdCon extends GetxController{
  var status_code="".obs;
  var status="".obs;
  Future<bool> change_pwd(oldpwd,newpwd) async {
    var tailor_id2=await login.read('tailor_id');

    print("tailor id${tailor_id2}");
    print("pwd1${oldpwd}");
    print("tailor id${newpwd}");
    r.Response d = await api.dio.post(api.update_pwd+"${tailor_id2}",
        data: {
          'oldpwd':oldpwd,
          'newpwd':newpwd,
        }
    );
    if(d.statusMessage!.toLowerCase()=="ok"){
      final jsonData = json.decode(d.data);
      print("json data ${jsonData}");
      if(jsonData['message']['success']=="Done"){
        update();
        return true;
      }
      else{
        status_code(jsonData['message']['error']);
        update();
        return false;

      }
    }
    // print("sign up response ${d.data}");
    status("Something went wrong");
    return false;
    return false;
  }
}