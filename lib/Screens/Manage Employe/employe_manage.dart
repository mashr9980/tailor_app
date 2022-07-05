import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:tailorapp/Screens/DashBoard_Screens/home_page.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/oders.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/drawer.dart';
import 'package:tailorapp/utils/loader.dart';

class ManageEmploye extends StatefulWidget {

  @override
  OrderIdState createState() => OrderIdState();
}

class OrderIdState extends State<ManageEmploye> {
  var orders= Get.put(OrdersController());
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  var lan=GetStorage();
   var status =false;
  TextEditingController entery = TextEditingController();
  final FocusNode fentery = FocusNode();
  List dropdowncounterycode = [];
  List dropdownprogress = [];
  List<String> codes = [
    '+971',
    '+920',
    '+921',
    '+923',
  ];
  var switch_=false;
  List<String> progress = [
    'In Progrss',
    'Stitching',
    'Cutting',
    "Ready",
    "Delivered",
  ];
  var entery_valid = "";
  var code;
  bool checkedValue=false;
  final check = GetStorage('login');
  LogoutBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    const SizedBox(height: 20,),
                    const Text("Logout",style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                    const Text("Are You Sure",style: const TextStyle(color: Colors.black,fontSize: 16,),textAlign: TextAlign.center,),
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
                                child:lan.read("status")=="Arabic"? const Text(
                                  "موافق",
                                  style: TextStyle(color: Colors.red,fontSize: 14),
                                  textAlign: TextAlign.center,
                                ): const Text(
                                  "Back",
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
                                child:lan.read("status")=="Arabic"? const Text(
                                  "موافق",
                                  style: const TextStyle(color: Colors.white,fontSize: 14),
                                  textAlign: TextAlign.center,
                                ): const Text(
                                  "Logout",
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
  void initState() {
    for (var i = 0; i < codes.length; i++) {
      dropdownprogress.add({
        'label': '${progress[i]}',
        'value': '${progress[i]}',
        'icon': Container(
          height: 25,
          width: 25,
          // child: SvgPicture.asset("assets/icons/check.svg"),
        ),
        'selectedIcon': Container(
          key: UniqueKey(),
          width: 20,
          height: 20,
          child: SvgPicture.asset("assets/icons/check.svg"),
        ),
      });
    }
    for (var i = 0; i < codes.length; i++) {
      dropdowncounterycode.add({
        'label': '${codes[i]}',
        'value': '${codes[i]}',
        'icon': Container(
          height: 25,
          width: 25,
          // child: SvgPicture.asset("assets/icons/check.svg"),
        ),
        'selectedIcon': Container(
          key: UniqueKey(),
          width: 20,
          height: 20,
          child: SvgPicture.asset("assets/icons/check.svg"),
        ),
      });
    }
    fentery.addListener(() {
      print("focus node");
      if (!fentery.hasFocus) {
        if (entery.text.isEmpty) {
          entery_valid = lan.read("status")=="Arabic"?"مطلوب هذا الحقل":"Required This Field ";
          setState(() {});
          return;
        } else {
          entery_valid = "";
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
      child: Scaffold(
        backgroundColor: bgcolor,

        // drawer: Drawer(
        //   child: Drawertrail(),
        // ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45.0),
          child: AppBar(
            iconTheme: const IconThemeData(color: iconscolor),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 5,top: 5),
                  child: Image.asset(
                    logo_png,
                    height: 30,
                  ),),
                const SizedBox(width: 20,),
                Text("manage_employee".tr,style: appbartext,),
              ],
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Get.to(const HomePage());
                },
                child: Icon(Icons.home_outlined,size: 35,color: buttontextcolor.withOpacity(0.6),),
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
                child: Image.asset(
                  icon_logout,
                  height: 35,
                  width: 35,
                ),
              ),
            ],
            centerTitle: false,
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
          physics:  const NeverScrollableScrollPhysics(),
          child: Center(
            child: Container(
              width: widthSize * 0.71,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: heightSize*0.03,),
                  // Search field
                  Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: heightSize*0.080,
                          child: TextFormField(
                            // onChanged: (e){
                            //   if(e.trim().isNotEmpty){
                            //     switch_=true;
                            //     setState(() {
                            //
                            //     });
                            //     orders.get_order_by_id(e);
                            //   }
                            //   else{
                            //     switch_=false;
                            //     setState(() {
                            //
                            //     });
                            //   }
                            // },
                            textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                            controller: entery,
                            focusNode: fentery,
                            style: fieldtext,
                            decoration:lan.read("status")=="Arabic"? InputDecoration(
                              focusColor: Colors.white,
                              //add prefix icon
                              suffixIcon: const Icon(
                                Icons.search,
                                color: buttoncolor,
                                size: 40,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.black,
                              hintText: "أدخل رقمك",
                              //make hint text
                              hintStyle: formhinttext,
                              hintTextDirection: TextDirection.rtl,
                              //create lable
                              // labelText: 'رقم الهاتف المحمول',
                              // //lable style
                              // labelStyle: formlabelStyle,

                            ):
                            InputDecoration(
                              suffixIcon: const Icon(
                                    Icons.search,
                                    color: buttoncolor,
                                    size: 40,
                                  ),
                              contentPadding: const EdgeInsets.all(10),
                              focusColor: Colors.white,
                              //add prefix icon
                              // suffix: Container(
                              //   height: 20,
                              //   width: 20,
                              //   margin: EdgeInsets.only(right: 10),
                              //   child: FaIcon(
                              //     FontAwesomeIcons.search,
                              //     color: buttoncolor,
                              //     size: 20,
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
                              hintText: "Search by Name/Mobile # i.e. 03xxxxxxxx",
                              //make hint text
                              hintStyle: formhinttext,
                              // //create lable
                              // labelText: 'Search by Name/Mobile # i.e. 03xxxxxxxx',
                              // //lable style
                              // labelStyle: formlabelStyle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        entery_valid== "" ||  entery_valid== "null"?const SizedBox():Text(entery_valid,
                          style: TextStyle(
                            fontSize:14,
                            color: entery_valid == ""
                                ? const Color(0xffC1C1C1)
                                : Colors.red,
                            fontWeight: FontWeight.w500,

                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize*0.035,),
                  Container(
                    height: heightSize*0.78,
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context,int index){
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.all( 10),
                            // height: heightSize*0.14,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xffDDDDDD),
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color:Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: const Offset(16, 20),
                                  blurRadius: 1.5,
                                  spreadRadius: -13,

                                )
                              ],
                            ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // profile image and  name here
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        //profile image
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xffDDDDDD),
                                                width: 2
                                            ),
                                            borderRadius: BorderRadius.circular(15),
                                            color:Colors.white,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: buttoncolor.withOpacity(0.5),
                                                  blurRadius: 3.0,
                                                  offset: const Offset(0.0, 0.75)
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        // customer name header
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10,),
                                            const Text("Hasham Ahmad",style: boldtext,),
                                            const SizedBox(height: 5,),
                                            const Text("3069009838",style: mediumsubheadingtext,),
                                            const SizedBox(height: 5,),
                                          ],
                                        ),
                                        //buttons update assignm

                                      ],
                                    ),
                                  ),
                                  //swithch button and lable
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        //lable
                                        Container(
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xffDDDDDD),
                                                width: 2
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                            color:Colors.white,
                                            // boxShadow: <BoxShadow>[
                                            //   BoxShadow(
                                            //       color: buttoncolor.withOpacity(0.5),
                                            //       blurRadius: 3.0,
                                            //       offset: Offset(0.0, 0.75)
                                            //   )
                                            // ],
                                          ),
                                          child: const Center(
                                            child:  Text(
                                              "Tailor",style: boldregular1text,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        // switch button
                                        Column(
                                          children: [
                                            FlutterSwitch(
                                              width: 90.0,
                                              height: 30.0,
                                              activeText: "Disable",
                                              showOnOff: true,
                                              inactiveText: "Enable",
                                              inactiveTextColor: Colors.black,
                                              activeTextColor: Colors.black,
                                              inactiveTextFontWeight: FontWeight.w400,
                                              activeTextFontWeight: FontWeight.w400,
                                              toggleSize: 30.0,
                                              value: status,
                                              borderRadius: 30.0,
                                              padding: 2.0,
                                              toggleColor: buttoncolor,
                                              switchBorder: Border.all(
                                                color: buttoncolor,
                                                width: 2.0,
                                              ),
                                              toggleBorder: Border.all(
                                                color: Colors.white,
                                                width: 2.0,
                                              ),
                                              activeColor: Colors.green,
                                              inactiveColor: Colors.white,
                                              onToggle: (val) {
                                                setState(() {
                                                  status = val;
                                                });
                                              },
                                            ),
                                            const SizedBox(height: 5,),
                                            const Text("Login",style: const TextStyle(color: Colors.red,fontWeight:FontWeight.bold,fontSize: 14),),
                                          ],
                                        )

                                        //buttons update assignm

                                      ],
                                    ),
                                  ),
                                ],
                              )
                          );
                        }


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
