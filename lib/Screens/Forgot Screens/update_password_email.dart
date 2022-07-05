import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/forget_pwd.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/loader.dart';

import '../../localization/localization_service.dart';
import 'forgot_screen.dart';
class EmailUpadatePass extends StatefulWidget {
  const EmailUpadatePass({Key? key}) : super(key: key);

  @override
  _EmailUpadatePassState createState() => _EmailUpadatePassState();
}

class _EmailUpadatePassState extends State<EmailUpadatePass> {
  var obg=Get.put(ForgetPwdController());
  TextEditingController password = TextEditingController();
  final FocusNode fpassword = FocusNode();
  TextEditingController retypepass = TextEditingController();
  final FocusNode fretypepass = FocusNode();
  bool _isVisible = false;
  var lan=GetStorage();
  final check = GetStorage('login');
  var password_valid ="";
  var repassword_valid ="";
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  void initState() {

    fpassword.addListener(() {
      print("focus node");
      if (!fpassword.hasFocus) {
        if (password.text.isEmpty) {
          password_valid = "required";
          setState(() {});
          return;
        } else {
          password_valid = "";
          setState(() {});
          return;
        }
      }
    });
    fretypepass.addListener(() {
      print("focus node");
      if (!fretypepass.hasFocus) {
        if (retypepass.text.isEmpty) {
          repassword_valid="required";
          setState(() {});
          return;
        }
        if (retypepass.text!=password.text) {
          repassword_valid="Password_Did_not_Match".tr;
          setState(() {});
          return;
        }
        else {
          repassword_valid= "";
          setState(() {});
          return;
        }
      }
    });
    super.initState();
  }
  openAlertBox() {

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
                    Container(
                        width: 200,
                        // height: 60,
                        margin: const EdgeInsets.only(left: 10,right: 10),
                        child: Lottie.asset('assets/icons/confirm.json', height: 120)),
                    // Container(
                    //   height: 60,
                    //     child: Image.asset("assets/icons/lock.png",)),
                    const SizedBox(height: 15,),
                    Center(
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Center(
                            child: Text("Password_Updated".tr,style: popup,textAlign: TextAlign.center,)),),
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      margin: const EdgeInsets.only(left: 50,right: 50),
                      child: InkWell(

                        onTap:(){
                          Get.to(const SiginPage());
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
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection:text_direction,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus( FocusNode());
        },
        child: Scaffold(
          backgroundColor: bgcolor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45.0),
            child: AppBar(
              title:
              SizedBox(
                width: widthSize*0.500,
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 5,top: 5),
                        child: Image.asset(
                          logo_png,
                          height: 30,
                        ),),
                      Text("Reset_Password".tr,style: appbartext,)
                    ]
                ),),
              toolbarHeight: 45,
              automaticallyImplyLeading: false,
              backgroundColor: APPBARCOLOR,
              leading: InkWell(
                onTap: () {
                  Get.to(ForgetScreen());
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
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
                  //new password
                  SizedBox(
                    width: widthSize * 0.75,
                    height: heightSize*0.060,
                    child: Text("New_Password".tr,style: boldtext,),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: widthSize * 0.75,
                        height: heightSize*0.080,
                        child: Center(
                          child: TextFormField(
                            textDirection: text_direction,
                            controller: password,
                            focusNode: fpassword,
                            style: fieldtext,
                            obscureText: _isVisible ? false : true,
                            decoration:
                            InputDecoration(
                              focusColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
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
                              hintText: "Enter_New_Password".tr,
                              //make hint text
                              hintStyle: formhinttext,
                              // //create lable
                              // labelText: 'New Password',
                              // //lable style
                              // labelStyle: formlabelStyle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        password_valid == ""
                            ? " "
                            : password_valid ,
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
                  SizedBox(height: heightSize*0.015,),
                  //reeneter password
                  SizedBox(
                    width: widthSize * 0.75,
                    height: heightSize*0.080,
                    child: Text("Confirm_Password".tr,style: boldtext,),
                  ),
                  Container(
                    // width: widthSize * 0.85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widthSize * 0.75,
                          height: heightSize*0.080,
                          child: TextFormField(
                            textDirection: text_direction,
                            controller: retypepass,
                            focusNode: fretypepass,
                            style: fieldtext,

                            obscureText: _isVisible ? false : true,
                            decoration:
                            InputDecoration(
                              focusColor: Colors.white,
                              //add prefix icon
                              contentPadding: const EdgeInsets.all(10),
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
                              // //create lable
                              // labelText: 'Retype Your Password',
                              // //lable style
                              // labelStyle: formlabelStyle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          repassword_valid == ""
                              ? " "
                              : repassword_valid ,
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
                  ),
                  SizedBox(height: heightSize*0.15,),
                  Center(
                    child: InkWell(
                      onTap:password_valid=="" &&repassword_valid==""? () async {
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
                        await obg.change_pwd(password.text);
                       await check.erase();
                        Get.offAll(const SiginPage());
                        // openAlertBox();
                      }:null,
                      child: Container(
                        decoration: BoxDecoration(
                          color:buttoncolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: widthSize * 0.435,
                        height: heightSize*0.080,
                        child:  Center(
                          child: Text(
                            "Update_Password".tr,
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
}
