import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:tailorapp/Screens/Forgot%20Screens/update_password_email.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/drawer.dart';
class Contactus extends StatefulWidget {
  const Contactus({Key? key}) : super(key: key);

  @override
  ContactusState createState() => ContactusState();
}

class ContactusState extends State<Contactus> {
  TextEditingController email = TextEditingController();
  final FocusNode femail = FocusNode();
  TextEditingController name = TextEditingController();
  final FocusNode fname = FocusNode();
  TextEditingController query = TextEditingController();
  final FocusNode fquery = FocusNode();
  TextEditingController phone = TextEditingController();
  final FocusNode fphone = FocusNode();
  var email_valid = "";
  var query_valid="";
  var name_valid="";
  var  phone_valid="";
  var lan=GetStorage();
  openAlertBox() {

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return Directionality(
            textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
            child: AlertDialog(

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                contentPadding: EdgeInsets.only(top: 10.0),

                content: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children:const [
                      SizedBox(height: 20,),
                      Center(
                        child: Text("Thank You",style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: Text("for contacting 1S360.",style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: Text("1S360 team will contact you shortly",style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                )
            ),
          );
        });
  }
  void initState() {
    fname.addListener(() {
      print("focus node");
      if (!fname.hasFocus) {
        if (name.text.isEmpty) {
          name_valid =lan.read("status")=="Arabic"?"مطلوب هذا الحقل":"Required";
          setState(() {});
          return;
        } else {
          name_valid = "";
          setState(() {});
          return;
        }
      }
    });
    fphone.addListener(() {
      print("focus node");
      if (!fphone.hasFocus) {
        if (phone.text.isEmpty) {
          phone_valid =lan.read("status")=="Arabic"?"مطلوب هذا الحقل":"Required";
          setState(() {});
          return;
        } else {
          phone_valid = "";
          setState(() {});
          return;
        }
      }
    });

    fquery.addListener(() {
      print("focus node");
      if (!fquery.hasFocus) {
        if (query.text.isEmpty) {
          query_valid =lan.read("status")=="Arabic"?"مطلوب هذا الحقل":"Required";
          setState(() {});
          return;
        } else {
          query_valid = "";
          setState(() {});
          return;
        }
      }
    });
    femail.addListener(() {
      print("focus node");
      if (!femail.hasFocus) {
        if (email.text.isEmpty) {
          email_valid =lan.read("status")=="Arabic"?"مطلوب هذا الحقل":"Required This Field ";
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
  LogoutBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.only(top: 10.0),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    SizedBox(height: 20,),
                    Text("Logout",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    SizedBox(height: 30,),
                    Text("Are You Sure",style: TextStyle(color: Colors.black,fontSize: 16,),textAlign: TextAlign.center,),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          // margin: EdgeInsets.only(left: 50,right: 50),
                          child: InkWell(

                            onTap:(){
                              Get.back();
                            },
                            child: Container(
                              width:  80,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.red,
                                    width: 1
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child:lan.read("status")=="Arabic"? Text(
                                  "موافق",
                                  style: TextStyle(color: Colors.red,fontSize: 14),
                                  textAlign: TextAlign.center,
                                ): Text(
                                  "Back",
                                  style: TextStyle(color: buttoncolor,fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.only(left: 50,right: 50),
                          child: InkWell(

                            onTap:(){
                              Get.to(SiginPage());
                            },
                            child: Container(
                              width:  80,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child:lan.read("status")=="Arabic"? Text(
                                  "موافق",
                                  style: TextStyle(color: Colors.white,fontSize: 14),
                                  textAlign: TextAlign.center,
                                ): Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.white,fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //ok Google Map logo

                    SizedBox(height: 15,),

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
      textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: bgcolor,
        drawer: Drawer(
          child: Drawertrail(),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            iconTheme: IconThemeData(color: iconscolor),
            actions: [
              Container(
                  padding: EdgeInsets.all(5),
                  height: 35,
                  child: Image.asset(
                    logo_png,
                    height: 20,
                  )),

              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  icon_setting,
                  height: 35,
                  width: 35,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  icon_bell,
                  height: 35,
                  width: 35,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  logo_whatsapp,
                  height: 35,
                  width: 35,
                ),
              ),
              GestureDetector(
                onTap: () {
                  LogoutBox();
                },
                child: Image.asset(
                  icon_logout,
                  height: 35,
                  width: 35,
                ),
              ),
            ],
            title:
            Container(
              width: widthSize*0.200,
              child:lan.read("status")=="Arabic"?Text("إعادة تعيين كلمة المرور",style: appbartext,):Text("Contact Us",style: appbartext,)
            ),
            toolbarHeight: 45,
            // automaticallyImplyLeading: false,
            backgroundColor: APPBARCOLOR,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: heightSize*0.050,),
                //Enter Title
                Container(
                  width: widthSize * 0.6,
                  height: heightSize*0.060,
                  child: lan.read("status")=="Arabic"?Text("أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور",style: boldtext,):Text("Problem Title",style: boldtext,),
                ),
                Container(
                  // width: widthSize * 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: widthSize * 0.6,
                        height: heightSize*0.080,
                        child: Directionality(
                          textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                          child: TextFormField(
                            textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                            controller: name,
                            focusNode: fname,
                            style: fieldtext,
                            decoration:lan.read("status")=="Arabic"?
                            InputDecoration(
                              focusColor: Colors.white,
                              //add prefix icon
                              suffix: Container(
                                height: 20,
                                width: 20,
                                margin:lan.read("status")=="Arabic"?EdgeInsets.only(left: 10,top: 20,right:10): EdgeInsets.only(left: 10,top: 20,right:10),
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
                              hintText: "أدخل بريدك الإلكتروني",
                              //make hint text
                              hintStyle: formhinttext,
                              hintTextDirection: TextDirection.rtl,
                              //create lable
                              // labelText: 'أدخل بريدك الإلكتروني',
                              // //lable style
                              // labelStyle: formlabelStyle,

                            ):
                            InputDecoration(

                              focusColor: Colors.white,
                              //add prefix icon
                              suffix: Container(
                                height: 20,
                                width: 20,
                                margin:lan.read("status")=="Arabic"?EdgeInsets.only(left: 10,top: 20,right: 10): EdgeInsets.only(left: 10,top: 20,right: 10),
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
                              hintText: "Write Your Problem Title",
                              //make hint text
                              hintStyle: formhinttext,
                              //create lable
                              // labelText: 'Enter Your Name',
                              // //lable style
                              // labelStyle: formlabelStyle,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        name_valid == ""
                            ? " "
                            : name_valid ,
                        style: TextStyle(
                          fontSize:14,
                          color: name_valid  == ""
                              ? Color(0xffC1C1C1)
                              : Colors.red,
                          fontWeight: FontWeight.w500,

                        ),
                      )
                    ],
                  ),
                ),
                // SizedBox(height: heightSize*0.01,),
                // //Enter Your Number
                // Container(
                //   width: widthSize * 0.6,
                //   height: heightSize*0.060,
                //   child: lan.read("status")=="Arabic"?Text("أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور",style: boldtext,):Text("Enter Your Phone #",style: boldtext,),
                // ),
                // Container(
                //   // width: widthSize * 0.85,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         width: widthSize * 0.6,
                //         height: heightSize*0.080,
                //         child: Directionality(
                //           textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                //           child: TextFormField(
                //             textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                //             controller: phone,
                //             focusNode: fphone,
                //             style: fieldtext,
                //             decoration:lan.read("status")=="Arabic"?
                //             InputDecoration(
                //               focusColor: Colors.white,
                //               //add prefix icon
                //               suffix: Container(
                //                 height: 20,
                //                 width: 20,
                //                 margin:lan.read("status")=="Arabic"?EdgeInsets.only(left: 10,top: 20,): EdgeInsets.only(left: 10,top: 20,),
                //                 child:const FaIcon(
                //                   FontAwesomeIcons.envelope,
                //                   color: buttoncolor,
                //                   size: 25,
                //                 ),
                //               ),
                //               border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(10.0),
                //               ),
                //
                //               focusedBorder: OutlineInputBorder(
                //                 borderSide: const BorderSide(color: Colors.black, width: 1.0),
                //                 borderRadius: BorderRadius.circular(10.0),
                //               ),
                //               fillColor: Colors.black,
                //               hintText: "0300-XXXXXXXX",
                //               //make hint text
                //               hintStyle: formhinttext,
                //               hintTextDirection: TextDirection.rtl,
                //               //create lable
                //               // labelText: 'أدخل بريدك الإلكتروني',
                //               // //lable style
                //               // labelStyle: formlabelStyle,
                //
                //             ):
                //             InputDecoration(
                //
                //               focusColor: Colors.white,
                //               //add prefix icon
                //               suffix: Container(
                //                 height: 20,
                //                 width: 20,
                //                 margin:lan.read("status")=="Arabic"?EdgeInsets.only(left: 10,top: 20,): EdgeInsets.only(left: 10,top: 20,),
                //                 child:const FaIcon(
                //                   FontAwesomeIcons.envelope,
                //                   color: buttoncolor,
                //                   size: 25,
                //                 ),
                //               ),
                //               border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(10.0),
                //               ),
                //
                //               focusedBorder: OutlineInputBorder(
                //                 borderSide: const BorderSide(color: Colors.black, width: 1.0),
                //                 borderRadius: BorderRadius.circular(10.0),
                //               ),
                //               fillColor: Colors.black,
                //               hintText: "0300-XXXXXXXX",
                //               //make hint text
                //               hintStyle: formhinttext,
                //               // //create lable
                //               // labelText: 'Enter Your Name',
                //               // //lable style
                //               // labelStyle: formlabelStyle,
                //             ),
                //           ),
                //         ),
                //       ),
                //       SizedBox(height: 5,),
                //       Text(
                //         phone_valid == ""
                //             ? " "
                //             : phone_valid ,
                //         style: TextStyle(
                //           fontSize:14,
                //           color: phone_valid  == ""
                //               ? Color(0xffC1C1C1)
                //               : Colors.red,
                //           fontWeight: FontWeight.w500,
                //
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(height: heightSize*0.01,),
                // //Enter your Email
                // Container(
                //   width: widthSize * 0.6,
                //   height: heightSize*0.060,
                //   child: lan.read("status")=="Arabic"?Text("أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور",style: boldtext,):Text("Enter your email",style: boldtext,),
                // ),
                // Container(
                //   // width: widthSize * 0.85,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         width: widthSize * 0.6,
                //         height: heightSize*0.080,
                //         child: Directionality(
                //           textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                //           child: TextFormField(
                //             textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                //             controller: email,
                //             focusNode: femail,
                //             style: fieldtext,
                //             decoration:lan.read("status")=="Arabic"?
                //             InputDecoration(
                //               focusColor: Colors.white,
                //               //add prefix icon
                //               suffix: Container(
                //                 height: 20,
                //                 width: 20,
                //                 margin:lan.read("status")=="Arabic"?EdgeInsets.only(left: 10,top: 20,): EdgeInsets.only(left: 10,top: 20,),
                //                 child:const FaIcon(
                //                   FontAwesomeIcons.envelope,
                //                   color: buttoncolor,
                //                   size: 25,
                //                 ),
                //               ),
                //               border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(10.0),
                //               ),
                //
                //               focusedBorder: OutlineInputBorder(
                //                 borderSide: const BorderSide(color: Colors.black, width: 1.0),
                //                 borderRadius: BorderRadius.circular(10.0),
                //               ),
                //               fillColor: Colors.black,
                //               hintText: "أدخل بريدك الإلكتروني",
                //               //make hint text
                //               hintStyle: formhinttext,
                //               hintTextDirection: TextDirection.rtl,
                //               //create lable
                //               labelText: 'أدخل بريدك الإلكتروني',
                //               //lable style
                //               labelStyle: formlabelStyle,
                //
                //             ):
                //             InputDecoration(
                //
                //               focusColor: Colors.white,
                //               //add prefix icon
                //               suffix: Container(
                //                 height: 20,
                //                 width: 20,
                //                 margin:lan.read("status")=="Arabic"?EdgeInsets.only(left: 10,top: 20,): EdgeInsets.only(left: 10,top: 20,),
                //                 child:const FaIcon(
                //                   FontAwesomeIcons.envelope,
                //                   color: buttoncolor,
                //                   size: 25,
                //                 ),
                //               ),
                //               border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(10.0),
                //               ),
                //
                //               focusedBorder: OutlineInputBorder(
                //                 borderSide: const BorderSide(color: Colors.black, width: 1.0),
                //                 borderRadius: BorderRadius.circular(10.0),
                //               ),
                //               fillColor: Colors.black,
                //               hintText: "Abc@gmail.com (optional)",
                //               //make hint text
                //               hintStyle: formhinttext,
                //               //create lable
                //               labelText: 'Email Address',
                //               //lable style
                //               labelStyle: formlabelStyle,
                //             ),
                //           ),
                //         ),
                //       ),
                //       SizedBox(height: 5,),
                //       Text(
                //         email_valid == ""
                //             ? " "
                //             : email_valid ,
                //         style: TextStyle(
                //           fontSize:14,
                //           color: email_valid  == ""
                //               ? Color(0xffC1C1C1)
                //               : Colors.red,
                //           fontWeight: FontWeight.w500,
                //
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(height: heightSize*0.01,),
                //enter your Query
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: widthSize * 0.6,
                        height: heightSize*0.4,
                        child: Directionality(
                          textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                            controller: query,
                            focusNode: fquery,
                            style: fieldtext,
                            decoration:lan.read("status")=="Arabic"?
                            InputDecoration(
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.black,
                              hintText: "أدخل بريدك الإلكتروني",
                              //make hint text
                              hintStyle: formhinttext,
                              hintTextDirection: TextDirection.rtl,
                              //create lable
                              // labelText: 'أدخل بريدك الإلكتروني',
                              // //lable style
                              // labelStyle: formlabelStyle,

                            ):
                            InputDecoration(

                              focusColor: Colors.white,
                              //add prefix icon
                              // suffix: Container(
                              //   height: 20,
                              //   width: 20,
                              //   margin:lan.read("status")=="Arabic"?EdgeInsets.only(left: 10,top: 20,): EdgeInsets.only(left: 10,top: 20,),
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
                              hintText: "Enter Your Message/Query",
                              //make hint text
                              hintStyle: formhinttext,
                              //create lable
                              // labelText: 'Enter Your Message/Query',
                              //lable style
                              // labelStyle: formlabelStyle,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        query_valid == "" || query_valid=="null"
                            ? " "
                            : query_valid ,
                        style: TextStyle(
                          fontSize:14,
                          color: query_valid  == ""
                              ? Color(0xffC1C1C1)
                              : Colors.red,
                          fontWeight: FontWeight.w500,

                        ),
                      )
                    ],
                  ),
                SizedBox(height: heightSize*0.1,),
                // Submioted button
                Center(
                  child: InkWell(
                    onTap: (){
                      openAlertBox();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: buttoncolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: widthSize * 0.3,
                      height: heightSize*0.080,
                      child:  Center(
                        child: lan.read("status")=="Arabic"?Text(
                          "تسجيل الدخول",
                          style: buttontext,
                        ):Text(
                          "Submit",
                          style: buttontext,
                        ),

                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.025,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
