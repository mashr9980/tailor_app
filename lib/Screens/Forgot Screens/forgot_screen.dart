import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/style.dart';
import 'package:tailorapp/Screens/Forgot%20Screens/update_password_email.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/forget_pwd.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:tailorapp/utils/loader.dart';
import 'dart:io';
import 'counter.dart';
class ForgetScreen extends StatefulWidget {
  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  var obg=Get.put(ForgetPwdController());
  final check = GetStorage('login');
  var counter ;
  TextEditingController email = TextEditingController();
  final FocusNode femail = FocusNode();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var pin_a="";
  bool hasTimerStopped=false;
  bool send=false;

  var email_valid = "";
  var lan=GetStorage();
  openAlertBox() {

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return Directionality(
            textDirection:text_direction,
            child: StatefulBuilder(
              builder: (context, msetState) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  contentPadding: const EdgeInsets.only(top: 10.0),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            width: 200,
                            // height: 60,
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            child: Lottie.asset('assets/icons/otp.json', height: 150)),
                        Center(
                          child: Container(
                            width: 200,
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Center(
                                child:
                                 Text("Please_Account".tr,style: popup,textAlign: TextAlign.center,)),),
                        ),
                        const SizedBox(height: 15,),
                        Center(
                          child: Container(
                            width: 200,
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Text("Please_OTP".tr,
                              style: popup2,textAlign: TextAlign.center,),),
                        ),
                        // SizedBox(height: 15,),
                        Container(
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: OTPTextField(
                              // outlineBorderRadius: 10,
                              keyboardType: TextInputType.number,
                              outlineBorderRadius: 2,
                              otpFieldStyle: OtpFieldStyle(
                                backgroundColor: Colors.white,
                                // disabledBorderColor: Colors.grey,
                                enabledBorderColor: buttoncolor,
                                borderColor:buttoncolor,
                              ),
                              length: 4,
                              width: MediaQuery.of(context).size.width*0.25,
                              fieldWidth: 40,
                              style:const TextStyle(
                                  fontSize: 14
                              ),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.box,
                              onCompleted: (pin) {
                                pin_a=pin;
                                // print("Completed: " + pin);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               Text("Code_in".tr,
                                style: const TextStyle(color: Color(0XFFC1C1C1),fontSize: 12),),
                              !hasTimerStopped?set_counter(msetState):
                              send? Text("Sending".tr):
                              TextButton(onPressed: () async {
                                send=true;
                                msetState((){});
                                setState(() {

                                });
                                var deviceData;
                                var os="Android";
                                if (Platform.isAndroid) {
                                  deviceData = _readAndroidBuildData(
                                      await deviceInfoPlugin.androidInfo);
                                  print("device ${deviceData}");
                                }
                                var a = await obg.forget_pwd(deviceData['id'],deviceData['manufacturer'],deviceData['model'],os,deviceData['androidId'],deviceData['device'], email.text);
                                Get.back();
                                if(a){
                                  openAlertBox();
                                }
                                else{
                                  pwdupdateBox(a);
                                  // showDialog(context: context,
                                  //     builder: (BuildContext context) {
                                  //       return AlertDialog(
                                  //         content: Container(
                                  //           height: 260,
                                  //           width: 400,
                                  //           decoration: BoxDecoration(
                                  //               color: Colors.white,
                                  //               borderRadius: BorderRadius.circular(10)
                                  //           ),
                                  //
                                  //           child: Column(
                                  //             mainAxisAlignment: MainAxisAlignment.start,
                                  //             crossAxisAlignment: CrossAxisAlignment.center,
                                  //             children: [
                                  //               SizedBox(height: 20,),
                                  //               Image.asset("assets/images/bell.png",
                                  //                 height: 50,),
                                  //               SizedBox(height: 30,),
                                  //               Text("${obg.status.value}",
                                  //                 style: popup,),
                                  //               SizedBox(height: 20,),
                                  //               // Text(
                                  //               //   " Please login to your email account and verify Your Email",
                                  //               //   style: popup,
                                  //               //   textAlign: TextAlign.center,),
                                  //               // SizedBox(height: 30,),
                                  //               Center(
                                  //                 child: InkWell(
                                  //                   onTap: () {
                                  //                     // Get.to(ShopDetail());
                                  //                     Navigator.pop(context);
                                  //                   },
                                  //                   child: Container(
                                  //                     height: 40,
                                  //                     width: 150,
                                  //                     decoration: BoxDecoration(
                                  //                         color: buttoncolor,
                                  //                         borderRadius: BorderRadius
                                  //                             .circular(15)
                                  //                     ),
                                  //                     child: Center(
                                  //                       child: Text(
                                  //                         "Ok", style: buttontext,),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       );
                                  //     }
                                  // );
                                }
                                hasTimerStopped=false;
                                send=false;
                                msetState((){});
                                setState(() {

                                });
                              }, child: Text("Resend".tr)),


                              // Text("3:00",style: TextStyle(color: Color(0XFFC1C1C1),fontSize: 14),
                              //
                              // )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Container(
                          margin: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //back
                              InkWell(
                                onTap:(){
                                  Get.back();
                                },
                                child: Container(
                                  width:  80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: buttoncolor,width: 1)
                                  ),
                                  child: Center(
                                    child:  Text(
                                      "back".tr,
                                      style: const TextStyle(color: buttoncolor,fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(

                                onTap: () async {
                                  loadingbox();
                                  Get.back();
                                  var a = await obg.check_otp(pin_a);
                                  if(a){
                                    Get.to(const EmailUpadatePass());
                                  }
                                  else{
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                            contentPadding: const EdgeInsets.all(20),
                                            content:  Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                Center(
                                                child:
                                                Lottie.asset('assets/animation/exc.json',height: 120,width: 120)),
                                                  const SizedBox(height: 20,),
                                                  // Center(
                                                  //   child: Text(obg.status_code.value,
                                                  //     style: popup,textAlign: TextAlign.center,),
                                                  // ),
                                                  const SizedBox(height: 10,),
                                                  Center(
                                                    child: Container(
                                                      child:  Text("Please_Enter_OTP".tr,
                                                        style: popup,textAlign: TextAlign.center,),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20,),
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
                                                        child:  Center(
                                                          child:  Text(
                                                            "ok".tr, style: buttontext,),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),

                                          );
                                        }
                                    );
                                  }

                                },
                                child: Container(
                                  width:  80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: buttoncolor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child:  Text(
                                      "next".tr,
                                      style: const TextStyle(color: Colors.white,fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),

                      ],
                    ),
                  )
              );
            },
            ),
          );
        });
  }
  loadingbox() {

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return AlertDialog(

              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(height: 20,),
                    Container(
                        width: 200,
                        height: 80,
                        margin: const EdgeInsets.only(left: 10,right: 10),
                        child: Center(child: Lottie.asset('assets/animation/loader.json',))),

                     Center(child: Text("Submitting_your_Request".tr),),
                    const SizedBox(height: 10,),

                  ],
                ),
              )
          );
        });
  }
  pwdupdateBox(status) {

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return AlertDialog(

              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(child: Lottie.asset('assets/animation/nouser.json',height: 120,width: 120)),
                    Center(
                      child: Container(
                        width: 250,
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Center(
                            child: Text("${obg.status.value} at this email Please try Again",style: popup,textAlign: TextAlign.center,)),),
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      margin: const EdgeInsets.only(left: 50,right: 50),
                      child: InkWell(
                        onTap:() async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width:  60,
                          height: 40,
                          decoration: BoxDecoration(
                            color: buttoncolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "ok".tr,
                              style: const TextStyle(color: Colors.white,fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),

                  ],
                ),
              )
          );
        });
  }
  Widget set_counter(state){
    return CountDownTimer(
      secondsRemaining: 300,
      whenTimeExpires: () {
        state(() {
          hasTimerStopped = true;
        });
        setState(() {
          // hasTimerStopped = true;
        });
      },
      countDownTimerStyle: const TextStyle(
        color: Colors.black,
        fontSize: 17.0,
        height: 1.2,
      ),
    );
  }
  void initState() {
    femail.addListener(() {
      print("focus node");
      if (!femail.hasFocus) {
        if (email.text.isEmpty) {
          email_valid ="required".tr;
          setState(() {});
          return;
        } else {
          email_valid = "";
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
    return Directionality(
      textDirection:text_direction,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: bgcolor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45.0),
            child: AppBar(
              title:
              SizedBox(
                width: widthSize*0.3,
                child:Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 5,top: 5),
                        child: Image.asset(
                          logo_png,
                          height: 30,
                        ),),
                      const SizedBox(width: 20,),
                      Text("Reset_Password".tr,style: appbartext,)
                    ]
                ),),
              toolbarHeight: 45,
              automaticallyImplyLeading: false,
              backgroundColor: APPBARCOLOR,

              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: heightSize*0.15,),
                  SizedBox(
                    width: widthSize * 0.75,
                    height: heightSize*0.060,
                    child: Text("Enter_email_password".tr,style: boldtext,),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: widthSize * 0.75,
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

                              focusColor: Colors.white,
                              //add prefix icon
                              suffix: Container(
                                height: 20,
                                width: 20,
                                margin: const EdgeInsets.only(left: 10,top: 20,right: 10),
                                child:const FaIcon(
                                  FontAwesomeIcons.envelope,
                                  color: buttoncolor,
                                  size: 25,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.black,
                              hintText: "Registered_Email_Address".tr,
                              //make hint text
                              hintStyle: formhinttext,
                              //create lable
                              // labelText: 'Email Address',
                              // //lable style
                              // labelStyle: formlabelStyle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      email_valid == "" || email_valid=="null"?const SizedBox():Text(email_valid ,
                        style: TextStyle(
                          fontSize:14,
                          color: email_valid  == "" || email_valid=="null"
                              ? const Color(0xffC1C1C1)
                              : Colors.red,
                          fontWeight: FontWeight.w500,

                        ),
                      )
                    ],
                  ),
                  SizedBox(height: heightSize*0.025,),
                  Center(
                    child: InkWell(
                      onTap:email.text.isEmpty?null: () async {
                        loadingbox();
                        var deviceData;
                        var os="Android";
                        if (Platform.isAndroid) {
                          deviceData = _readAndroidBuildData(
                              await deviceInfoPlugin.androidInfo);
                          // print("device ${deviceData}");
                        }
                        var a = await obg.forget_pwd(deviceData['id'],deviceData['manufacturer'],deviceData['model'],os,deviceData['androidId'],deviceData['device'], email.text);
                        Get.back();
                        if(a){
                          openAlertBox();
                        }
                        else{
                          pwdupdateBox(a);
                          // showDialog(context: context,
                          //     builder: (BuildContext context) {
                          //       return AlertDialog(
                          //         content: Container(
                          //           height: 260,
                          //           width: 400,
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(10)
                          //           ),
                          //
                          //           child: Column(
                          //             mainAxisAlignment: MainAxisAlignment.start,
                          //             crossAxisAlignment: CrossAxisAlignment.center,
                          //             children: [
                          //               SizedBox(height: 20,),
                          //               Image.asset("assets/images/bell.png",
                          //                 height: 50,),
                          //               SizedBox(height: 30,),
                          //               Text("${obg.status.value}",
                          //                 style: popup,),
                          //               SizedBox(height: 20,),
                          //               // Text(
                          //               //   " Please login to your email account and verify Your Email",
                          //               //   style: popup,
                          //               //   textAlign: TextAlign.center,),
                          //               // SizedBox(height: 30,),
                          //               Center(
                          //                 child: InkWell(
                          //                   onTap: () {
                          //                     // Get.to(ShopDetail());
                          //                     Navigator.pop(context);
                          //                   },
                          //                   child: Container(
                          //                     height: 40,
                          //                     width: 150,
                          //                     decoration: BoxDecoration(
                          //                         color: buttoncolor,
                          //                         borderRadius: BorderRadius
                          //                             .circular(15)
                          //                     ),
                          //                     child: Center(
                          //                       child: Text(
                          //                         "Ok", style: buttontext,),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               )
                          //             ],
                          //           ),
                          //         ),
                          //       );
                          //     }
                          // );
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:email.text.isEmpty? buttoncolor.withOpacity(0.3):buttoncolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: widthSize * 0.435,
                        height: heightSize*0.080,
                        child:  Center(
                          child: Text(
                            "Reset_Password".tr,
                            style: buttontext,
                          ),

                        ),
                      ),
                    ),
                  )
                ],
              ),
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
