import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:tailorapp/Screens/DashBoard_Screens/home_page.dart';
import 'package:tailorapp/Screens/Forgot%20Screens/forgot_screen.dart';
import 'package:tailorapp/Screens/Manage%20Clothes/manage_clothes_main.dart';
import 'package:tailorapp/Screens/Manage%20Employe/employe_manage.dart';
import 'package:tailorapp/Screens/Manage%20Order%20Status/Order_status.dart';
import 'package:tailorapp/Screens/My%20Account/my_account_screen.dart';
import 'package:tailorapp/Screens/Settings%20Screen/profile_mangement.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/update_pwd.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/drawer.dart';
import 'package:tailorapp/utils/loader.dart';

import 'manage_stiching_main.dart';
class SettingMain extends StatefulWidget {
  const SettingMain({Key? key}) : super(key: key);

  @override
  _SettingMainState createState() => _SettingMainState();
}

class _SettingMainState extends State<SettingMain> {
  var lanslect="";
  var local = LocalizationService();
  bool check1=false;
  var rem=GetStorage("logindata");
  var lan=GetStorage();
  final check = GetStorage('login');
  var obj= Get.put(UpdatepwdCon());
  TextEditingController password = TextEditingController();
  final FocusNode fpassword = FocusNode();
  TextEditingController retypepass = TextEditingController();
  final FocusNode fretypepass = FocusNode();
  bool _isVisible = false;
  var password_valid = "";
  var repassword_valid = "";
  // List dropdownlanguageList = [];
  List<String> language = [
    'Arabic',
    'English',
  ];
  List dropdownlanguageList = [
    {'label': 'English', 'value': 'English',

      'selectedIcon': SizedBox(
        key: UniqueKey(),
        width: 20,
        height: 20,
        child: SvgPicture.asset("assets/icons/check.svg"),
      ),
    }, // label is required and unique
    {'label': 'العربية', 'value': 'Arabic',
      'selectedIcon': SizedBox(
        key: UniqueKey(),
        width: 20,
        height: 20,
        child: SvgPicture.asset("assets/icons/check.svg"),
      ),
    },
  ];
  LogoutBox() {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    const SizedBox(height: 20,),
                    Text("Logout".tr,style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                     Text("Are_You_Sure".tr,style: const TextStyle(color: Colors.black,fontSize: 16,),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
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
                                child:  Text(
                                  "back".tr,
                                  style: const TextStyle(color: buttoncolor,fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.only(left: 50,right: 50),
                          child: InkWell(

                            onTap:() async {
                              await check.erase();
                              Get.offAll(const SiginPage());
                            },
                            child: Container(
                              width:  80,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child:  Text(
                                  "Logout".tr,
                                  style: const TextStyle(color: Colors.white,fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //ok Google Map logo

                    const SizedBox(height: 15,),

                  ],
                ),
              )
          );
        });
  }
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  var noti=false;
  // passwordBox() {
  //
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         final double widthSize = MediaQuery.of(context).size.width;
  //         final double heightSize = MediaQuery.of(context).size.height;
  //         return StatefulBuilder(
  //             builder: (context, MsetState){
  //           return AlertDialog(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //               contentPadding: EdgeInsets.all(40),
  //               content: SingleChildScrollView(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.stretch,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Center(
  //                       child: Container(
  //                         width: 200,
  //                         padding: EdgeInsets.only(left: 0,right: 0),
  //                         child: Center(
  //                             child:lan.read("status")=="Arabic"?Text("تم تحديث كلمة السر",style: popup,textAlign: TextAlign.center,): Text("Change Password",style: popup,textAlign: TextAlign.center,)),),
  //                     ),
  //                     // Container(
  //                     //     width: 200,
  //                     //     // height: 60,
  //                     //     margin: EdgeInsets.only(left: 10,right: 10),
  //                     //     child: Loader()),
  //                     // Container(
  //                     //   height: 60,
  //                     //     child: Image.asset("assets/icons/lock.png",)),
  //                     SizedBox(height: heightSize*0.05,),
  //                     //Old password
  //                     Container(
  //                       // width: widthSize * 0.85,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Container(
  //                             width: widthSize * 0.3,
  //                             height: heightSize*0.080,
  //                             child: Center(
  //                               child: TextFormField(
  //                                 onFieldSubmitted: (val){
  //                                   MsetState(() {
  //
  //                                   });
  //                                   setState(() {
  //
  //                                   });
  //
  //                                 },
  //                                 textDirection: lan.read("status")=="Arabic"?TextDirection.rtl:TextDirection.ltr,
  //                                 controller: password,
  //                                 focusNode: fpassword,
  //                                 style: fieldtext,
  //                                 obscureText: _isVisible ? false : true,
  //                                 decoration:lan.read("status")=="Arabic"?
  //                                 InputDecoration(
  //                                   focusColor: Colors.white,
  //                                   //add prefix icon
  //                                   suffixIcon: IconButton(
  //                                     onPressed: (){
  //                                       updateStatus();
  //                                       MsetState(() {
  //
  //                                       });
  //                                       setState(() {
  //
  //                                       });
  //                                     },
  //                                     icon: Icon(_isVisible
  //                                         ? Icons.visibility
  //                                         : Icons.visibility_off),
  //                                   ),
  //                                   border: OutlineInputBorder(
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //                                   contentPadding: EdgeInsets.all(10),
  //                                   focusedBorder: OutlineInputBorder(
  //                                     borderSide:
  //                                     const BorderSide(color: Colors.black, width: 1.0),
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //                                   fillColor: Colors.black,
  //                                   hintText: "أدخل كلمة المرور الجديدة",
  //                                   //make hint text
  //                                   hintStyle: formhinttext,
  //
  //                                   //create lable
  //                                   labelText: 'ادخل رقمك السري',
  //                                   //lable style
  //                                   labelStyle: formlabelStyle,
  //                                 ):
  //                                 InputDecoration(
  //                                   focusColor: Colors.white,
  //                                   contentPadding: EdgeInsets.all(10),
  //                                   //add prefix icon
  //                                   suffixIcon: IconButton(
  //                                     onPressed: (){
  //                                       updateStatus();
  //                                       MsetState(() {
  //
  //                                       });
  //                                       setState(() {
  //
  //                                       });
  //                                     },
  //                                     icon: Icon(_isVisible
  //                                         ? Icons.visibility
  //                                         : Icons.visibility_off),
  //                                   ),
  //                                   border: OutlineInputBorder(
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //
  //                                   focusedBorder:
  //                                   OutlineInputBorder(
  //                                     borderSide:
  //                                     const BorderSide(color: Colors.black, width: 1.0),
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //                                   fillColor: Colors.black,
  //                                   hintText: "Old Password",
  //                                   //make hint text
  //                                   hintStyle: formhinttext,
  //                                   //create lable
  //                                   labelText: 'Old Password',
  //                                   //lable style
  //                                   labelStyle: formlabelStyle,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(height: 5,),
  //                           Text(
  //                             password_valid == ""
  //                                 ? " "
  //                                 : password_valid ,
  //                             style: TextStyle(
  //                               fontSize:14,
  //                               color: password_valid  == ""
  //                                   ? Color(0xffC1C1C1)
  //                                   : Colors.red,
  //                               fontWeight: FontWeight.w500,
  //
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(height: heightSize*0.015,),
  //                     //new password
  //                     Container(
  //                       // width: widthSize * 0.85,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Container(
  //                             width: widthSize * 0.3,
  //                             height: heightSize*0.080,
  //                             child: TextFormField(
  //                               textDirection: lan.read("status")=="Arabic"?TextDirection.rtl:TextDirection.ltr,
  //                               controller: retypepass,
  //                               focusNode: fretypepass,
  //                               style: fieldtext,
  //                               onFieldSubmitted: (val){
  //                                 MsetState(() {
  //
  //                                 });
  //                                 setState(() {
  //
  //                                 });
  //                               },
  //
  //                               obscureText: _isVisible ? false : true,
  //                               decoration:lan.read("status")=="Arabic"?
  //                               InputDecoration(
  //                                 focusColor: Colors.white,
  //                                 contentPadding: EdgeInsets.all(10),
  //                                 //add prefix icon
  //                                 suffixIcon: IconButton(
  //                                   onPressed: (){
  //                                     updateStatus();
  //                                     MsetState(() {
  //
  //                                     });
  //                                     setState(() {
  //
  //                                     });
  //                                   },
  //                                   icon: Icon(_isVisible
  //                                       ? Icons.visibility
  //                                       : Icons.visibility_off),
  //                                 ),
  //                                 border: OutlineInputBorder(
  //                                   borderRadius: BorderRadius.circular(10.0),
  //                                 ),
  //
  //                                 focusedBorder: OutlineInputBorder(
  //                                   borderSide:
  //                                   const BorderSide(color: Colors.black, width: 1.0),
  //                                   borderRadius: BorderRadius.circular(10.0),
  //                                 ),
  //                                 fillColor: Colors.black,
  //                                 hintText: "أعد كتابة كلمة المرور الخاصة بك",
  //                                 //make hint text
  //                                 hintStyle: formhinttext,
  //                                 //create lable
  //                                 labelText: 'أعد كتابة كلمة المرور الخاصة بك',
  //                                 //lable style
  //                                 labelStyle: formlabelStyle,
  //                               ):
  //                               InputDecoration(
  //                                 focusColor: Colors.white,
  //                                 //add prefix icon
  //                                 contentPadding: EdgeInsets.all(10),
  //                                 suffixIcon: IconButton(
  //                                   onPressed:(){
  //                                     updateStatus();
  //                                     MsetState(() {
  //
  //                                     });
  //                                     setState(() {
  //
  //                                     });
  //                                   },
  //                                   icon: Icon(_isVisible
  //                                       ? Icons.visibility
  //                                       : Icons.visibility_off),
  //                                 ),
  //                                 border: OutlineInputBorder(
  //                                   borderRadius: BorderRadius.circular(10.0),
  //                                 ),
  //
  //                                 focusedBorder: OutlineInputBorder(
  //                                   borderSide:
  //                                   const BorderSide(color: Colors.black, width: 1.0),
  //                                   borderRadius: BorderRadius.circular(10.0),
  //                                 ),
  //                                 fillColor: Colors.black,
  //                                 hintText: "New Password",
  //                                 //make hint text
  //                                 hintStyle: formhinttext,
  //                                 //create lable
  //                                 labelText: 'New Password',
  //                                 //lable style
  //                                 labelStyle: formlabelStyle,
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(height: 5,),
  //                           Text(
  //                             repassword_valid == ""
  //                                 ? " "
  //                                 : repassword_valid ,
  //                             style: TextStyle(
  //                               fontSize:14,
  //                               color: repassword_valid == ""
  //                                   ? Color(0xffC1C1C1)
  //                                   : Colors.red,
  //                               fontWeight: FontWeight.w500,
  //
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     Center(
  //                       child: InkWell(
  //                         onTap: () async {
  //                           loadingbox();
  //                           var a = await obj.change_pwd(password.text,retypepass.text);
  //                           Navigator.pop(context);
  //                           print("statusofa${a}");
  //                           if(a){
  //                             pwdupdateBox(a);
  //
  //                           }else{
  //                             pwdupdateBox(a);
  //                           }
  //                           print("p1${password.text}");
  //                           print("p2${retypepass.text}");
  //
  //                         },
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             color: buttoncolor,
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           width: widthSize * 0.25,
  //                           height: heightSize*0.080,
  //                           child:  Center(
  //                             child: lan.read("status")=="Arabic"?Text(
  //                               "تسجيل الدخول",
  //                               style: buttontext,
  //                             ):Text(
  //                               "Save Password",
  //                               style: buttontext,
  //                             ),
  //
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //
  //                   ],
  //                 ),
  //               )
  //           );
  //             }
  //         );
  //
  //
  //       });
  // }

  void initState() {
    // for (var i = 0; i < language.length; i++) {
    //   dropdownlanguageList.add(
    //     {
    //       'label': '${language[i]}',
    //       'value': '${language[i]}',
    //       'icon': Container(
    //         key: UniqueKey(),
    //         height: 20,
    //         width: 20,
    //         // child: SvgPicture.asset("assets/icons/check.svg"),
    //       ),
    //       'selectedIcon': Container(
    //         key: UniqueKey(),
    //         width: 20,
    //         height: 20,
    //         child: SvgPicture.asset("assets/icons/check.svg"),
    //       ),
    //     },
    //   );
    // }
    fpassword.addListener(() {
      // print("focus node");
      if (!fpassword.hasFocus) {
        if (password.text.isEmpty) {
          password_valid = "required".tr;
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
          repassword_valid="required".tr;
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
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    var lan=GetStorage();

    return Directionality(
      textDirection:text_direction,
      child: Scaffold(
        drawer: const Drawer(
          child: Drawertrail(),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            actions: [
              // Container(
              //     padding: const EdgeInsets.all(5),
              //     height: 35,
              //     child: Image.asset(
              //       logo_png,
              //       height: 20,
              //     )),

              GestureDetector(
                onTap: () {
                  Get.to(const HomePage());
                },
                child: Icon(Icons.home_outlined,color: buttontextcolor.withOpacity(0.6),size: 35,),
              ),
              GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.notification_important,color: buttontextcolor.withOpacity(0.6),size: 35,)
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
                child: Icon(Icons.logout_outlined,size: 35,color: Colors.red,),
              ),
            ],
            iconTheme: const IconThemeData(color: iconscolor),
            toolbarHeight: 40,
            centerTitle: false,
            backgroundColor: APPBARCOLOR,
            title:   Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 5,top: 5),
                  child: Image.asset(
                    logo_png,
                    height: 30,
                  ),),
                const SizedBox(width: 20,),
                Text(
                  "settings".tr,
                  style: appbartext,
                ),
              ],
            ),
            // leading: InkWell(
            //   onTap: () {
            //     Get.to(HomePage());
            //   },
            //   child:const Icon(
            //     Icons.arrow_back,
            //     color: Colors.black,
            //     size: 25,
            //   ),
            // ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            // width: widthSize,
            // height: heightSize,
            margin: EdgeInsets.only(left: widthSize*0.2,right: widthSize*0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: heightSize*0.045,),

                //My Account
                InkWell(
                  onTap: (){
                    Get.to(const MyAccount());
                  },
                  child: Container(
                    height: heightSize*0.080,
                    width: widthSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>  [
                        BoxShadow(
                          color: buttoncolor,
                          blurRadius: 2.0,
                          // offset: Offset(0.0, 0.5)
                        )
                      ],
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("my_account".tr,style: normalStyle,),
                            const Icon(Icons.arrow_right,size: 20,color: iconscolor,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.03,),
                //Mange Clothes
                InkWell(
                  onTap: (){
                    Get.to(ClothesMainPage());
                  },
                  child: Container(
                    height: heightSize*0.080,
                    width: widthSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const <BoxShadow>  [
                          BoxShadow(
                            color: buttoncolor,
                            blurRadius: 2.0,
                            // offset: Offset(0.0, 0.5)
                          )
                        ],
                      ),
                    child: Center(
                       child: Container(
                         padding: const EdgeInsets.only(left: 20,right: 20),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                              Text("manage_cloth".tr,style: normalStyle,),
                             const Icon(Icons.arrow_right,size: 20,color: iconscolor,)
                           ],
                         ),
                       ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.03,),
                //Manage Employee
                InkWell(
                  onTap: (){
                    Get.to(ManageEmploye());
                  },
                  child: Container(
                    height: heightSize*0.080,
                    width: widthSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>  [
                        BoxShadow(
                          color: buttoncolor,
                          blurRadius: 2.0,
                          // offset: Offset(0.0, 0.5)
                        )
                      ],
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("manage_employee".tr,style: normalStyle,),
                            const Icon(Icons.arrow_right,size: 20,color: iconscolor,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.03,),
                //Manage Order Status
                InkWell(
                  onTap: (){
                    Get.to(ManageOrderStaus());
                  },
                  child: Container(
                    height: heightSize*0.080,
                    width: widthSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>  [
                        BoxShadow(
                          color: buttoncolor,
                          blurRadius: 2.0,
                          // offset: Offset(0.0, 0.5)
                        )
                      ],
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("manage_order_status".tr,style: normalStyle,),
                            const Icon(Icons.arrow_right,size: 20,color: iconscolor,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.03,),
                //Manage Stiching Product
                InkWell(
                  onTap: (){
                    Get.to(const MangeStichingScreen());
                  },
                  child: Container(
                    height: heightSize*0.080,
                    width: widthSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>  [
                        BoxShadow(
                          color: buttoncolor,
                          blurRadius: 2.0,
                          // offset: Offset(0.0, 0.5)
                        )
                      ],
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("manage_stiching_product".tr,style: normalStyle,),
                            const Icon(Icons.arrow_right,size: 20,color: iconscolor,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.03,),
                //Mange Notifications
                Container(
                  width: widthSize,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow:  const <BoxShadow>  [
                      BoxShadow(
                        color: buttoncolor,
                        blurRadius: 2.0,
                        // offset: Offset(0.0, 0.5)
                      )
                    ],
                  ),
                  child: ExpansionTile(
                    collapsedIconColor: Colors.black,
                      iconColor: Colors.grey,
                      title:  Text("notifications_setting".tr,style: normalStyle,),
                      children:[
                      ListTile(
                            title:  Text("notification_tune".tr,style: normalStyle,),
                            trailing:Container(
                              height: 40,
                              width: 70,
                              child: FlutterSwitch(
                                width: 60.0,
                                height: 25.0,
                                activeText: "Off",
                                showOnOff: true,
                                inactiveText: "On",
                                inactiveTextColor: Colors.black,
                                activeTextColor: Colors.black,
                                inactiveTextFontWeight: FontWeight.w400,
                                activeTextFontWeight: FontWeight.w400,
                                toggleSize: 15.0,
                                value: noti,
                                borderRadius: 20.0,
                                padding: 2.0,
                                toggleColor: buttoncolor,
                                switchBorder: Border.all(
                                  color: buttoncolor,
                                  width: 1.0,
                                ),
                                toggleBorder: Border.all(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                                activeColor: Colors.green,
                                inactiveColor: Colors.white,
                                onToggle: (val) {
                                  setState(() {
                                    noti = val;
                                  });
                                },
                              ),
                            ),
                            enableFeedback: true,
                        enabled: true,


                )

                      ])
                ),
                SizedBox(height: heightSize*0.03,),
                //Mange language
                Container(
                  // height: heightSize*0.080,
                  width: widthSize,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const <BoxShadow>  [
                      BoxShadow(
                        color: buttoncolor,
                        blurRadius: 2.0,
                        // offset: Offset(0.0, 0.5)
                      )
                    ],
                  ),
                  child:  ExpansionTile(
                    title: Text("change_language".tr,style: normalStyle,),
                      children: <Widget> [
                               ListTile(
                                title:  Text("select_lang".tr,style: normalStyle,),

                                 subtitle: Container(
                                   margin: const EdgeInsets.only(top: 10),
                                   padding: const EdgeInsets.only(left: 20,right: 20),
                                   decoration: BoxDecoration(
                                     border: Border.all(
                                         color: const Color(0xffDDDDDD),
                                         width: 2
                                     ),
                                     borderRadius: BorderRadius.circular(5),
                                     color:Colors.white,
                                     boxShadow: const [
                                       // BoxShadow(
                                       //   color: Color(0xFFE8F5FF),
                                       //   blurRadius: 1.5,
                                       //   spreadRadius: 1.0, //extend the shadow
                                       // )
                                     ],
                                   ),
                                   // color: Colors.red,
                                   height: heightSize*0.080,
                                   child: CoolDropdown(
                                     dropdownHeight: 150,
                                     dropdownWidth:widthSize * 0.55,
                                     resultBD: BoxDecoration(
                                       color: Colors.transparent,
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                     isTriangle: false,
                                     dropdownBD: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(5),
                                     ),
                                     isResultIconLabel: true,
                                     resultWidth: widthSize * 0.55,
                                     dropdownList: dropdownlanguageList,
                                     defaultValue: null,
                                     isResultLabel: true,
                                     gap: 10,
                                     placeholder:"select".tr,
                                     dropdownItemPadding: const EdgeInsets.only(left: 20,right: 20),
                                     selectedItemPadding: const EdgeInsets.only(left: 20,right: 20),
                                     placeholderTS:const TextStyle(
                                         fontSize:  14,
                                         color:  Color(0xff8a8a8a),
                                         fontWeight: FontWeight.bold,
                                         fontFamily: "Poppins"),
                                     selectedItemBD: BoxDecoration(
                                       // color: const Color(0xffE8F5FF),
                                       borderRadius: BorderRadius.circular(5),

                                     ),
                                     selectedItemTS: const TextStyle(
                                         fontSize: 14,
                                         color: Color(0xff0037da),
                                         fontWeight: FontWeight.w500,
                                         fontFamily: "Poppins"),
                                     resultTS:const TextStyle(
                                         fontSize:  14,
                                         color:  Color(0xff8a8a8a),
                                         fontWeight: FontWeight.w500,
                                         fontFamily: "Poppins"),
                                     unselectedItemTS:const TextStyle(
                                         fontSize:  15,
                                         color: Color(0xff212121),
                                         fontWeight: FontWeight.w500,
                                         fontFamily: "Poppins"),
                                     onChange: (a) {
                                       setState(() {
                                         lanslect=a["value"];
                                         rem.write('status', a["value"]);
                                         check1=false;
                                         local.changeLocale(a["value"]);
                                       });
                                     },
                                     dropdownItemReverse: false,
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

                               )
                      ]
                  )
                ),
                SizedBox(height: heightSize*0.03,),
                //ShopeMangement
                InkWell(
                  onTap:(){
                    Get.to(const ShopeMangement());
                  },
                  child: Container(
                    height: heightSize*0.080,
                    width: widthSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>  [
                        BoxShadow(
                          color: buttoncolor,
                          blurRadius: 2.0,
                          // offset: Offset(0.0, 0.5)
                        )
                      ],
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("manage_shop_profile".tr,style: normalStyle,),
                            const Icon(Icons.arrow_right,size: 20,color: iconscolor,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.03,),
                //Change Password
                InkWell(
                  onTap: (){
                    // passwordBox();
                    Get.to(ForgetScreen());
                  },
                  child: Container(
                    height: heightSize*0.080,
                    width: widthSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>  [
                        BoxShadow(
                          color: buttoncolor,
                          blurRadius: 2.0,
                          // offset: Offset(0.0, 0.5)
                        )
                      ],
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("change_password".tr,style: normalStyle,),
                            const Icon(Icons.arrow_right,size: 20,color: iconscolor,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.045,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
