import 'package:intl/intl.dart';
import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:tailorapp/Screens/DashBoard_Screens/home_page.dart';
import 'package:tailorapp/Screens/Google%20Maps/custom_location.dart';
import 'package:tailorapp/Screens/Google%20Maps/map_main.dart';
import 'package:tailorapp/Screens/Settings%20Screen/pdf_view.dart';
import 'package:tailorapp/Screens/Settings%20Screen/setting_main.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/profile.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:tailorapp/utils/loader.dart';
import 'package:bottom_picker/bottom_picker.dart';
class ShopeMangement extends StatefulWidget {
  const ShopeMangement({Key? key}) : super(key: key);

  @override
  _ShopeMangementState createState() => _ShopeMangementState();
}

class _ShopeMangementState extends State<ShopeMangement> {
  var lan=GetStorage();
  // TimeOfDay _time = TimeOfDay.now();
  var profile=Get.put(profileController());
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

  TextEditingController address = TextEditingController();
  final FocusNode faddress = FocusNode();

  TextEditingController per_hour = TextEditingController();
  final FocusNode fper_hour= FocusNode();
  late PDFDocument license;
  late PDFDocument license2;
  late PDFDocument auth;
  var per_hour_valid = "";
  var code="";
  var name_valid = "";
  var last_name_valid = "";
  var email_valid = "";
  var phone_valid = "";
  var whatsapp_valid = "";
  var password_valid = "";
  var repassword_valid = "";
var loading=true;
  var address_valid="";
  List dropdowncounterycode = [];
  List<String> codes = [
    '+971',
    '+920',
    '+921',
    '+923',
  ];
  TextEditingController shope = TextEditingController();
  final TextEditingController datec1 = TextEditingController();
  final TextEditingController datec2 = TextEditingController();
  final FocusNode fshope = FocusNode();
  var shope_valid = "";
  List Controller = [
    [
      TextEditingController(),
      TextEditingController()
    ],
    [
      TextEditingController(),
      TextEditingController()
    ],
    [
      TextEditingController(),
      TextEditingController()
    ],
    [
      TextEditingController(),
      TextEditingController()
    ],
    [
      TextEditingController(),
      TextEditingController()
    ],
    [
      TextEditingController(),
      TextEditingController()
    ],
    [
      TextEditingController(),
      TextEditingController()
    ],
  ];
  var days = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"];
  var days_c = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  var selected = [false, false, false, false, false, false, false];
  var is_license_pdf=false;
  var is_auth_pdf=false;
  var is_license2_pdf=false;

  loaddata() async {
    await profile.get_my_business();

    // print("scsdv ${profile.data_profile.value}");
    name.text=profile.data_profile.value['shop_name']??"";
    // fname.text=profile.data_profile.value[''];
    address.text=profile.data_profile.value['address']??"";
    profile.set_google(profile.data_profile.value['google']);
    per_hour.text=profile.data_profile.value['per_hour'].toString()??"";
    for(int i=0;i<profile.data_profile.value['days'].length;i++){
      if(profile.data_profile.value['days'][i]["is_select"]) {
        var id = days_c.indexOf(profile.data_profile.value['days'][i]["day"]);
        // var d = userDocument[0]['office_hours'].where((single) => single["day"]==days).toList();
        // print("d=>>>>>>>>>>>>> ${d}");
        // print("days data $d");
        if (id != null) {
          selected[id] = true;

          Controller[id][0].text =DateFormat.jm().format(DateFormat("hh:mm:ss").parse(profile.data_profile.value['days'][i]['start']));

          Controller[id][1].text =DateFormat.jm().format(DateFormat("hh:mm:ss").parse(profile.data_profile.value['days'][i]['end']));
        }
      }
    }
    var ext = "." + profile.data_profile.value['license'].split('.').last;
    if(ext==".pdf") {
      // license = await PDFDocument.fromURL(
      //   "${profile.data_profile.value['license']}",
      //   /* cacheManager: CacheManager(
      //     Config(
      //       "customCacheKey",
      //       stalePeriod: const Duration(days: 2),
      //       maxNrOfCacheObjects: 10,
      //     ),
      //   ), */
      // );
      is_license_pdf=true;
      setState(() {

      });
    }
    ext = "." + profile.data_profile.value['civilid'].split('.').last;
    if(ext==".pdf") {
      license2 = await PDFDocument.fromURL(
        "${profile.data_profile.value['civilid']}",
        /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
      );
      is_license2_pdf=true;
      setState(() {

      });
    }
    ext = "." + profile.data_profile.value['signature'].split('.').last;
    if(ext==".pdf") {

      auth = await PDFDocument.fromURL(
        "${profile.data_profile.value['signature']}",
        /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
      );
      is_auth_pdf=true;
      setState(() {

      });
    }
    setState(() {
      loading=false;
    });
  }
  var selected_cat = [];
  var selected_intrested = [];
  var selected_services = [];
  var selected_appoint = [];
  var selected_delivery = [];
  var _selectedcat=[];
  List dropdowncategoreyList = [
    Category(id:  'men'.tr,name:  'Men',),
    Category(id:'women'.tr,name: 'Women'),
    Category(id:'Kids'.tr,name:'Kids'),

  ];
  List dropdownservicesList = [
    Service(id: 'alteration'.tr, name:'Alteration', ),
    Service(id: 'Stitching'.tr, name: 'New Stitching',),
    Service(id: 'Fabric'.tr, name: 'Fabric',),
    Service(id: 'Readymade_Clothes'.tr, name: 'Readymade Clothes',),
  ];
  List dropdownintrestedList = [
    Intrest(id: 'At_Home'.tr, name: 'At Home'),
    Intrest(id: 'At_Shop'.tr, name: 'At Shop'),
    Intrest(id: 'At_Work'.tr, name: 'At Work'),
    // Intrest(id:  'Logistic Solutions', name: 'Logistics Solution'),
  ];
  List dropdownloacation = [
    Locationlist(id: 'At_Home'.tr, name: 'At Home'),
    Locationlist(id: 'At_Shop'.tr, name: 'At Shop'),
    Locationlist(id: 'At_Work'.tr, name: 'At Work'),
    // Intrest(id:  'Logistic Solutions', name: 'Logistics Solution'),
  ];
  @override
  void initState() {
    loaddata();

    for (var i = 0; i < codes.length; i++) {
      faddress.addListener(() {
        print("focus node");
        if (!faddress.hasFocus) {
          if (address.text.isEmpty) {
            address_valid = "required".tr;
            setState(() {});
            return;
          } else {
            address_valid  = "";
            setState(() {});
            return;
          }
        }
      });  dropdowncounterycode.add({
        'label': '${codes[i]}',
        'value': '${codes[i]}',
        'icon': const SizedBox(
          height: 25,
          width: 25,
          // child: SvgPicture.asset("assets/icons/check.svg"),
        ),
        'selectedIcon': SizedBox(
          key: UniqueKey(),
          width: 20,
          height: 20,
          child: SvgPicture.asset("assets/icons/check.svg"),
        ),
      });
    }
    fname.addListener(() {
      print("focus node");
      if (!fname.hasFocus) {
        if (name.text.isEmpty) {
          name_valid = "required".tr;
          setState(() {});
          return;
        } else {
          name_valid = "";
          setState(() {});
          return;
        }
      }
    });
    flname.addListener(() {
      print("focus node");
      if (!flname.hasFocus) {
        if (lname.text.isEmpty) {
          last_name_valid = "required".tr;
          setState(() {});
          return;
        } else {
          last_name_valid = "";
          setState(() {});
          return;
        }
      }
    });


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


    fnumber.addListener(() {
      print("focus node");
      if (!fnumber.hasFocus) {
        if (number.text.isEmpty) {
          phone_valid = "required".tr;
          setState(() {});
          return;
        } else {
          phone_valid = "";
          setState(() {});
          return;
        }
      }
    });
    fwhatsapp.addListener(() {
      print("focus node");
      if (!fwhatsapp.hasFocus) {
        if (whatsapp.text.isEmpty) {
          whatsapp_valid = "required".tr;
          setState(() {});
          return;
        } else {
          whatsapp_valid = "";
          setState(() {});
          return;
        }
      }
    });
    fpassword.addListener(() {
      print("focus node");
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
        if (retypepass.text!=password.text) {
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
    fper_hour.addListener(() {
      // print("focus node");
      if (!fper_hour.hasFocus) {
        if (per_hour.text.isEmpty) {
          per_hour_valid="required".tr;
          setState(() {});
          return;
        }

        else {
          per_hour_valid= "";
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

                            onTap:(){
                              Get.to(const SiginPage());
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
    var lan=GetStorage();

    return Directionality(
      textDirection:text_direction,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child:const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
            ),
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
            toolbarHeight: 40,
            iconTheme: const IconThemeData(color: iconscolor),
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
                  "manage_shop_profile".tr,
                  style: appbartext,
                ),
              ],
            ),
            // leading: InkWell(
            //   onTap: () {
            //     Get.to(const SettingMain());
            //   },
            //   child:const Icon(
            //     Icons.arrow_back,
            //     color: Colors.black,
            //     size: 25,
            //   ),
            // ),
          ),
        ),
        body:loading?const Center(child:Loader()):

        // Obx(()=> profile.loading_profile.isTrue?Center(child: CircularProgressIndicator(),):


        SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: widthSize*0.15,right: widthSize*0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: heightSize*0.045,),
                  // Shope NAME AND CATEGORY FIELD
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // shope name
                      Container(
                        // width: widthSize*0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("shop_name".tr,style: mtext,),
                            SizedBox(height: heightSize*0.005,),
                            SizedBox(
                              width: widthSize*0.7,
                              height: heightSize*0.080,
                              child: TextFormField(
                                textDirection:text_direction,
                                controller: name,
                                focusNode: fname,
                                style: fieldtext,
                                readOnly: true,
                                decoration:
                                InputDecoration(
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
                                  hintText: "shop_name".tr,
                                  //make hint text
                                  hintStyle: formhinttext,
                                  // //create lable
                                  // labelText: 'Tailor Shope Name',
                                  // //lable style
                                  // labelStyle: formlabelStyle,
                                ),
                              ),
                            ),
                            SizedBox(height: heightSize*0.005,),
                            Text(
                              name_valid == ""
                                  ? " "
                                  : name_valid,
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

                    ],
                  ),
                  SizedBox(height: heightSize*0.015,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // shope name
                      Container(
                        // width: widthSize*0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Accepted_Number".tr,style: mtext,),
                            SizedBox(height: heightSize*0.005,),
                            SizedBox(
                              width: widthSize*0.7,
                              height: heightSize*0.080,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textDirection:text_direction,
                                controller: per_hour,
                                focusNode: fper_hour,
                                style: fieldtext,
                                // readOnly: true,
                                decoration:
                                InputDecoration(
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
                                  hintText: "Accepted_Number".tr,
                                  //make hint text
                                  hintStyle: formhinttext,
                                  // //create lable
                                  // labelText: 'Tailor Shope Name',
                                  // //lable style
                                  // labelStyle: formlabelStyle,
                                ),
                              ),
                            ),
                            SizedBox(height: heightSize*0.005,),
                            Text(
                              per_hour_valid == ""
                                  ? " "
                                  : per_hour_valid,
                              style: TextStyle(
                                fontSize:14,
                                color: per_hour_valid == ""
                                    ? const Color(0xffC1C1C1)
                                    : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: heightSize*0.015,),
                  //shope category  and services
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //select categorey
                      SizedBox(
                        width: widthSize*0.34,
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // lan.read("status")=="Arabic"?Text("تحميل بطاقة الهوية",style: mtext,):  Text("Select Category",style: mtext,),
                            SizedBox(height: heightSize*0.005,),
                            SizedBox(
                              // padding: EdgeInsets.only(right: 10,top: 10),
                              width: widthSize * 0.34,
                              child:
                              MultiSelectChipField(
                                headerColor: buttoncolor,
                                initialValue: profile.data_profile.value['category'],
                                title: Text("select_category".tr,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                // headerColor: Color(0xFFF9F9F9),
                                items: dropdowncategoreyList.map((e) => MultiSelectItem(e.name, e.id)).toList(),
                                decoration: BoxDecoration(
                                  border:Border.all(
                                    color: buttoncolor,
                                    width: 1
                                  )
                                ),
                                selectedChipColor: buttoncolor,
                                selectedTextStyle: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                                icon: const Icon(Icons.check,color: Colors.white,),
                                onTap: (values) {
                                  selected_cat=values;
                                  // print(selected_cat);
                                  // for(int i=0;i<values.length;i++){
                                  //   selected_cat+=values[i]!['name'];
                                  // }
                                  // print(values);
                                  // _selectedcat = values;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      // services tags here
                      SizedBox(
                        width: widthSize*0.34,
                        child:   //select you categorey
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // lan.read("status")=="Arabic"?Text("تحميل بطاقة الهوية",style: mtext,):  Text("Select Service",style: mtext,),
                            SizedBox(height: heightSize*0.005,),
                            SizedBox(
                              // padding: EdgeInsets.only(right: 10,top: 10),
                              width: widthSize * 0.34,
                              child:
                              MultiSelectChipField(
                                headerColor: buttoncolor,
                                initialValue: profile.data_profile.value['service'],
                                title:  Text("select_service".tr,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                items: dropdownservicesList.map((e) => MultiSelectItem(e.name, e.id)).toList(),
                                decoration: BoxDecoration(
                                    border:Border.all(
                                        color: buttoncolor,
                                        width: 1
                                    )
                                ),
                                selectedChipColor: buttoncolor,
                                selectedTextStyle: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                                icon: const Icon(Icons.check,color: Colors.white,),
                                onTap: (values) {
                                  selected_services=values;
                                  // print(selected_cat);
                                  // for(int i=0;i<values.length;i++){
                                  //   selected_cat+=values[i]!['name'];
                                  // }
                                  // print(values);
                                  // _selectedcat = values;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: heightSize*0.025,),
                  //google map address button
                   Text("select_from".tr,style: mtext,),
                  SizedBox(height: heightSize*0.015,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Google map
                      InkWell(
                        onTap: (){
                          Get.to(Customlocation());
                        },
                        child: Container(
                            width: widthSize*0.2,
                            height: heightSize*0.08,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: buttoncolor,
                                    width: 1.5
                                )
                            ),
                            child: Center(
                              child: Text(
                                "Google Map".tr,style: const TextStyle(color: buttoncolor,),
                              ),
                            )
                        ),
                      ),
                      // address display here
                      Obx(
                        ()=> Container(
                            width: widthSize*0.47,
                            height: heightSize*0.08,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1.5
                                )
                            ),
                            child:profile.mapaddrerss.value.isEmpty? Text(
                              "Please_Shop_Address".tr,style: const TextStyle(color:  Colors.grey,),
                            ):Text(
                              "${profile.mapaddrerss.value}",style: const TextStyle(color:  Colors.black,),
                            )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: heightSize*0.025,),
                  //Shope timing
                   Text("Select_Shop_Timings".tr,style: mtext,),
                  SizedBox(height: heightSize*0.025,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(days.length, (index) {
                      // Controller=[];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Checkbox(
                                  value: selected[index],
                                  activeColor: const Color(0XFF0037da),
                                  visualDensity: VisualDensity.compact,
                                  onChanged: (val) {
                                    selected[index] = !selected[index];
                                    Controller[index][0].text="";
                                    Controller[index][1].text="";
                                    // print("slected${selected[index]}");
                                    setState(() {});
                                  },
                                ),
                                const SizedBox(
                                  width: 1,
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    days[index],
                                    style: const TextStyle(
                                        fontSize:  16,
                                        color: Color(0xff535353)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: heightSize*0.08,
                              width:widthSize*0.2,
                              child: InkWell(
                                // style: TextButton.styleFrom(
                                //   backgroundColor: Theme.of(context).colorScheme.secondary,
                                // ),
                                onTap:!selected[index]?null: () {
                                  BottomPicker.time(
                                    // initialDateTime:   Controller[index][0].text!=""?DateTime.parse(Controller[index][0].text):null,
                                    height: heightSize/2,

                                    title:  "Start_Time".tr,
                                    titleStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: buttoncolor
                                    ),
                                    onSubmit: (index_) {
                                      print("date ${index_.toString().split(' ')}");
                                      var a =  DateFormat.jm().format(DateFormat("hh:mm:ss").parse(index_.toString().split(" ")[1]));
                                      print("time cur ${a}");
                                      Controller[index][0].text=a;
                                      // print("Indexx ${index}");
                                    },
                                    // bottomPickerTheme: BOTTOM_PICKER_THEME.orange,
                                    use24hFormat: false,
                                  ).show(context);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: Controller[index][0],
                                    readOnly: true,
                                     decoration: InputDecoration(
                                       hintText: "Start_Time".tr,
                                     ),
                                     // "Start_Time".tr,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),

                              // DateTimePicker(
                              //   enabled:selected[index],
                              //   type: DateTimePickerType.time,
                              //   decoration: InputDecoration(
                              //     hintText: "Start_Time".tr,
                              //     contentPadding: const EdgeInsets.all(10),
                              //     border:  const OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: Color(0xffc1c1c1),
                              //             width: 1)),
                              //   ),
                              //   dateMask: 'hh:mm a',
                              //   fieldLabelText: "Start_Time".tr,
                              //   timeFieldWidth: 300,
                              //   controller: Controller[index][0],
                              //   dateLabelText: 'Date_Time'.tr,
                              //   use24HourFormat: true,
                              //   locale: const Locale('en', 'US'),
                              // ),


                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding:
                              const EdgeInsets.fromLTRB(5, 7, 5, 5),
                              child: const Text(
                                '~',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff535353)),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            SizedBox(
                              height: heightSize*0.08,
                              width:widthSize*0.2,
                              child:InkWell(
                                // style: TextButton.styleFrom(
                                //   backgroundColor: Theme.of(context).colorScheme.secondary,
                                // ),
                                onTap: !selected[index]?null:() {
                                  BottomPicker.time(
                                    // initialDateTime:   Controller[index][1].text!=""?DateTime.parse(Controller[index][1].text):null,
                                    height: heightSize/2,

                                    title:  "Start_Time".tr,
                                    titleStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: buttoncolor
                                    ),
                                    onSubmit: (index_) {
                                      print("date ${index_.toString().split(' ')}");
                                      var a =  DateFormat.jm().format(DateFormat("hh:mm:ss").parse(index_.toString().split(" ")[1]));
                                      print("time cur ${a}");
                                      Controller[index][1].text=a;
                                      // print("Indexx ${index}");
                                    },
                                    // bottomPickerTheme: BOTTOM_PICKER_THEME.orange,
                                    use24hFormat: false,
                                  ).show(context);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: Controller[index][1],
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: "End_Time".tr,
                                    ),
                                    // "Start_Time".tr,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),


                              // DateTimePicker(
                              //   enabled:selected[index],
                              //   type: DateTimePickerType.time,
                              //   decoration: InputDecoration(
                              //     hintText: "End_Time".tr,
                              //     contentPadding: const EdgeInsets.all(10),
                              //     border:  const OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: Color(0xffc1c1c1),
                              //             width: 1)),
                              //   ),
                              //   dateMask: 'hh:mm a',
                              //   controller: Controller[index][1],
                              //   use24HourFormat: true,
                              //   locale: const Locale('en', 'US'),
                              // ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            index == 0
                                ? Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    for(int i=1;i<days.length;i++){
                                      Controller[i][0].text=Controller[0][0].text;
                                      Controller[i][1].text=Controller[0][1].text;
                                      selected[i]=true;
                                      setState(() {

                                      });
                                      // Controller[i][0].text=Controller[0][0].text;
                                    }
                                  } ,
                                  child: Container(
                                      height:heightSize*0.08,
                                      // width: 100,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(2),
                                          border: Border.all(
                                              color: buttoncolor,
                                              width: 1)),
                                      child: Center(
                                          child: Text(
                                              "Copy_For_Each_day".tr,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight
                                                      .w500)))),
                                ),
                              ],
                            )
                                : const SizedBox(),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: heightSize*0.025,),
                  Text("Delivery_and_Appoinment".tr,style: mtext,),
                  SizedBox(height: heightSize*0.015,),
                  //Appointment Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //appointments locations
                      SizedBox(
                        width: widthSize*0.34,
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: widthSize*0.34,
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: heightSize*0.005,),
                                  SizedBox(
                                    // padding: EdgeInsets.only(right: 10,top: 10),
                                    width: widthSize * 0.34,
                                    child:
                                    MultiSelectChipField(
                                      initialValue: profile.data_profile['appoint'],
                                      headerColor: buttoncolor,
                                      title:  Text("appoinment_location".tr,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                      // headerColor: Color(0xFFF9F9F9),

                                      items: dropdownintrestedList.map((e) => MultiSelectItem(e.name, e.id)).toList(),
                                      decoration: BoxDecoration(
                                          border:Border.all(
                                              color: buttoncolor,
                                              width: 1
                                          )
                                      ),
                                      selectedChipColor: buttoncolor,
                                      selectedTextStyle: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                                      icon: const Icon(Icons.check,color: Colors.white,),
                                      onTap: (values) {
                                        selected_appoint=values;
                                        setState(() {

                                        });
                                        // print(selected_cat);
                                        // for(int i=0;i<values.length;i++){
                                        //   selected_cat+=values[i]!['name'];
                                        // }
                                        // print(values);
                                        // _selectedcat = values;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: heightSize*0.025,),
                          ],
                        ),
                      ),
                      // deleveiry location
                      SizedBox(
                        width: widthSize*0.34,
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: widthSize*0.34,
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: heightSize*0.005,),
                                  SizedBox(
                                    // padding: EdgeInsets.only(right: 10,top: 10),
                                    width: widthSize * 0.34,
                                    child:
                                    MultiSelectChipField(
                                      initialValue: profile.data_profile['delivery'],
                                      headerColor: buttoncolor,
                                      title: Text("delivery_location".tr,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                      // headerColor: Color(0xFFF9F9F9),

                                      items: dropdownloacation.map((e) => MultiSelectItem(e.name, e.id)).toList(),
                                      decoration: BoxDecoration(
                                          border:Border.all(
                                              color: buttoncolor,
                                              width: 1
                                          )
                                      ),
                                      selectedChipColor: buttoncolor,
                                      selectedTextStyle: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                                      icon: const Icon(Icons.check,color: Colors.white,),
                                      onTap: (values) {
                                        selected_delivery=values;
                                        // print("sele deliver ${selected_delivery}");
                                        // print(selected_cat);
                                        // for(int i=0;i<values.length;i++){
                                        //   selected_cat+=values[i]!['name'];
                                        // }
                                        // print(values);
                                        // _selectedcat = values;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: heightSize*0.025,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: heightSize*0.025,),
                  Text("shop_address".tr,style: mtext,),
                  SizedBox(height: heightSize*0.015,),
                  // Zip Code/ Building #/ Street #/ Flat #/ House #
                  Directionality(
                    textDirection:text_direction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // lan.read("status")=="Arabic"?Text("تحميل الشعار",style: mtext,):  Text("Zip Code/ Building #/ Street #/ Flat #/ House #",style: mtext,),
                        const SizedBox(height: 3,),
                        Container(
                          // height: heightSize*0.080,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            textDirection: text_direction,
                            controller: address,
                            focusNode: faddress,
                            style: fieldtext,
                            // obscureText: _isVisible ? false : true,
                            decoration:
                            InputDecoration(
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              focusedBorder:
                              OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.black,
                              hintText: "Zip_Code".tr,
                              //make hint text
                              hintStyle: formhinttext,
                              // //create lable
                              // labelText: 'Password',
                              // //lable style
                              // labelStyle: formlabelStyle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          address_valid  == ""
                              ? " "
                              : address_valid  ,
                          style: TextStyle(
                            fontSize:14,
                            color: address_valid   == ""
                                ? const Color(0xffC1C1C1)
                                : Colors.red,
                            fontWeight: FontWeight.w500,

                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize*0.035,),
                  //Submitted button
                  Center(
                    child: InkWell(
                      onTap: () async {
                        showDialog(context: context, builder: (BuildContext context) {
                          return  AlertDialog(
                            content: Container(
                              height:260 ,
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),

                              child: const Center(child: Loader(),),
                            ),
                          );
                        }
                        );
                        var hours=[];
                        for(int i=0;  i<selected.length;i++){
                          if(selected[i]){
                            hours.add({"day":days_c[i],"open":DateFormat("HH:mm").format(DateFormat.jm().parse(Controller[i][0].text)).toString(),"close":DateFormat("HH:mm").format(DateFormat.jm().parse(Controller[i][1].text)),'bool':true});

                          }
                          else{
                            hours.add({"day":days_c[i],"open":"00:00","close":"00:00",'bool':false});
                          }
                        }
                        // print("Hours ${hours}");
                        var a = await profile.update_profile(address.text, hours, selected_cat, selected_services, selected_appoint, selected_delivery,per_hour.text);
                        Navigator.of(context).pop();
                        if(a){
                          showDialog(context: context, builder: (BuildContext context) {
                            return  AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              contentPadding: const EdgeInsets.only(top: 10.0),
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      width: 200,
                                      // height: 60,
                                      margin: const EdgeInsets.only(left: 10,right: 10),
                                      child: Lottie.asset('assets/icons/confirm.json', height: 120)),
                                  const SizedBox(height: 15,),
                                  Center(
                                    child: Container(
                                      width: 200,
                                      padding: const EdgeInsets.only(left: 0,right: 0),
                                      child: Center(
                                          child: Text("Profile_Updated_Successfully".tr,style: popup,textAlign: TextAlign.center,)),),
                                  ),
                                  const SizedBox(height: 15,),
                                  Container(
                                    margin: const EdgeInsets.only(left: 50,right: 50),
                                    child: InkWell(

                                      onTap:(){
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
                                          child:  Text(
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
                            );
                          }
                          );
                        }
                        else{
                          showDialog(context: context, builder: (BuildContext context) {
                            return  AlertDialog(
                              content: Container(
                                height:260 ,
                                width: 400,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),

                                child: Center(child: Column(
                                  children: [
                                     Text("Something_updating".tr),

                                  ],
                                ),),
                              ),
                            );
                          }
                          );
                        }

                      },
                      child: Container(
                        height: heightSize*0.080,
                        width: widthSize*0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: buttoncolor
                        ),
                        child: Center(
                          child:  Text("Update_Shop_Profile".tr,style: buttontext,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heightSize*0.015,),
                  SizedBox(height: heightSize*0.025,),
                  Text("Legal_shop".tr,style: mtext,),
                  SizedBox(height: heightSize*0.015,),
                  Text("Shop_Front/Back".tr,style: mtext,),
                  SizedBox(height: heightSize*0.015,),
                  Container(
                    width: widthSize,
                    // height: heightSize*0.090,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xffDDDDDD),
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color:Colors.white,
                      boxShadow: const [
                        // BoxShadow(
                        //   color: Color(0xFFE8F5FF),
                        //   blurRadius: 1.5,
                        //   spreadRadius: 1.0, //extend the shadow
                        // )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // lan.read("status")=="Arabic"?Text("لم تقم باختيار ملف",style: normal1Style,):Text("Front Side",style: mtext,),
                            // SizedBox(height: 5,),
                            Container(
                              height: heightSize*0.2,
                              width: widthSize*0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(profile.data_profile.value['idcardfront']),fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(15),
                                  color: buttoncolor
                              ),
                              // child: Center(
                              //   child:lan.read("status")=="Arabic"? Text("اختر ملف",style: buttontext,):Text("Choose File",style: buttontext,),
                              // ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // lan.read("status")=="Arabic"?Text("لم تقم باختيار ملف",style: normal1Style,):Text("Back Side",style: mtext,),
                            // SizedBox(height: 5,),
                            Container(
                              height: heightSize*0.2,
                              width: widthSize*0.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(profile.data_profile.value['idcardback']),fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(15),
                                  color: buttoncolor
                              ),
                              // child: Center(
                              //   child:lan.read("status")=="Arabic"? Text("اختر ملف",style: buttontext,):Text("Choose File",style: buttontext,),
                              // ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: heightSize*0.025,),
                  Text("Commercial_Licence".tr,style: mtext,),
                  SizedBox(height: heightSize*0.015,),
                  Container(
                    width: widthSize,
                    // height: heightSize*0.090,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xffDDDDDD),
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color:Colors.white,
                      boxShadow: const [
                        // BoxShadow(
                        //   color: Color(0xFFE8F5FF),
                        //   blurRadius: 1.5,
                        //   spreadRadius: 1.0, //extend the shadow
                        // )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Commercial_Licence1".tr,style: mtext,),
                            const SizedBox(height: 5,),
                            is_license_pdf?  InkWell(
                              onTap: (){
                                Get.to(Pdf_VIew(profile.data_profile.value['license']));
                              },
                              child: Container(
                                height: heightSize*0.2,
                                width: widthSize*0.2,
                                decoration: BoxDecoration(
                                    // image: DecorationImage(image: NetworkImage(profile.data_profile.value['license']),fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(15),
                                    color: buttoncolor
                                ),
                                child: const Center(child: Icon(Icons.picture_as_pdf_sharp,color: Colors.white,size: 40,)),
                              ),
                            ):
                            Container(
                              height: heightSize*0.2,
                              width: widthSize*0.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(profile.data_profile.value['license']),fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(15),
                                  color: buttoncolor
                              ),
                              // child: Center(
                              //   child:lan.read("status")=="Arabic"? Text("اختر ملف",style: buttontext,):Text("Choose File",style: buttontext,),
                              // ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Commercial_Licence2".tr,style: mtext,),
                            const SizedBox(height: 5,),
                            is_license2_pdf?  InkWell(
                              onTap: (){
                                Get.to(Pdf_VIew(profile.data_profile.value['civilid']));
                              },
                              child: Container(
                                height: heightSize*0.2,
                                width: widthSize*0.2,
                                decoration: BoxDecoration(
                                  // image: DecorationImage(image: NetworkImage(profile.data_profile.value['license']),fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(15),
                                    color: buttoncolor
                                ),
                                child: const Center(child: Icon(Icons.picture_as_pdf_sharp,color: Colors.white,size: 40,)),
                              ),
                            ):
                            Container(
                              height: heightSize*0.2,
                              width: widthSize*0.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(profile.data_profile.value['civilid']),fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(15),
                                  color: buttoncolor
                              ),
                              // child: Center(
                              //   child:lan.read("status")=="Arabic"? Text("اختر ملف",style: buttontext,):Text("Choose File",style: buttontext,),
                              // ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: heightSize*0.025,),
                  Text("Point_Of_Sale_Banner".tr,style: mtext,),
                  SizedBox(height: heightSize*0.015,),
                  Container(
                    width: widthSize,
                    height: heightSize*0.25,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xffDDDDDD),
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color:Colors.white,
                      boxShadow: const [
                        // BoxShadow(
                        //   color: Color(0xFFE8F5FF),
                        //   blurRadius: 1.5,
                        //   spreadRadius: 1.0, //extend the shadow
                        // )
                      ],
                    ),
                    child:  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: profile.data_profile.value['banner'].length,
                      itemBuilder: (BuildContext context,int index) {
                        // print("bannerdata${ profile.data_profile.value['banner'].length}");
                        return Container(
                          margin: const EdgeInsets.only(right: 10,left:10),
                          height: heightSize * 0.2,
                          width: widthSize * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(profile.data_profile.value['banner'][index]),fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(15),
                              color: buttoncolor
                          ),
                          // child: Center(
                          //   child: lan.read("status") == "Arabic" ? Text(
                          //     "اختر ملف", style: buttontext,) : Text(
                          //     "Slider Image ${index+1}", style: buttontext,),
                          // ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: heightSize*0.025,),
                  Text("Shop_Signature".tr,style: mtext,),
                  SizedBox(height: heightSize*0.015,),
                  Container(
                    width: widthSize,
                    // height: heightSize*0.090,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xffDDDDDD),
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color:Colors.white,
                      boxShadow: const [
                        // BoxShadow(
                        //   color: Color(0xFFE8F5FF),
                        //   blurRadius: 1.5,
                        //   spreadRadius: 1.0, //extend the shadow
                        // )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Shop_Logo".tr,style: mtext,),
                            const SizedBox(height: 5,),
                            Container(
                              height: heightSize*0.2,
                              width: widthSize*0.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(profile.data_profile.value['logo']),fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(15),
                                  color: buttoncolor
                              ),
                              // child: Center(
                              //   child:lan.read("status")=="Arabic"? Text("اختر ملف",style: buttontext,):Text("Choose File",style: buttontext,),
                              // ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Authorized_Signature".tr,style: mtext,),
                            const SizedBox(height: 5,),
                            is_auth_pdf?  InkWell(
                              onTap: (){
                                Get.to(Pdf_VIew(profile.data_profile.value['signature']));
                              },
                              child: Container(
                                height: heightSize*0.2,
                                width: widthSize*0.2,
                                decoration: BoxDecoration(
                                  // image: DecorationImage(image: NetworkImage(profile.data_profile.value['license']),fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(15),
                                    color: buttoncolor
                                ),
                                child: const Center(child: Icon(Icons.picture_as_pdf_sharp,color: Colors.white,size: 40,)),
                              ),
                            ):
                            Container(
                              height: heightSize*0.2,
                              width: widthSize*0.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(profile.data_profile.value['signature']),fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(15),
                                  color: buttoncolor
                              ),
                              // child: Center(
                              //   child:lan.read("status")=="Arabic"? Text("اختر ملف",style: buttontext,):Text("Choose File",style: buttontext,),
                              // ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),

                  SizedBox(height: heightSize*0.035,),
                ],
              ),
            ),
          ),
        // ),
      ),
    );
  }
}
class Intrest {
  final String id;
  final String name;

  Intrest({
    required this.id,
    required this.name,
  });
}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });
}

class Service {
  final String id;
  final String name;

  Service({
    required this.id,
    required this.name,
  });
}
class Locationlist {
  final String id;
  final String name;

  Locationlist({
    required this.id,
    required this.name,
  });
}