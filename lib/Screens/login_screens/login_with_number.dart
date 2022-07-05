import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lottie/lottie.dart';
import 'package:tailorapp/Screens/DashBoard_Screens/home_page.dart';
import 'package:tailorapp/Screens/Forgot%20Screens/forgot_screen.dart';
import 'package:tailorapp/Screens/Status_screen/status_screen.dart';
import 'package:tailorapp/Screens/login_screens/creat_account.dart';
import 'package:tailorapp/controller/country.dart';
import 'package:tailorapp/controller/profile.dart';
import 'package:tailorapp/controller/signin.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:get/get.dart';
import 'package:tailorapp/utils/loader.dart';
import 'dart:io';

class NumberPage extends StatefulWidget {

  @override
  NumberPageState createState() => NumberPageState();
}

class NumberPageState extends State<NumberPage> {
  var local = LocalizationService();
  var profile=Get.put(profileController());
  var obj = Get.put(CountryController());
  final LocalStorage storage =  LocalStorage('localstorage_app');
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var signin= Get.put(SigninController());
  var con=GetStorage("logindata");
  TextEditingController password = TextEditingController();
  bool _isVisible = false;
  var checkedValue=false;
  var lan=GetStorage();
  bool curr=false;
  TextEditingController number = TextEditingController();
  final FocusNode fnumber = FocusNode();
  final FocusNode fpassword = FocusNode();
  List dropdowncounterycode = [];

  var code="";
  var phone_valid = "";
  var password_valid = "";
  var current_country=0;
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  update_check() async{
    checkedValue= await storage.getItem("check_number")??false;
    if(checkedValue){
      fields_value();
    }else{
      password.text="";
      number.text="";
      setState(() {

      });
    }
    setState(() {

    });
  }
  fields_value() async {
    final pass =await  storage.getItem('pass_number')??"";
    final num =await storage.getItem('number')??"";
    password.text="$pass";
    number.text="$num";

    if(password.text.trim().isNotEmpty){
      password_valid="null";
    }
    if(number.text.trim().isNotEmpty){
      phone_valid="null";
    }

    setState(() {

    });
  }
  @override
  void initState() {
    update_check();
    for (var i = 0; i < obj.data.length; i++) {
      if(con.read("country")==i){
        code=obj.data[i]['phone_code'];
        current_country=i;
        setState(() {

        });
      }
      dropdowncounterycode.add({
        'label': '${obj.data.value[i]['phone_code']}',
        'value':i,
        'icon': SizedBox(
          height: 25,
          width: 25,
          child: Image.network(obj.data.value[i]['country_flag']),
        ),
        'selectedIcon': SizedBox(
          key: UniqueKey(),
          width: 20,
          height: 20,
          //
          child: SvgPicture.asset("assets/icons/check.svg"),
        ),
      });
    }
    signin.set_country(con.read("country"));
    if(code==""){
      code=obj.data[obj.current_country.value]['phone_code'];
    }

    fnumber.addListener(() {
      // print("focus node");
      if (!fnumber.hasFocus) {
        if (number.text.trim().isEmpty) {
          phone_valid = "required".tr;
          setState(() {});
          return;
        }

        else if(obj.data.value[obj.current_country.value]['phone_exm'].length >number.text.length ){
          phone_valid = "${'required'.tr} ${obj.data.value[obj.current_country.value]['phone_exm'].length} Digits #";
          setState(() {});
          return;
        }else if(obj.data.value[obj.current_country.value]['phone_exm'].length <number.text.length ){
          phone_valid = "${'required'.tr} ${obj.data.value[obj.current_country.value]['phone_exm'].length} Digits #";
          setState(() {});
          return;
        }else {
          phone_valid = "null";
          setState(() {});
          return;
        }
      }
    });

    fpassword.addListener(() {
      // print("focus node");
      if (!fpassword.hasFocus) {
        if (password.text.isEmpty) {
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
                SizedBox(
                  width: widthSize * 0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Directionality(
                        textDirection: text_direction,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  width: widthSize * 0.14,
                                  height: heightSize*0.080,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0XFFC1C1C1),
                                        width: 1
                                    ),
                                  ),
                                  child: Center(
                                    child: CoolDropdown(
                                      dropdownWidth: widthSize * 0.09,
                                      resultBD: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(5),
                                      ),

                                      isTriangle: false,
                                      dropdownBD: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      isResultIconLabel: true,
                                      dropdownItemReverse:true,
                                      resultWidth: widthSize * 0.15,
                                      dropdownList: dropdowncounterycode,
                                      defaultValue: dropdowncounterycode[current_country],

                                      isResultLabel: true,
                                      gap: 4,
                                      placeholder: "+92",
                                      placeholderTS: TextStyle(
                                          fontSize:  widthSize*0.014,
                                          color:  const Color(0xff8a8a8a),
                                          fontWeight: FontWeight.bold,

                                          fontFamily: "Poppins"),
                                      selectedItemBD: BoxDecoration(

                                        // color: const Color(0xffE8F5FF),
                                        // border: Border.all(
                                        //   color: Color(0xffc1c1c1),
                                        //   width: 5
                                        // ),
                                        borderRadius: BorderRadius.circular(5),

                                      ),
                                      selectedItemTS: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff0037da),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                      resultTS: TextStyle(
                                          fontSize:  widthSize*0.014,
                                          color:  const Color(0xff8a8a8a),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                      unselectedItemTS: TextStyle(
                                          fontSize:  widthSize*0.014,
                                          color: const Color(0xff212121),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                      onChange: (a) {
                                        obj.set_country(a['value']);
                                        signin.set_country(obj.data[a['value']]['id']);
                                        setState(() {
                                          code=a["label"];
                                        });
                                      },
                                      // dropdownItemReverse: false,
                                      dropdownItemMainAxis: MainAxisAlignment.spaceBetween,
                                      resultMainAxis: MainAxisAlignment.start,
                                      labelIconGap: 10,
                                      resultIcon: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: SvgPicture.asset(
                                          'assets/icons/arrowdown.svg',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                              ],
                            ),
                            // mobile number
                            const SizedBox(width: 2,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: widthSize * 0.4,
                                  height: heightSize*0.080,
                                  child: Directionality(
                                    textDirection:text_direction,
                                    child: TextFormField(
                                      textDirection:text_direction,
                                      // textAlign: TextAlign.right,
                                      controller: number,
                                      focusNode: fnumber,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(obj.data.value[obj.current_country.value]['phone_exm'].length),
                                      ],
                                      style: fieldtext,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(10),
                                        focusColor: Colors.white,
                                        //add prefix icon
                                        suffixIcon: IconButton(
                                          onPressed: null,
                                          icon:
                                          Icon(FontAwesomeIcons.phoneSquare,color: buttoncolor,),
                                        ),
                                        // suffix: Container(
                                        //   alignment: Alignment.centerRight,
                                        //   height: heightSize*0.020,
                                        //   width: 20,
                                        //   margin: const EdgeInsets.all(10),
                                        //   child: FaIcon(
                                        //     FontAwesomeIcons.phoneSquare,
                                        //     color: buttoncolor,
                                        //     size: heightSize*0.040,
                                        //   ),
                                        // ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide:const BorderSide(
                                                color: Color(0XFFC1C1C1),
                                                width: 3
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        fillColor: Colors.black,
                                        hintText: "${obj.data.value[obj.current_country.value]['phone_exm']}",
                                        //make hint text
                                        hintStyle: formhinttext,
                                        //create lable
                                        labelText: 'mobile_number'.tr,
                                        // hintTextDirection: text_direction,
                                        // alignLabelWithHint: true,
                                        //lable style
                                        labelStyle: formlabelStyle,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5,),

                              ],
                            ),
                          ],
                        ),
                      ),
                      phone_valid == "" || phone_valid == "null"
                          ? const SizedBox()
                          : Container(
                             margin: EdgeInsets.only(left: widthSize*0.16,right:widthSize*0.16),
                            child: Text(
                        phone_valid,
                        style: TextStyle(
                            fontSize:14,
                            color: phone_valid == ""
                                ? const Color(0xffC1C1C1)
                                : Colors.red,
                            fontWeight: FontWeight.w500,

                        ),
                      ),
                          )
                    ],
                  )

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
                        child: Directionality(
                          textDirection: text_direction,
                          child: TextFormField(
                            textDirection: text_direction,
                            controller: password,
                            focusNode: fpassword,
                            style: fieldtext,
                            obscureText: _isVisible ? false : true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              focusColor: Colors.white,
                              //add prefix icon
                              suffixIcon: IconButton(
                                onPressed: () => updateStatus(),
                                icon:
                                Icon(_isVisible ? Icons.visibility : Icons.visibility_off,color: buttoncolor,),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.black,
                              hintText: "Enter_your_Password".tr,
                              hintStyle: formhinttext,
                              labelText: 'password'.tr,
                              labelStyle: formlabelStyle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      password_valid == "" || password_valid=="null"?const SizedBox():Text(password_valid ,
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
                SizedBox(height: heightSize*0.015,),
                SizedBox(
                  width: widthSize * 0.55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width:200,
                        child: CheckboxListTile(
                          checkColor: Colors.white,
                          activeColor: Colors.black,
                          contentPadding: const EdgeInsets.all(0),
                          title:Text("remember_me".tr,textDirection: text_direction,style:
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
                        child: Text("forgot_password".tr,textDirection: text_direction,style: const TextStyle(
                          color:buttoncolor,
                          fontWeight: FontWeight.w500,fontSize: 18,
                          fontFamily: "Poppins",),),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15,right:15 ),
                  width: widthSize * 0.55,
                  child: Text('By_Pressing_Sign_IN'.tr,textDirection: text_direction,style: const TextStyle(fontSize: 18),),
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
                SizedBox(
                  height: heightSize * 0.02,
                ),
                //Sign in button

                InkWell(
                  onTap:phone_valid=="null" && password_valid=="null"? () async {
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
                      await storage.setItem('check_number', true);
                      await storage.setItem('number', number.text);
                      await storage.setItem('pass_number', password.text);
                      setState(() {

                      });
                    } else{
                      await  storage.setItem('check_number', false);
                      await storage.deleteItem('number');
                      await storage.deleteItem('pass_number');
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
                    signin.set_login_phone(number.text, password.text);

                    var a = await signin.signin_phone(deviceData['id'],deviceData['manufacturer'],deviceData['model'],os,deviceData['androidId'],deviceData['device'],code);
                    Navigator.pop(context);
                    if(a){
                      await profile.get_my_business();
                      Get.offAll(const HomePage());
                    }
                    else{
                      if(signin.status.value=="Account is not completed"){
                        Get.to(const StatusScreen());
                        number.clear();
                        password.clear();
                      }
                      else{
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                content: Container(
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
                                      Container(
                                          width: 200,
                                          // height: 60,
                                          margin: const EdgeInsets.only(left: 10,right: 10),
                                          child: Lottie.asset('assets/icons/password.json', height: 120)),
                                      const SizedBox(height: 30,),
                                      Text("${signin.status.value}".tr,textAlign: TextAlign.center,
                                        style: popup,),
                                      const SizedBox(height: 20,),
                                      Center(
                                        child: InkWell(
                                          onTap: () {
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
                                                "ok".tr, textDirection: text_direction, style: buttontext,),
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
                      color:phone_valid=="null" && password_valid=="null"? buttoncolor:buttoncolor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: widthSize * 0.5,
                    height: heightSize*0.080,
                    child: Center(
                      child: Text(
                        "Sign_In".tr,textDirection: text_direction,
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
                          "Become_Our_partner".tr,textDirection: text_direction,
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
