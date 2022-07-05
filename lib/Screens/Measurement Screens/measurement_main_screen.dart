import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/Screens/DashBoard_Screens/home_page.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/measurements.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/drawer.dart';
import 'package:tailorapp/utils/loader.dart';

import 'customer_measurement.dart';
class MainMeasurement extends StatefulWidget {

  const MainMeasurement({Key? key}) : super(key: key);

  @override
  MainMeasurementState createState() => MainMeasurementState();
}

class MainMeasurementState extends State<MainMeasurement> {
  var measure =Get.put(MeasurementsController());
  var lan=GetStorage();
  TextEditingController entery = TextEditingController();
  final FocusNode fentery = FocusNode();
  List dropdowncounterycode = [];
  List<String> codes = [
    '+971',
    '+920',
    '+921',
    '+923',
  ];
  var entery_valid = "";
  var code;
  bool checkedValue=false;
  void initState() {
    measure.get_measurement_my();
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
          entery_valid = lan.read("status")=="Arabic"?"مطلوب هذا الحقل":"Required*";
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
  void _openCustomDialog() {
    showGeneralDialog(barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                titleTextStyle:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: buttoncolor,),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: lan.read("status")=="Arabic"? const Center(child: Text("صنف حسب")):
                const Center(child: Text("Sort By")),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(height: 10,),
                    // lan.read("status")=="Arabic"? Text("صنف حسب",style: boldregulartext,):
                    // Text("Sort By",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: buttoncolor),),
                    const SizedBox(height: 5,),
                    const Divider(
                      color: Color(0XFFC1C1C1),
                      thickness: 1,

                    ),
                    RadioListTile(
                      // checkColor: Colors.white,
                      activeColor: Colors.black,
                      value: 1,
                      groupValue: val,
                      contentPadding: const EdgeInsets.only(left: 10,right: 10),
                      title:const Text("High to low Order ",style:
                      TextStyle(
                        color:Colors.black,
                        fontWeight: FontWeight.w500,fontSize: 16,
                        fontFamily: "Poppins",),),
                      // value: checkedValue,
                      onChanged: (value) {
                        setState(() {
                          // val = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing,  //  <-- leading Checkbox
                    ),
                    const SizedBox(height: 5,),
                    const Divider(
                      color: Color(0XFFC1C1C1),
                      thickness: 1,

                    ),
                    RadioListTile(
                      // checkColor: Colors.white,
                      activeColor: Colors.black,
                      value: 1,
                      groupValue: val,
                      contentPadding: const EdgeInsets.only(left: 10,right: 10),
                      title:const Text("Remaining Balance ",style:
                      TextStyle(
                        color:Colors.black,
                        fontWeight: FontWeight.w500,fontSize: 16,
                        fontFamily: "Poppins",),),
                      // value: checkedValue,
                      onChanged: (value) {
                        setState(() {
                          // val = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing,  //  <-- leading Checkbox
                    ),
                    const  Divider(
                      color: Color(0XFFC1C1C1),
                      thickness: 1,

                    ),
                    const SizedBox(height:5,),
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
                          child: const Center(
                            child: const Text("Ok",style: buttontext,),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
      return const SizedBox();
        });
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
                    const Text("Logout",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                    const Text("Are You Sure",style: TextStyle(color: Colors.black,fontSize: 16,),textAlign: TextAlign.center,),
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
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: bgcolor,
        drawer: const Drawer(
          child: Drawertrail(),
        ),
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
                Text("measurement".tr,style: appbartext,),
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
            // automaticallyImplyLeading: false,
            backgroundColor: APPBARCOLOR,
            // leading: InkWell(
            //   onTap: () {
            //     Get.back();
            //   },
            //   child: const Icon(
            //     Icons.arrow_back,
            //     color: Colors.black,
            //     size: 25,
            //   ),
            // ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: heightSize*0.03,),
              Center(
                child: Container(
                  width: widthSize * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // contery code
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: widthSize * 0.15,
                                height: heightSize*0.080,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0XFFC1C1C1),
                                      width: 1
                                  ),
                                ),
                                child: Center(
                                  child: Directionality(
                                    textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                                    child: CoolDropdown(
                                      dropdownWidth: widthSize * 0.1,
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
                                      resultWidth: widthSize * 0.17,
                                      dropdownList: dropdowncounterycode,
                                      defaultValue: null,
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
                                          color: const Color(0xff0037da),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                      resultTS:const TextStyle(
                                          fontSize:  14,
                                          color:  Color(0xff8a8a8a),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                      unselectedItemTS:const TextStyle(
                                          fontSize:  15,
                                          color: const Color(0xff212121),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                      onChange: (a) {
                                        setState(() {
                                          code=a["label"];
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
                              const SizedBox(height: 5,),
                              entery_valid== "" || entery_valid=="null"?const SizedBox():
                              Text(entery_valid,
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
                          // mobile number
                          const SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: widthSize * 0.45,
                                height: heightSize*0.080,
                                child: TextFormField(
                                  textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                                  controller: entery,
                                  focusNode: fentery,
                                  style: fieldtext,
                                  decoration:lan.read("status")=="Arabic"? InputDecoration(
                                    focusColor: Colors.white,
                                    suffixIcon: const Icon(Icons.search,size: 40,color: buttoncolor,),
                                    // //add prefix icon
                                    // suffix: Container(
                                    //   height: 20,
                                    //   width: 20,
                                    //   margin:lan.read("status")=="Arabic"?EdgeInsets.only(left: 10,top: 20,): EdgeInsets.only(left: 10,top: 20,),
                                    //   child: FaIcon(
                                    //     FontAwesomeIcons.search,
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
                                    hintText: "أدخل رقمك",
                                    //make hint text
                                    hintStyle: formhinttext,
                                    hintTextDirection: TextDirection.rtl,
                                    //create lable
                                    labelText: 'رقم الهاتف المحمول',
                                    //lable style
                                    labelStyle: formlabelStyle,

                                  ):
                                  InputDecoration(

                                    focusColor: Colors.white,
                                    //add prefix icon
                                    suffixIcon: const Icon(Icons.search,size: 40,color: buttoncolor,),
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
                                    hintText: "Enter Customer Mobile #",
                                    //make hint text
                                    hintStyle: formhinttext,
                                    //create lable
                                    labelText: 'Customer Mobile #',
                                    //lable style
                                    labelStyle: formlabelStyle,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              entery_valid== "" || entery_valid=="null"?const SizedBox():
                              Text(entery_valid,
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
                        ],
                      ),
                      InkWell(
                        // onTap: (){
                        //   _openCustomDialog();
                        // },
                        child: Container(
                          height: heightSize*0.080,
                          width:widthSize*0.15 ,
                          decoration: BoxDecoration(
                            color: buttoncolor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          // color: Colors.red,
                          child: lan.read("status")=="Arabic"?Center(child: Text("فرز",style: TextStyle(color: buttoncolor,fontSize: widthSize*0.016,fontWeight: FontWeight.bold),)):
                          const Center(child: Text("New Measuremnet+",style:buttontext)),

                        ),
                      )
                    ],
                  ),
                ),
              ),
              //list view builder
              Container(
                height: heightSize*0.72,
                width: widthSize*0.65,
                margin: EdgeInsets.only(left: widthSize*0.15,right: widthSize*0.15,),
                child: Obx(
                      ()=>  measure.loading.isTrue?const Center(child:Loader()): measure.data_my.length==0?const Center(child:const Text("No Customers/Measurements found that belongs to your shop",style: buttontext1,)):
                      RefreshIndicator(
                        onRefresh:  measure.get_measurement_my,
                        child: ListView.builder(
                        physics:  const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10,bottom: 20),
                        itemCount: measure.data_my.length,
                        itemBuilder: (BuildContext context,int index){
                          return InkWell(
                            onTap: (){
                              measure.set_customer(index);
                              Get.to(const CustomerMeasurement());
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 15),

                                height: heightSize*0.14,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    // profile image
                                    Container(
                                      height:heightSize*0.10,
                                      width: widthSize*0.060,
                                      margin: const EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                        boxShadow:  [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 0.5,
                                            spreadRadius: 1.0,
                                            offset: const Offset(2.0,2.5,),//extend the shadow
                                          )
                                        ],
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage("${measure.data_my.value[index]['image']}")),
                                        color: const Color(0XFFC1C1C1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    // customer name header
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10,),
                                        Text("${measure.data_my.value[index]['name']}",style: boldtext,),
                                        const SizedBox(height: 5,),
                                        Text("${measure.data_my.value[index]['phone']}",style: mediumsubheadingtext,),
                                      ],
                                    ),
                                    //dress type
                                    Container(
                                      margin: const EdgeInsets.only(left: 50),
                                      height: heightSize*0.08,
                                      padding: const EdgeInsets.all(10),
                                      // width: widthSize*0.15,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFC1C1C1).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(
                                        child:lan.read("status")=="Arabic"? const Text("قميص",style: boldregulartext,):Text("Total Measurements : ${measure.data_my.value[index]['total_measure']}",style: boldregular1text,),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          );

                        }
                  ),
                      ),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
