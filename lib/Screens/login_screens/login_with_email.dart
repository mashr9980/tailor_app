import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lottie/lottie.dart';
import 'package:tailorapp/Screens/DashBoard_Screens/home_page.dart';
import 'package:tailorapp/Screens/Forgot%20Screens/forgot_screen.dart';
import 'package:tailorapp/Screens/Status_screen/status_screen.dart';
import 'package:tailorapp/Screens/login_screens/creat_account.dart';
import 'package:tailorapp/controller/profile.dart';
import 'package:tailorapp/controller/signin.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tailorapp/utils/loader.dart';

import 'language.dart';

class EmailPage extends StatefulWidget {
  // const SiginPage({Key? key}) : super(key: key);

  @override
  EmailPageState createState() => EmailPageState();
}

class EmailPageState extends State<EmailPage> {
  var local = LocalizationService();
  // var fields1=GetStorage("efield");
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var profile=Get.put(profileController());
  var signin= Get.put(SigninController());
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  final FocusNode fpassword = FocusNode();
  final FocusNode femail = FocusNode();
  bool _isVisible = false;
  bool checkedValue=false;
  var lan=GetStorage();
  var con=GetStorage("logindata");
  final LocalStorage storage =  LocalStorage('localstorage_app');
  bool curr=false;
  var email_valid = "";
  var password_valid = "";
  var check_valid=false;
  var emailValid = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  update_check() async{

    // print("counterydata ${con.read("country")}");

    checkedValue= storage.getItem("checked1")??false;
    if(checkedValue){
      fields_value();
    }
    else{
      email.text="";
      password1.text="";
      setState(() {

      });
    }

  }
  fields_value() async {

    final pass =await  storage.getItem('pass1')??""; // Abolfazl
    final emailvalue =await storage.getItem('emailt')??"";
    print("passs$pass");
    email.text="$emailvalue";
    password1.text="$pass";
    if(password1.text.trim().isNotEmpty){
      password_valid="null";
    }
    if(email.text.trim().isNotEmpty){
      email_valid="null";
    }
    setState(() {

    });
  }
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  void initState() {
    update_check();
    femail.addListener(() {
      // print("Has focus: ${_focusNode.hasFocus}");
      if(!femail.hasFocus){
        check_valid=true;
        setState(() {

        });
        if(email.text.trim()==""){
          // print("I am in trim");
          email_valid="required".tr;
          check_valid=false;
          setState(() {

          });
          return ;
        }
        else if(!emailValid.hasMatch(email.text)){
          check_valid=false;

          email_valid ="Please_provide_email_Address".tr;
          setState(() {

          });
          return ;
        }

        else{
          check_valid = false;

          email_valid = "null";
          // print("submit ${v}" );
          setState(() {

          });
        }
      }
    });
    // femail.addListener(() {
    //   print("focus node");
    //   if (!femail.hasFocus) {
    //     if (email.text.isEmpty) {
    //       email_valid =lan.read("status")=="Arabic"?"مطلوب هذا الحقل":"Required*";
    //       setState(() {});
    //       return;
    //     } else {
    //       email_valid = "null";
    //       setState(() {});
    //       return;
    //     }
    //   }
    // });
    fpassword.addListener(() {
      print("focus node");
      if (!fpassword.hasFocus) {
        if (password1.text.isEmpty) {
          password_valid = "required".tr;
          setState(() {});
          return;
        } else {
          password_valid = "null";
          setState(() {});
          return;
        }
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgcolor,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Directionality(
            textDirection:text_direction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: heightSize*0.015,),
                //email field
                SizedBox(
                  width: widthSize * 0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: widthSize * 0.55,
                        height: heightSize*0.080,
                        child: Directionality(
                          textDirection:text_direction,
                          child: TextFormField(
                            textDirection:text_direction,
                            controller: email,
                            focusNode: femail,
                            style: fieldtext,
                            decoration:
                            InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              focusColor: Colors.white,
                              suffixIcon: IconButton(
                                onPressed: null,
                                icon:
                                Icon(FontAwesomeIcons.envelope,color: buttoncolor,),
                              ),
                              //add prefix icon
                              // suffix: Container(
                              //   height: 20,
                              //   width: 20,
                              //   margin: const EdgeInsets.only(left: 10,top: 30,right:10,),
                              //   child:const FaIcon(
                              //     FontAwesomeIcons.envelope,
                              //     color: buttoncolor,
                              //     size: 25,
                              //   ),
                              // ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.black,
                              hintText: "Enter_Email_Address".tr,
                              //make hint text
                              hintStyle: formhinttext,
                              //create lable
                              labelText: 'email_address'.tr,
                              //lable style
                              labelStyle: formlabelStyle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      email_valid == "" || email_valid == "null"?const SizedBox():Text(
                        email_valid ,
                        style: TextStyle(
                          fontSize:14,
                          color: email_valid  == ""
                              ? const Color(0xffC1C1C1)
                              : Colors.red,
                          fontWeight: FontWeight.w500,

                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: heightSize*0.015,),
                //password field
                SizedBox(
                  width: widthSize * 0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: widthSize * 0.55,
                        height: heightSize*0.080,
                        child: TextFormField(
                          textDirection: text_direction,
                          controller: password1,
                          focusNode: fpassword,
                          style: fieldtext,
                          obscureText: _isVisible ? false : true,
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            contentPadding: const EdgeInsets.all(10),
                            suffixIcon: IconButton(
                              onPressed: () => updateStatus(),
                              icon:
                              Icon(_isVisible ? Icons.visibility : Icons.visibility_off,color: buttoncolor,),
                            ),
                            //add prefix icon
                            //  suffix:
                            // Container(
                            //   height: 20,
                            //   width: 20,
                            //   alignment: Alignment.center,
                            //   margin: const EdgeInsets.only(right: 10,top: 20,left:20),
                            //   child:Center(
                            //     child: IconButton(
                            //       onPressed: () => updateStatus(),
                            //       icon:
                            //       Icon(_isVisible ? Icons.visibility : Icons.visibility_off,color: buttoncolor,size: 25,),
                            //     ),
                            //   ),
                            // ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.black,
                            hintText: "Enter_your_Password".tr,
                            //make hint text
                            hintStyle: formhinttext,
                            //create lable
                            labelText: 'password'.tr,
                            //lable style
                            labelStyle: formlabelStyle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      password_valid == "" ||  password_valid == "null"?const SizedBox():Text(password_valid ,
                        style: TextStyle(
                          fontSize:14,
                          color: password_valid  == ""
                              ? const Color(0xffC1C1C1)
                              : Colors.red,
                          fontWeight: FontWeight.w500,

                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: widthSize * 0.55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width:300,
                        child: CheckboxListTile(
                          checkColor: Colors.white,
                          activeColor: Colors.black,
                          contentPadding: const EdgeInsets.all(0),
                          title:Text("remember_me".tr,style:
                          const TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.w500,fontSize: 18,
                            fontFamily: "Poppins",),),
                          value: checkedValue,
                          onChanged: (newValue) async {
                            checkedValue = newValue!;
                            setState(() {

                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                        ),
                      ),
                       InkWell(
                        onTap: (){
                          Get.to(ForgetScreen());
                        },
                        child: Text("forgot_password".tr,style: const TextStyle(
                          color:buttoncolor,
                          fontWeight: FontWeight.w500,fontSize: 18,
                          fontFamily: "Poppins",),),
                      )
                    ],
                  ),
                ),
                //english
                Container(
                  padding: const EdgeInsets.only(left: 15,right:10),
                  width: widthSize * 0.55,
                  child: Text('By_Pressing_Sign_IN'.tr, textDirection: text_direction, style: const TextStyle(fontSize: 18),),
                  // child:const InkWell(
                  //   child: Text.rich(
                  //       TextSpan(
                  //           style:TextStyle(
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 18,
                  //             fontFamily: "Poppins",
                  //           ) ,
                  //           text: 'By Pressing Sign IN, I agree to OneService360 terms of Service,  ',
                  //           children: <InlineSpan>[
                  //             TextSpan(
                  //               text: 'payment terms of service & privacy policy.',
                  //               style: TextStyle(
                  //                 color: buttoncolor,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 18,
                  //                 fontFamily: "Poppins",
                  //               ),
                  //             )
                  //           ])),
                  // ),
                ),
                const SizedBox(
                  height: 50,
                ),
                //Sign in button

                InkWell(
                  onTap:email_valid=="null" && password_valid=="null"? () async {
                    showDialog(context: context, builder: (BuildContext context) {
                      return  Scaffold(
                        backgroundColor: Colors.transparent,
                        body: SizedBox(
                            height:heightSize ,
                            width: widthSize,
                            child: const Center(child:Loader())
                        ),
                      );
                    }

                    );
                    if(checkedValue==true){
                      await storage.setItem("checked1",true);
                      await storage.setItem('emailt', email.text);
                      await storage.setItem('pass1', password1.text);
                      setState(() {

                      });
                    } else{
                      await storage.setItem("checked1",false);
                      await storage.deleteItem('emailt');
                      await  storage.deleteItem('pass1');
                      setState(() {

                      });
                    }
                    var deviceData;
                    var os="Android";
                    if (Platform.isAndroid) {
                      deviceData = _readAndroidBuildData(
                          await deviceInfoPlugin.androidInfo);
                      // print("device ${deviceData}");
                    }
                    signin.set_login_email(email.text, password1.text);

                    var a = await signin.signin(deviceData['id'],deviceData['manufacturer'],deviceData['model'],os,deviceData['androidId'],deviceData['device']);
                    Navigator.pop(context);
                    if(a){
                      await profile.get_my_business();
                      Get.offAll(const HomePage());
                    }
                    else{
                      if(signin.status.value=="Account is not completed"){
                        Get.to(const StatusScreen());
                      }else{
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                content: Container(
                                  // height: 260,
                                  // width: 400,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 20,),
                                      // Image.asset("assets/images/bell.png",
                                      //   height: 50,),
                                      Container(
                                          width: 200,
                                          // height: 60,
                                          margin: const EdgeInsets.only(left: 10,right: 10),
                                          child: Lottie.asset('assets/icons/password.json', height: 120)),
                                      const SizedBox(height: 30,),
                                      Text("${signin.status.value}".tr,textAlign: TextAlign.center,
                                        style: popup,),
                                      const SizedBox(height: 20,),
                                      // Text(
                                      //   " Please login to your email account and verify Your Email",
                                      //   style: popup,
                                      //   textAlign: TextAlign.center,),
                                      // SizedBox(height: 30,),
                                      Center(
                                        child: InkWell(
                                          onTap: () {
                                            // Get.to(ShopDetail());
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                color: buttoncolor,
                                                borderRadius: BorderRadius
                                                    .circular(15)
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Ok".tr,textDirection: text_direction, style: buttontext,),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      }

                    }
                  }:null,
                  child: Container(
                    decoration: BoxDecoration(
                      color:email_valid=="null" && password_valid=="null"? buttoncolor:buttoncolor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: widthSize * 0.5,
                    height: heightSize*0.080,
                    child: Center(
                      child: Text(
                        "Sign_In".tr,
                        textDirection: text_direction,
                        style: buttontext,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.015,),
                Center(
                  child: SizedBox(
                    width: widthSize * 0.55,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 250,
                          child: Divider(
                            color: Color(0xffC1C1C1),
                            thickness: 1,

                          ),
                        ),
                        Text("or".tr,textDirection: text_direction ,style: const TextStyle(color: Colors.black,fontSize: 20),),
                        const SizedBox(
                          width: 250,
                          child: Divider(
                            color: Color(0xffC1C1C1),
                            thickness: 1,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.015,),
                //become our partner
                Center(
                  child: InkWell(
                    onTap: (){
                      Get.to(const CreatAccount());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: buttoncolor
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: widthSize * 0.5,
                      height: heightSize*0.080,
                      child: Center(
                        child: Text(
                          "Become_Our_partner".tr,
                          textDirection: text_direction,
                          style: buttontext1,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.2,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }
}
