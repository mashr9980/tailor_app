import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lottie/lottie.dart';
import 'package:tailorapp/Screens/DashBoard_Screens/home_page.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/oders.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/drawer.dart';
import 'package:tailorapp/utils/loader.dart';

class ManageOrderStaus extends StatefulWidget {

  @override
  OrderIdState createState() => OrderIdState();
}

class OrderIdState extends State<ManageOrderStaus> {
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
  var selectedstatus;
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
                  borderRadius: BorderRadius.all(const Radius.circular(10.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    const SizedBox(height: 20,),
                    const Text("Logout",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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
                                  style: const TextStyle(color: Colors.red,fontSize: 14),
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

                    const Center(child: Text("Submitting your Request"),),
                    const SizedBox(height: 10,),

                  ],
                ),
              )
          );
        });
  }
  StatusBox() {

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return StatefulBuilder(
              builder: (context, MsetState){
                return AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                    contentPadding: const EdgeInsets.all(20),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Container(
                              width: 200,
                              padding: const EdgeInsets.only(left: 0,right: 0),
                              child: Center(
                                  child:lan.read("status")=="Arabic"?const Text("تم تحديث كلمة السر",style: popup,textAlign: TextAlign.center,): const Text("Add Status",style: popup,textAlign: TextAlign.center,)),),
                          ),
                          // Container(
                          //     width: 200,
                          //     // height: 60,
                          //     margin: EdgeInsets.only(left: 10,right: 10),
                          //     child: Loader()),
                          // Container(
                          //   height: 60,
                          //     child: Image.asset("assets/icons/lock.png",)),
                          SizedBox(height: heightSize*0.05,),

                          //new password
                          Container(
                            width: widthSize * 0.3,
                            height: heightSize*0.080,
                            child: CoolDropdown(
                              dropdownWidth: widthSize*0.3,
                              resultBD: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey,width: 1)
                              ),

                              isTriangle: false,
                              dropdownBD: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              isResultIconLabel: true,
                              dropdownItemReverse:false,
                              resultWidth: widthSize*0.4,
                              dropdownList: dropdownprogress,
                              // defaultValue: dropdowncounterycode[obj.current_country.value],
                              isResultLabel: true,
                              gap: 4,
                              placeholder: "Select Status",
                              placeholderTS: TextStyle(
                                  fontSize:  widthSize*0.014,
                                  color:  const Color(0xff8a8a8a),
                                  fontWeight: FontWeight.bold,


                                  fontFamily: "Poppins"),

                              selectedItemBD: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),

                              ),
                              selectedItemTS: const TextStyle(
                                  fontSize: 14,
                                  color: const Color(0xff0037da),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins"),
                              resultTS: TextStyle(
                                  fontSize:  widthSize*0.014,
                                  color:  Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins"),
                              unselectedItemTS: TextStyle(
                                  fontSize:  widthSize*0.014,
                                  color: const Color(0xff212121),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins"),
                              onChange: (a) {
                                setState(() {
                                  selectedstatus=a["label"];
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

                          SizedBox(height: heightSize*0.1,),
                          Center(
                            child: InkWell(
                              onTap: () async {
                                loadingbox();
                                // var a = await obj.change_pwd(password.text,retypepass.text);
                                // Navigator.pop(context);

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: buttoncolor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: widthSize * 0.25,
                                height: heightSize*0.080,
                                child:  Center(
                                  child: lan.read("status")=="Arabic"?const Text(
                                    "تسجيل الدخول",
                                    style: buttontext,
                                  ):const Text(
                                    "Save",
                                    style: buttontext,
                                  ),

                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
                );
              }
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
      textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: bgcolor,
        // drawer: Drawer(
        //   child: Drawertrail(),
        // ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45.0),
          child: AppBar(
            iconTheme: const IconThemeData(color: iconscolor),
            title: Text("manage_order_status".tr,style: appbartext,),
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
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: widthSize * 0.71,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: heightSize*0.03,),
                      // Search field
                      Container(

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: heightSize*0.080,
                              child: const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: const Text("List of All Status",style: boldregular1text,)),
                            ),
                            InkWell(
                              onTap: (){
                                StatusBox();
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 0,right: 0),
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:buttoncolor,
                                ),
                                child: const Center(child: const Text("Add Status",style:TextStyle(color: Colors.white,fontSize: 15),)),
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
                                        height: 60,
                                        width: 100,
                                        // decoration: BoxDecoration(
                                        //   border: Border.all(
                                        //       color: Color(0xffDDDDDD),
                                        //       width: 2
                                        //   ),
                                        //   borderRadius: BorderRadius.circular(15),
                                        //   color:Colors.white,
                                        // ),
                                        child: const Center(child: Text("Delivered",style: boldregular1text,)),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.red,
                                              width: 2
                                          ),
                                          borderRadius: BorderRadius.circular(15),
                                          color:Colors.white,
                                        ),
                                        child: const Center(child: const Text("Delete",style: mediumsubredtext,)),
                                      )
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
              Positioned(
                right: 300,
                left: 300,
                bottom: 50,
                child: Container(
                  margin: const EdgeInsets.only(left: 0,right: 0),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:buttoncolor,
                  ),
                  child: const Center(child: Text("Ok",style:TextStyle(color: Colors.white,fontSize: 18),)),
                ),
              )
            ],
          )

        ),
      ),
    );
  }
}
