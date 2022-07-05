import 'dart:io';
import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:tailorapp/Screens/login_screens/shop_detail.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/country.dart';
import 'package:tailorapp/controller/signup.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
class CreatAccount extends StatefulWidget {
  const CreatAccount({Key? key}) : super(key: key);

  @override
  _CreatAccountState createState() => _CreatAccountState();
}

class _CreatAccountState extends State<CreatAccount> {
  var obj = Get.put(CountryController());
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var signup=Get.put(SignupController());
  TextEditingController name = TextEditingController();
  final FocusNode fname = FocusNode();
  TextEditingController lname = TextEditingController();
  final FocusNode flname = FocusNode();
  TextEditingController number = TextEditingController();
  final FocusNode fnumber = FocusNode();
  TextEditingController whatsapp = TextEditingController();
  final FocusNode fwhatsapp = FocusNode();
  TextEditingController email = TextEditingController();
  final FocusNode femail = FocusNode();
  TextEditingController password = TextEditingController();
  final FocusNode fpassword = FocusNode();
  TextEditingController retypepass = TextEditingController();
  final FocusNode fretypepass = FocusNode();
  bool _isVisible = false;
  var lan=GetStorage();
  var code="";
  var name_valid = "";
  var last_name_valid = "";
  var email_valid = "";
  var phone_valid = "";
  var whatsapp_valid = "";
  var password_valid = "";
  var repassword_valid = "";
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  List dropdowncounterycode = [];
  var location="";
  var longitude='';
  var latitude="";
  get_location()async{

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    longitude=position.longitude.toString();
    latitude=position.latitude.toString();
    final coordinates = Coordinates(
        position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first =addresses.first;
    signup.set_location(latitude,longitude,first.addressLine);
  }
  @override
  void initState() {
    for (var i = 0; i < obj.data.length; i++) {
      dropdowncounterycode.add({
        'label': '${obj.data.value[i]['phone_code']}',
        'value': i,
        'icon': SizedBox(
          height: 25,
          width: 25,
          child: Image.network(obj.data.value[i]['country_flag']),
        ),
        'selectedIcon': SizedBox(
          key: UniqueKey(),
          width: 20,
          height: 20,
          child: SvgPicture.asset("assets/icons/check.svg"),
        ),
      });
    }
    signup.set_country(obj.data[obj.current_country.value]['id']);
    fname.addListener(() {
      // print("focus node");
      if (!fname.hasFocus) {
        if (name.text.isEmpty) {
          name_valid = "required".tr;
          setState(() {});
          return;
        } else {
          name_valid = "null";
          setState(() {});
          return;
        }
      }
    });
    flname.addListener(() {
      // print("focus node");
      if (!flname.hasFocus) {
        if (lname.text.isEmpty) {
          last_name_valid = "required".tr;
          setState(() {});
          return;
        } else {
          last_name_valid = "null";
          setState(() {});
          return;
        }
      }
    });


    femail.addListener(() {
      // print("focus node");
      if (!femail.hasFocus) {
        if (email.text.isEmpty) {
          email_valid ="required".tr;
          setState(() {});
          return;
        } else {
          if(email.text.isNotEmpty){
            if (email.text.length > 5 && email.text.contains('@') && email.text.endsWith('.com')) {
              email_valid = "null";
              return;
            }
            email_valid ="required".tr;
            return;
          }
          email_valid = "null";
          setState(() {});
          return;
        }
      }
    });


    fnumber.addListener(() {
      // print("focus node");
      if (!fnumber.hasFocus) {
        if (number.text.trim().isEmpty) {
          phone_valid = "required".tr;
          setState(() {});
          return;
        }

        else if(obj.data.value[obj.current_country.value]['phone_exm'].length >number.text.length ){
          phone_valid = "${'required'.tr} ${obj.data.value[obj.current_country.value]['phone_exm'].length} ${"digit".tr} #";
          setState(() {});
          return;
        }else if(obj.data.value[obj.current_country.value]['phone_exm'].length <number.text.length ){
          phone_valid = "${'required'.tr} ${obj.data.value[obj.current_country.value]['phone_exm'].length} ${"digit".tr} #";
          setState(() {});
          return;
        }else {
          phone_valid = "null";
          setState(() {});
          return;
        }
      }
    });
    fwhatsapp.addListener(() {
      // print("focus node");
      if (!fwhatsapp.hasFocus) {
        if (whatsapp.text.trim().isEmpty) {
          whatsapp_valid = "required".tr;
          setState(() {});
          return;
        }  else if(obj.data.value[obj.current_country.value]['phone_exm'].length >whatsapp.text.length ){
          whatsapp_valid = "${'required'.tr} ${obj.data.value[obj.current_country.value]['phone_exm'].length} ${"digit".tr} #";
          setState(() {});
          return;
        }else if(obj.data.value[obj.current_country.value]['phone_exm'].length <whatsapp.text.length ){
          whatsapp_valid = "${'required'.tr} ${obj.data.value[obj.current_country.value]['phone_exm'].length} ${"digit".tr} # ";
          setState(() {});
          return;
        }else {
          whatsapp_valid = "null";
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
    fretypepass.addListener(() {
      // print("focus node");
      if (!fretypepass.hasFocus) {
        if (retypepass.text.isEmpty) {
          repassword_valid="required".tr;
          setState(() {});
          return;
        }
        if (retypepass.text!=password.text) {
          repassword_valid="Password Didn't Match".tr;
          setState(() {});
          return;
        }
        else {
          repassword_valid= "null";
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
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            toolbarHeight: 40,
            automaticallyImplyLeading: false,
            backgroundColor: APPBARCOLOR,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 5,top: 5),
                    child: Image.asset(
                      logo_png,
                      height: 30,
                    ),),
                  const SizedBox(width: 50,),
                  Text("create_an_account".tr,textDirection: text_direction,style: appbartext,)
                ]
            ),
            leading: InkWell(
              onTap: () {
                Get.to(const SiginPage());
              },
              child:const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Directionality(
            textDirection:text_direction,
            child: Container(
              margin:
                  EdgeInsets.only(left: widthSize * 0.18, right: widthSize * 0.18),
              child: Column(
                children: [
                  SizedBox(
                    height: heightSize * 0.10,
                  ),
                  //Name field whatsapp
                  Directionality(
                    textDirection:text_direction,
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widthSize * 0.75,
                          height: heightSize*0.080,
                          child: TextFormField(
                            textDirection: text_direction,
                            controller: name,
                            focusNode: fname,
                            style: fieldtext,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15),
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.black,
                              hintText: "Enter_Full_Name".tr,
                              //make hint text
                              hintStyle: formhinttext,
                              //create lable
                              labelText: 'Enter_Full_Name'.tr,
                              //lable style
                              labelStyle: formlabelStyle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        name_valid == "" || name_valid == "null"
                            ?const SizedBox()
                            : Text(
                          name_valid,
                          style: TextStyle(
                            fontSize:14,
                            color: name_valid == ""
                                ? const Color(0xffC1C1C1)
                                : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize*0.015,),
                  //mobule and email field
                  Directionality(
                    textDirection:text_direction,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // contery code
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
                                    color: Colors.grey,
                                    width: 1
                                ),
                              ),
                              child: Center(
                                child: CoolDropdown(
                                  dropdownWidth: widthSize * 0.14,
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
                                  resultWidth: widthSize * 0.15,
                                  dropdownItemReverse:true,
                                  dropdownList: dropdowncounterycode,
                                  defaultValue: dropdowncounterycode[obj.current_country.value],
                                  isResultLabel: true,
                                  gap: 4,
                                  placeholder: "+92",
                                  // dropdownItemPadding: EdgeInsets.only(left: 20,right: 20),
                                  // selectedItemPadding: EdgeInsets.only(left: 20,right: 20),
                                  placeholderTS:const TextStyle(
                                      fontSize:  14,
                                      color:  Color(0xff8a8a8a),
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
                                  resultTS:const TextStyle(
                                      fontSize:  12,
                                      color:  Color(0xff8a8a8a),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins"),
                                  unselectedItemTS:const TextStyle(
                                      fontSize:  15,
                                      color: Color(0xff212121),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins"),
                                  onChange: (a) {
                                    obj.set_country(a['value']);
                                    signup.set_country(obj.data[a['value']]['id']);
                                    setState(() {
                                      code=a["label"];
                                    });
                                    // print("length of number ${number.text.length}");
                                    if (number.text.trim().isEmpty) {
                                      phone_valid ="";
                                      setState(() {});
                                      return;
                                    }
                                    else if(obj.data.value[obj.current_country.value]['phone_exm'].length >number.text.length ){
                                      phone_valid = "${'required'.tr} ${obj.data.value[obj.current_country.value]['phone_exm'].length} ${"digit".tr} #";
                                      setState(() {});
                                      // return;
                                    }else if(obj.data.value[obj.current_country.value]['phone_exm'].length <number.text.length ){
                                      phone_valid = "${'required'.tr} ${obj.data.value[obj.current_country.value]['phone_exm'].length} ${"digit".tr} #";
                                      setState(() {});
                                      // return;
                                    }else {
                                      phone_valid = "null";
                                      setState(() {});
                                      // return;
                                    }
                                    if (whatsapp.text.trim().isEmpty) {
                                      whatsapp_valid = "";
                                      setState(() {});
                                      return;
                                    }
                                    else if(obj.data.value[obj.current_country.value]['phone_exm'].length >whatsapp.text.length ){
                                      whatsapp_valid = "${'required'.tr} ${obj.data.value[obj.current_country.value]['phone_exm'].length} ${"digit".tr} #";
                                      setState(() {});
                                      // return;(${whatsapp.text.length}/${obj.data.value[obj.current_country.value]['phone_exm'].length})
                                    }else if(obj.data.value[obj.current_country.value]['phone_exm'].length <whatsapp.text.length ){
                                      whatsapp_valid = "${'required'.tr} ${obj.data.value[obj.current_country.value]['phone_exm'].length} ${"digit".tr} # ";
                                      setState(() {});
                                      // return;
                                    }else {
                                      whatsapp_valid = "null";
                                      setState(() {});
                                      // return;
                                    }
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
                            Text("",maxLines: 2,
                              style: TextStyle(
                                fontSize:14,
                                color: phone_valid == ""
                                    ? const Color(0xffC1C1C1)
                                    : Colors.red,
                                fontWeight: FontWeight.w500,

                              ),)
                            // Container(
                            //   child: Text(
                            //     whatsapp_valid == ""
                            //         ? " "
                            //         : whatsapp_valid,
                            //     style: TextStyle(
                            //       fontSize:14,
                            //       color: whatsapp_valid == ""
                            //           ? Color(0xffC1C1C1)
                            //           : Colors.red,
                            //       fontWeight: FontWeight.w500,
                            //
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        // mobile number
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: widthSize * 0.23,
                              height: heightSize*0.080,
                              child: TextFormField(
                                // maxLength: obj.data.value[obj.current_country.value]['phone_exm'].length,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(obj.data.value[obj.current_country.value]['phone_exm'].length),
                                ],
                                textDirection: text_direction,
                                controller: number,
                                focusNode: fnumber,
                                style: fieldtext,
                                decoration:
                                InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(color: Colors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.black,
                                  hintText: "${obj.data.value[obj.current_country.value]['phone_exm']}",
                                  //make hint text
                                  hintStyle: formhinttext,
                                  //create lable
                                  labelText:'Your_Mobile_Number'.tr,
                                  //lable style
                                  labelStyle: formlabelStyle,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text( phone_valid == "" ||  phone_valid == "null"?"":phone_valid,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize:14,
                                color: phone_valid == ""
                                    ? const Color(0xffC1C1C1)
                                    : Colors.red,
                                fontWeight: FontWeight.w500,

                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: widthSize * 0.23,
                                height: heightSize*0.080,
                              child:
                              // lan.read("status")=="Arabic"?
                              TextFormField(
                                keyboardType:  TextInputType.number,
                                textDirection:text_direction,
                                controller: whatsapp,
                                focusNode: fwhatsapp,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(obj.data.value[obj.current_country.value]['phone_exm'].length),
                                ],
                                style: fieldtext,
                                decoration:InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fillColor: Colors.black,
                                hintText: "${obj.data.value[obj.current_country.value]['phone_exm']}",
                                //make hint text
                                hintStyle: formhinttext,
                                //create lable
                                labelText: 'Whatsapp_#'.tr,
                                //lable style
                                labelStyle: formlabelStyle,
                              ),
                              )
                            ),
                            const SizedBox(height: 5,),
                           Text(whatsapp_valid== ""|| whatsapp_valid== "null"?"":whatsapp_valid ,
                              style: TextStyle(
                                // maxLines: 2,
                                fontSize:14,
                                color: whatsapp_valid  == ""
                                    ? const Color(0xffC1C1C1)
                                    : Colors.red,
                                fontWeight: FontWeight.w500,

                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: heightSize*0.015,),
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
                              contentPadding: const EdgeInsets.all(15),
                              focusColor: Colors.white,
                              //add prefix icon
                              suffix: Container(
                                height: 20,
                                width: 20,
                                margin:const EdgeInsets.only(left: 10,top: 20,right: 10),
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
                      email_valid == ""||email_valid == "null"
                          ? const SizedBox()
                          :Text(
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
                  SizedBox(height: heightSize*0.015,),
                  //password and retypepassword field
                  Directionality(
                    textDirection:text_direction,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //password
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: widthSize * 0.300,
                              height: heightSize*0.080,
                              child: TextFormField(
                                textDirection: text_direction,
                                controller: password,
                                focusNode: fpassword,
                                style: fieldtext,
                                obscureText: _isVisible ? false : true,
                                decoration:
                                InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  focusColor: Colors.white,
                                  //add prefix icon
                                  suffixIcon: IconButton(
                                    onPressed: () => updateStatus(),
                                    icon: Icon(_isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  focusedBorder:
                                  OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(color: Colors.black, width: 1.0),
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
                            password_valid == "" || password_valid == "null"
                                ? const SizedBox()
                                : Text(
                              password_valid ,
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

                        //retypepass
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: widthSize * 0.300,
                              height: heightSize*0.080,
                              child: TextFormField(
                                textDirection: text_direction,
                                controller: retypepass,
                                focusNode: fretypepass,
                                style: fieldtext,
                                obscureText: _isVisible ? false : true,
                                decoration:
                                InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  focusColor: Colors.white,
                                  //add prefix icon
                                  suffixIcon: IconButton(
                                    onPressed: () => updateStatus(),
                                    icon: Icon(_isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(color: Colors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.black,
                                  hintText: "retype_password".tr,
                                  //make hint text
                                  hintStyle: formhinttext,
                                  //create lable
                                  labelText: 'retype_password'.tr,
                                  //lable style
                                  labelStyle: formlabelStyle,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5,),
                            repassword_valid == "" || repassword_valid == "null"
                                ? const SizedBox()
                                : Text(
                              repassword_valid ,
                              style: TextStyle(
                                fontSize:14,
                                color: repassword_valid == ""
                                    ? const Color(0xffC1C1C1)
                                    : Colors.red,
                                fontWeight: FontWeight.w500,

                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: heightSize*0.015,),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      width: widthSize * 0.6,
                      child: Text('By_Pressing_Sign_Up'.tr,textDirection: text_direction,style: const TextStyle(fontSize: 18),),
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
                  ),
                  SizedBox(
                    height: heightSize * 0.05,
                  ),
                  //Sign Up button
                  // lan.read("status")=="Arabic"?
                  // Center(
                  //   child: InkWell(
                  //     onTap: (){
                  //       showDialog(context: context, builder: (BuildContext context) {
                  //         return  AlertDialog(
                  //           content:
                  //           Directionality(
                  //             textDirection: text_direction,
                  //             child: Container(
                  //               height:260 ,
                  //               width: 400,
                  //               decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius: BorderRadius.circular(10)
                  //               ),
                  //
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 children: [
                  //                   const SizedBox(height: 20,),
                  //                   Image.asset("assets/images/bell.png",height: 50,),
                  //                   const SizedBox(height: 30,),
                  //                   Text("Thank_You_for_joining_us".tr,style: popup,),
                  //                   const SizedBox(height: 20,),
                  //                   Text(" Please_login_to_your_email_account_and_verify_Your_Email".tr,style: popup,textAlign: TextAlign.center,),
                  //                   const SizedBox(height: 30,),
                  //                   Center(
                  //                     child: InkWell(
                  //                       onTap: (){
                  //                         Get.to(const ShopDetail());
                  //                         // Navigator.pop(context);
                  //                       },
                  //                       child: Container(
                  //                         height: 40,
                  //                         width: 150,
                  //                         decoration: BoxDecoration(
                  //                             color: buttoncolor,
                  //                             borderRadius: BorderRadius.circular(15)
                  //                         ),
                  //                         child: Center(
                  //                           child: Text("ok".tr,style: buttontext,),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       }
                  //       );
                  //     },
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         color: buttoncolor,
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       width: widthSize * 0.435,
                  //       height: heightSize*0.080,
                  //       child: const Center(
                  //         child: Text(
                  //           "تسجيل الدخول",
                  //           style: buttontext,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ):
                  Center(
                    child: InkWell(
                      onTap: () async{
                        if(phone_valid!="null" || name_valid!="null" || email_valid!="null" || whatsapp_valid!="null" || password_valid!="null" || repassword_valid!="null"){
                          showDialog(context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    shape:const  RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(height: 20,),
                                        Container(
                                            width: 200,
                                            // height: 60,
                                            margin: const EdgeInsets.only(left: 10,right: 10),
                                            child: Lottie.asset('assets/animation/exc.json', height: 120)),
                                        const SizedBox(height: 20,),
                                        Center(
                                          child: Text("PleaseFillallthefieldscorrectly".tr,
                                            style: popup,),
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
                                              child: Center(
                                                child: Text(
                                                  "ok".tr, style: buttontext,),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ));
                              }
                          );
                        }
                        else {
                          showDialog(context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    shape:const  RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(height: 10,),
                                        Container(
                                            width: 150,
                                            margin: const EdgeInsets.only(left: 10,right: 10),
                                            child: Lottie.asset('assets/animation/create.json', height: 150)),
                                        // Container(
                                        //     width: 200,
                                        //     height: 100,
                                        //     margin: EdgeInsets.only(left: 10,right: 10),
                                        //     child: Loader(),),
                                         Center(
                                          child: Text("Creating_Account".tr,
                                            style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                        ),
                                        Center(
                                          child: Text("Please_Wait".tr,
                                            style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                        ),
                                        const SizedBox(height: 20,),
                                      ],
                                    ));
                              }
                          );
                          var deviceData;
                          var os = "Android";
                          await get_location();
                          if (Platform.isAndroid) {
                            deviceData = _readAndroidBuildData(
                                await deviceInfoPlugin.androidInfo);
                            // print("device ${deviceData}");
                          }

                          signup.set_signup(
                              name.text, email.text, number.text, whatsapp.text,
                              password.text);
                          var a = await signup.signup(
                              deviceData['id'], deviceData['manufacturer'],
                              deviceData['model'], os, deviceData['androidId'],
                              deviceData['device']);
                          Navigator.pop(context);
                          if (a) {
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(height: 20,),
                                        Container(
                                            width: 150,
                                            // height: 60,
                                            margin: const EdgeInsets.only(left: 10,right: 10),
                                            child: Lottie.asset('assets/animation/email.json', height: 150)),
                                        const SizedBox(height: 10,),
                                        Center(
                                          child: Text("Thank_You_for_joining_us".tr,
                                            style: popup,),
                                        ),
                                        const SizedBox(height: 10,),
                                        Center(
                                          child: Text(
                                            "Please_login_to_your_email_account_and_verify_Your_Email".tr,
                                            style: popup,
                                            textAlign: TextAlign.center,),
                                        ),
                                        const SizedBox(height: 30,),
                                        Center(
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(const ShopDetail());
                                              // Navigator.pop(context);
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
                          else {
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(

                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                                    content: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 10,),
                                        Container(
                                            width: 150,
                                            // height: 60,
                                            margin: const EdgeInsets.only(left: 10,right: 10),
                                            child: Lottie.asset('assets/animation/exc.json', height: 150)),
                                        Center(
                                          child: Text("${"${signup.status.value}".tr}",
                                            style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                        ),
                                        const SizedBox(height: 10,),
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
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: buttoncolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: widthSize * 0.435,
                        height: heightSize*0.080,
                        child: Center(
                          child: Text(
                            "Sign_Up".tr,
                            style: buttontext,
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
