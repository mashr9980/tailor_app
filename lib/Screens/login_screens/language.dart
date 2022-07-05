import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/country.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:geolocator/geolocator.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  var local = LocalizationService();
  // var lan=GetStorage();
  var rem=GetStorage("logindata");
  var obj = Get.put(CountryController());
  List dropdowncounteryList = [];
  // List dropdownlanguageList = [];
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
  List<String> language = [
    'Arabic',
    'English',
  ];
  var lanslect="";
  var consel="";
  bool check=false;
  bool check1=false;
  void set_country(){
    for (var i = 0; i < obj.data.length; i++) {
      dropdowncounteryList.add({
        'label': '${obj.data.value[i]['country']}',
        'value': i,
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
  }
  @override
  void initState() {
    set_country();
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
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(40.0),
        //   child: AppBar(
        //     toolbarHeight: 40,
        //     automaticallyImplyLeading: false,
        //     backgroundColor: APPBARCOLOR,
        //     centerTitle: false,
        //     title: Container(
        //       padding: EdgeInsets.only(left: widthSize*0.05),
        //         child: Image.asset(logo_png,height: 90,)),
        //   ),
        // ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only (left: widthSize*0.2, right:widthSize* 0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: heightSize*0.08,),
                Center(
                  child: Image.asset(logo_png,height: 120),
                ),
                SizedBox(height: heightSize*0.08,),
                SizedBox(
                    // padding: EdgeInsets.only(right: 10,top: 10),
                    width: widthSize * 0.55,
                    // height: heightSize*0.05,
                    child: Text("select_lang".tr,textDirection: text_direction, style: formlabelStyle,)),
                const SizedBox(height: 10),
                Center(
                  child: Directionality(
                    textDirection: text_direction,
                    child: Container(
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
                        placeholder:"Select".tr,
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
                          // selected_hospital = a;
                          setState(() {
                            lanslect=a["value"];
                            rem.write('status', a["value"]);
                            check=false;
                            local.changeLocale(a["value"]);
                          });
                          // print("lanslected${lanslect}");
                          // print("slected${lan.read('status')}");
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
                  ),
                ),
                const SizedBox(height: 30,),
                SizedBox(
                    // padding: EdgeInsets.only(right: 10,top: 10),
                    width: widthSize * 0.55,
                    // height: heightSize*0.05,
                    child: Text("select_cont".tr,textDirection: text_direction, style: formlabelStyle,)),
                const SizedBox(height: 10),
                Center(
                  child: Directionality(
                    textDirection: text_direction,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20,right: 20),
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
                      // color: Colors.red,
                      height: heightSize*0.080,
                      child: CoolDropdown(
                        dropdownWidth: widthSize * 0.5,
                        dropdownAlign: 'center',
                        dropdownHeight: 150,
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
                        dropdownPadding: const EdgeInsets.all(0),

                        resultWidth: widthSize * 0.55,
                        dropdownList: dropdowncounteryList,
                        defaultValue: null,
                        isResultLabel: true,
                        gap: 10,
                        placeholder: "Select".tr,
                        dropdownItemPadding: const EdgeInsets.only(left: 20,right: 20),
                        selectedItemPadding: const EdgeInsets.only(left: 200,right: 200),


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
                        // resultDirection:
                        resultTS:const TextStyle(
                            fontSize:  16,
                            color:  Color(0xff8a8a8a),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins"),
                        unselectedItemTS:const TextStyle(
                            fontSize:  15,
                            color: Color(0xff212121),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins"),
                        onChange: (b) {
                          setState(() {
                            obj.set_country(b['value']);
                            rem.write("country",b['value']);
                            consel=b["label"];
                            // print("slelectedabcd${rem.read("country")}");
                            check1=false;
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
                  ),
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //
                //     // check1?  Container(
                //     //     padding: EdgeInsets.only(right: 10,top: 10),
                //     //     width: widthSize * 0.55,
                //     //     // height: heightSize*0.05,
                //     //     child:const Text("Please select Your Country",style: TextStyle( color: Colors.red,fontSize: 16))):SizedBox()
                //   ],
                // ),

                const SizedBox(height: 30,),
                Center(
                  child: InkWell(
                    onTap: lanslect!=""  && consel!=""? () async {
                      var permission = await Geolocator.requestPermission();
                      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always ) {
                        // Permissions are denied, next time you could try
                        // requesting permissions again (this is also where
                        // Android's shouldShowRequestPermissionRationale
                        // returned true. According to Android guidelines
                        // your App should show an explanatory UI now.
                        Get.to(const SiginPage());
                        // Get.to(HomePage());

                        // return Future.error('Location permissions are denied');
                      }
                      else{
                        showDialog(context: context, builder: (BuildContext context) {
                          return  AlertDialog(
                            content:
                            Directionality(
                              textDirection: text_direction,
                              child: Container(
                                height:260 ,
                                width: 400,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 20,),
                                    Image.asset("assets/images/bell.png",height: 50,),
                                    const SizedBox(height: 30,),
                                    Text("permission_deny".tr,style: popup,),
                                    const SizedBox(height: 20,),
                                    Text("permission_deny_message".tr,style: popup,textAlign: TextAlign.center,),
                                    const SizedBox(height: 30,),
                                    Center(
                                      child: InkWell(
                                        onTap: (){
                                          // Get.to(ShopDetail());
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: buttoncolor,
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Center(
                                            child: Text("ok".tr,style: buttontext,),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        );
                      }


                    }:(){
                      setState(() {
                        check=true;
                        check1=true;

                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: lanslect==""  || consel==""?buttoncolor.withOpacity(0.3) :buttoncolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: widthSize*0.435,
                      height: heightSize*0.080,
                      child: Center(
                        child: Text("next".tr,style: buttontext,),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: heightSize*0.40,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
