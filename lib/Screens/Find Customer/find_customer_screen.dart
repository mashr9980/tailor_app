import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/Screens/Measurement%20Screens/customer_measurement.dart';
import 'package:tailorapp/Screens/Settings%20Screen/setting_main.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/drawer.dart';
class FindCustomer extends StatefulWidget {
  const FindCustomer({Key? key}) : super(key: key);

  @override
  FindCustomerState createState() => FindCustomerState();
}

class FindCustomerState extends State<FindCustomer> {
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
          entery_valid = "required".tr;
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
  openAlertBox() {
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: widthSize*0.02),
                            child: Image.asset("assets/icons/cross.png",height: 30,)),
                      ),
                    ),
                    SizedBox(height: 10,),
                    // data shown here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // labels data
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // name profile image number
                            Container(
                              margin: EdgeInsets.only(left: widthSize*0.01,right: widthSize*0.01,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height:heightSize*0.10,
                                    width: widthSize*0.060,
                                    decoration: BoxDecoration(
                                      color: Color(0XFFC1C1C1),
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: buttoncolor.withOpacity(0.3),
                                          blurRadius: 2.0,
                                          // offset: Offset(0.0, 0.75)
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: widthSize*0.01,),
                                  Container(
                                    width: widthSize*0.25,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: heightSize*0.010,),
                                        lan.read("status")=="Arabic"?Text("هاشم احمد",style: normalStyle,):Text("Hasham Ahmad",style: normalStyle,),
                                        SizedBox(height: heightSize*0.005,),
                                        Text("03069009838",style: normal1Style,),
                                      ],
                                    ),

                                  ),
                                  Container(
                                    width: widthSize*0.25,
                                    child: Row(
                                      children: [
                                        Image.asset("assets/icons/whats.png"),
                                        SizedBox(width: 5,),
                                        Text("03069009838",style: normal1Style,),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: heightSize*0.035,),
                            // Total number of order
                            Container(
                              margin: EdgeInsets.only(left: widthSize*0.03,right: widthSize*0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child: Text("Total Order",style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  Container(
                                    width: widthSize*0.25,
                                    child: lan.read("status")=="Arabic"?Text("5",style: normalStyle,):Text("5",style: normalStyle,),

                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: heightSize*0.025,),
                            // Due Balance
                            Container(
                              margin: EdgeInsets.only(left: widthSize*0.03,right: widthSize*0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child: Text("Due Balance",style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  Container(
                                    width: widthSize*0.25,
                                    child: lan.read("status")=="Arabic"?Text("5",style: normalStyle,):Text("5",style: normalStyle,),

                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: heightSize*0.025,),
                            // Last Order Date
                            Container(
                              margin: EdgeInsets.only(left: widthSize*0.03,right: widthSize*0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child: Text("Last Order Date",style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  Container(
                                    width: widthSize*0.25,
                                    child: lan.read("status")=="Arabic"?Text("5",style: normalStyle,):Text("5",style: normalStyle,),

                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: heightSize*0.025,),
                            // Last Address
                            Container(
                              margin: EdgeInsets.only(left: widthSize*0.03,right: widthSize*0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child: Text("Address",style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  Container(
                                    width: widthSize*0.25,
                                    child: lan.read("status")=="Arabic"?Text("5",style: normalStyle,):Text("5",style: normalStyle,),

                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: heightSize*0.025,),
                            // Last Work Adress
                            Container(
                              margin: EdgeInsets.only(left: widthSize*0.03,right: widthSize*0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child: Text("Work Address",style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  Container(
                                    width: widthSize*0.25,
                                    child: lan.read("status")=="Arabic"?Text("Google location",style: normalStyle,):Text("Google location",style: normalStyle,),

                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: heightSize*0.025,),
                            // Last Google Map logo
                            Container(
                              margin: EdgeInsets.only(left: widthSize*0.03,right: widthSize*0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child: Text("Google Map Home",style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  Container(
                                    width: widthSize*0.25,
                                    child: lan.read("status")=="Arabic"?Text("Google location",style: normalStyle,):Text("Google location",style: normalStyle,),

                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: heightSize*0.025,),
                            // Last Google Map work
                            Container(
                              margin: EdgeInsets.only(left: widthSize*0.03,right: widthSize*0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child: Text("Google Map work",style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  Container(
                                    width: widthSize*0.25,
                                    child: lan.read("status")=="Arabic"?Text("Google location",style: normalStyle,):Text("Google location",style: normalStyle,),

                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                        // buttons screen
                        Column(
                          children: [
                            //measurement
                            InkWell(
                              onTap: (){
                                Get.to(CustomerMeasurement());
                              },
                              child: Container(
                                margin: EdgeInsets.only(top:heightSize*0.12,right: widthSize*0.1),
                                height: heightSize*0.08,
                                width: widthSize*0.1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: buttoncolor,
                                        width: 1
                                    )
                                ),
                                child:const Center(
                                  child: Text("Measurement",style: regularbuttontext,),
                                ),
                              ),
                            ),
                            SizedBox(height: heightSize*0.025,),
                            //Appointment
                            Container(
                              margin: EdgeInsets.only(right: widthSize*0.1,left:  widthSize*0.1),
                              height: heightSize*0.08,
                              width: widthSize*0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: buttoncolor,
                                      width: 1
                                  )
                              ),
                              child:const Center(
                                child: Text("Appointment",style: regularbuttontext,),
                              ),
                            ),
                            SizedBox(height: heightSize*0.025,),
                            //Order
                            Container(
                              margin: EdgeInsets.only(right: widthSize*0.1,left:widthSize*0.1),
                              height: heightSize*0.08,
                              width: widthSize*0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: buttoncolor,
                                      width: 1
                                  )
                              ),
                              child:const Center(
                                child: Text("Order",style: regularbuttontext,),
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    // //ok Google Map logo
                    // Container(
                    //   margin: EdgeInsets.only(left: 50,right: 50),
                    //   child: InkWell(
                    //
                    //     // onTap:(){
                    //     //   Get.to(SiginPage());
                    //     // },
                    //     child: Container(
                    //       width:  60,
                    //       height: 40,
                    //       decoration: BoxDecoration(
                    //         color: buttoncolor,
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: Center(
                    //         child:lan.read("status")=="Arabic"? Text(
                    //           "موافق",
                    //           style: TextStyle(color: Colors.white,fontSize: 14),
                    //           textAlign: TextAlign.center,
                    //         ): Text(
                    //           "Ok",
                    //           style: TextStyle(color: Colors.white,fontSize: 14),
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 15,),

                  ],
                ),
              )
          );
        });
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
            title:lan.read("status")=="Arabic"?Text("رأي الزبون",style: appbartext): Text("Find Customer",style: appbartext,),
            actions: [
              Container(
                  padding: EdgeInsets.all(5),
                  height: 35,
                  child: Image.asset(
                    logo_png,
                    height: 20,
                  )),

              GestureDetector(
                onTap: () {
                  Get.to(const SettingMain());
                },
                child: Icon(Icons.settings,size: 35,color: buttontextcolor.withOpacity(0.6),),
              ),
              GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.notification_important,color: buttontextcolor.withOpacity(0.6),size: 35,)
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  logo_whatsapp,
                  height: 60,
                ),
              ),
              GestureDetector(
                onTap: () {
                  LogoutBox();
                },
                child: Image.asset(
                  icon_logout,
                  height: 60,
                ),
              ),
            ],
            centerTitle: false,
            toolbarHeight: 45,
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
        body:SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              //mobile field
              Center(
                child: Container(
                  width: widthSize * 0.7,
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
                                      color: Color(0XFFC1C1C1),
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
                              SizedBox(height: 5,),
                              Container(
                                width: widthSize * 0.1,
                                child: Text(
                                  entery_valid == ""
                                      ? " "
                                      : entery_valid,
                                  style: TextStyle(
                                    fontSize:14,
                                    color: entery_valid == ""
                                        ? Color(0xffC1C1C1)
                                        : Colors.red,
                                    fontWeight: FontWeight.w500,

                                  ),
                                ),
                              )
                            ],
                          ),
                          // mobile number
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: widthSize * 0.447,
                                height: heightSize*0.080,
                                child: TextFormField(
                                  textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                                  controller: entery,
                                  focusNode: fentery,
                                  style: fieldtext,
                                  decoration:lan.read("status")=="Arabic"? InputDecoration(
                                    focusColor: Colors.white,
                                    //add prefix icon
                                    suffix: Container(
                                      height: 20,
                                      width: 20,
                                      margin:lan.read("status")=="Arabic"?EdgeInsets.only(left: 10,top: 20,right: 10): EdgeInsets.only(left: 10,top: 20,right:10),
                                      child: FaIcon(
                                        FontAwesomeIcons.search,
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
                                    suffix: Container(
                                      height: 20,
                                      width: 20,
                                      margin: EdgeInsets.only(right: 10,left: 10),
                                      child: FaIcon(
                                        FontAwesomeIcons.search,
                                        color: buttoncolor,
                                        size: 20,
                                      ),
                                    ),
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
                                    hintText: "Enter Your Number",
                                    //make hint text
                                    hintStyle: formhinttext,
                                    //create lable
                                    labelText: 'Mobile Number',
                                    //lable style
                                    labelStyle: formlabelStyle,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                entery_valid== ""
                                    ? " "
                                    : entery_valid,
                                style: TextStyle(
                                  fontSize:14,
                                  color: entery_valid == ""
                                      ? Color(0xffC1C1C1)
                                      : Colors.red,
                                  fontWeight: FontWeight.w500,

                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          showDialog(context: context, builder: (BuildContext context) {
                            return  AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                              content:lan.read("status")=="Arabic"?
                              //arabic
                              Directionality(
                                textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                                child: Container(
                                  height:320 ,
                                  width: 400,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)
                                  ),

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 20,),
                                      // lan.read("status")=="Arabic"?const Text("صنف حسب",
                                      //     style: popup):const Text("Sort By",
                                      //     style: popup),
                                      SizedBox(height: heightSize*0.015,),
                                      Divider(
                                        color: Color(0XFFC1C1C1),
                                        thickness: 1,

                                      ),
                                      CheckboxListTile(
                                        checkColor: Colors.white,
                                        activeColor: Colors.black,

                                        contentPadding: EdgeInsets.only(left: 20,right: 20),
                                        title:lan.read("status")=="Arabic"?Text("بالأوامر",style: normalStyle,)
                                            :Text("Order",style: normalStyle,),
                                        value: checkedValue,
                                        onChanged: (newValue) {
                                          setState(() {
                                            checkedValue = newValue!;
                                          });
                                        },
                                        controlAffinity: ListTileControlAffinity.trailing,  //  <-- leading Checkbox
                                      ),
                                      SizedBox(height: heightSize*0.015,),
                                      const Divider(
                                        color: Color(0XFFC1C1C1),
                                        thickness: 1,

                                      ),
                                      CheckboxListTile(
                                        checkColor: Colors.white,
                                        activeColor: Colors.black,

                                        contentPadding: EdgeInsets.only(left: 20,right: 20),
                                        title:lan.read("status")=="Arabic"?Text("من خلال الرصيد المتبقي",style:
                                        normalStyle,): Text("Remaining Balance",style:
                                        normalStyle,),
                                        value: checkedValue,
                                        onChanged: (newValue) {
                                          setState(() {
                                            checkedValue = newValue!;
                                          });
                                        },
                                        controlAffinity: ListTileControlAffinity.trailing,  //  <-- leading Checkbox
                                      ),
                                      const Divider(
                                        color: Color(0XFFC1C1C1),
                                        thickness: 1,

                                      ),
                                      SizedBox(height: heightSize*0.015,),
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
                                              child:lan.read("status")=="Arabic"?Text("موافق",style: buttontext,): Text("Ok",style: buttontext,),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ):
                              Container(
                                height:320 ,
                                width: 400,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)
                                ),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 20,),
                                    lan.read("status")=="Arabic"? Text("صنف حسب",style: boldregulartext,):
                                    Text("Sort By",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: buttoncolor),),
                                    SizedBox(height: 20,),
                                    const Divider(
                                      color: Color(0XFFC1C1C1),
                                      thickness: 1,

                                    ),
                                    CheckboxListTile(
                                      checkColor: Colors.white,
                                      activeColor: Colors.black,

                                      contentPadding: EdgeInsets.only(left: 20,right: 20),
                                      title:const Text("Order",style:
                                      TextStyle(
                                        color:Colors.black,
                                        fontWeight: FontWeight.w500,fontSize: 22,
                                        fontFamily: "Poppins",),),
                                      value: checkedValue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkedValue = newValue!;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity.trailing,  //  <-- leading Checkbox
                                    ),
                                    SizedBox(height: 20,),
                                    const Divider(
                                      color: Color(0XFFC1C1C1),
                                      thickness: 1,

                                    ),
                                    CheckboxListTile(
                                      checkColor: Colors.white,
                                      activeColor: Colors.black,

                                      contentPadding: EdgeInsets.only(left: 20,right: 20),
                                      title:const Text("Remaining Balance",style:
                                      TextStyle(
                                        color:Colors.black,
                                        fontWeight: FontWeight.w500,fontSize: 22,
                                        fontFamily: "Poppins",),),
                                      value: checkedValue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkedValue = newValue!;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity.trailing,  //  <-- leading Checkbox
                                    ),
                                    const  Divider(
                                      color: Color(0XFFC1C1C1),
                                      thickness: 1,

                                    ),
                                    SizedBox(height: heightSize*0.015,),
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
                                            child: Text("Ok",style: buttontext,),
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
                        },
                        child: Container(
                          height: heightSize*0.080,
                          width:60 ,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              lan.read("status")=="Arabic"?Text("فرز",style: TextStyle(color: buttoncolor,fontSize: widthSize*0.016,fontWeight: FontWeight.bold),):Text("Sort",style: TextStyle(color: buttoncolor,fontSize: widthSize*0.016,fontWeight: FontWeight.bold),),
                              Image.asset("assets/icons/filter.png",height: heightSize*0.030,)

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(left: widthSize*0.13,right: widthSize*0.13),
                    height: heightSize*0.8,
                    child: GridView.builder(
                        padding: EdgeInsets.only(bottom: 100,top: 20),
                        scrollDirection: Axis.vertical,
                        // physics: NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 600,
                            childAspectRatio: 8 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: 16,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: (){

                              openAlertBox();
                              // Get.to(Customer_detail());
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10,right: 10),
                              width: widthSize*0.2,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: buttoncolor.withOpacity(0.5),
                                      blurRadius: 3.0,
                                      offset: Offset(0.0, 0.75)
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height:heightSize*0.10,
                                    width: widthSize*0.060,
                                    decoration: BoxDecoration(
                                      color: Color(0XFFC1C1C1),
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: buttoncolor.withOpacity(0.3),
                                          blurRadius: 2.0,
                                          // offset: Offset(0.0, 0.75)
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: widthSize*0.25,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: heightSize*0.010,),
                                        lan.read("status")=="Arabic"?Text("هاشم احمد",style: normalStyle,):Text("Hasham Ahmad",style: normalStyle,),
                                        SizedBox(height: heightSize*0.005,),
                                        Text("03069009838",style: normal1Style,),
                                        lan.read("status")=="Arabic"?Text("الرصيد المستحق 2500 روبية",style: normal2Style,):Text("Due Balance 2500 Rs",style: normal2Style,),
                                      ],
                                    ),

                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
