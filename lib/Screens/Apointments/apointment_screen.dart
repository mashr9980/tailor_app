import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/Screens/Apointments/reschducle_appoinment_screen.dart';
import 'package:tailorapp/Screens/DashBoard_Screens/home_page.dart';
import 'package:tailorapp/Screens/Measurement%20Screens/customer_measurement.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/drawer.dart';

import 'new_appointment_screen.dart';
class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  AppointmentsScreenState createState() => AppointmentsScreenState();
}

class AppointmentsScreenState extends State<AppointmentsScreen> {
  var lan=GetStorage();
  TextEditingController entery = TextEditingController();
  final FocusNode fentery = FocusNode();
  List dropdownstatus = [];
  List dropdowncounterycode = [];
  List<String> status = [
    'Pending',
    'Completed',
    'Delivered',
  ];
  List<String> codes = [
    '+971',
    '+920',
    '+921',
    '+923',
  ];
  var entery_valid = "";
  var code;
  bool checkedValue=false;
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
                                  style: TextStyle(color: Colors.red,fontSize: 14),
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
                                  style: TextStyle(color: Colors.white,fontSize: 14),
                                  textAlign: TextAlign.center,
                                ): const Text(
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

                    const SizedBox(height: 15,),

                  ],
                ),
              )
          );
        });
  }
  void initState() {
    for (var i = 0; i < status.length; i++) {
      dropdownstatus.add({
        'label': '${status[i]}',
        'value': '${status[i]}',
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
          entery_valid = lan.read("status")=="Arabic"?"مطلوب ":"Required ";
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
  FilterBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return StatefulBuilder(
              builder: (context,mapset){
                return  AlertDialog(

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
                      const SizedBox(height: 5,),
                      const Divider(
                        color: Color(0XFFC1C1C1),
                        thickness: 1,

                      ),
                      //filter by today
                      RadioListTile(
                        // checkColor: Colors.white,
                        activeColor: Colors.black,
                        value: 1,
                        groupValue: val,
                        contentPadding: const EdgeInsets.only(left: 10,right: 10),
                        title:CoolDropdown(
                          dropdownHeight: 150,
                          dropdownWidth:widthSize * 0.3,
                          resultBD: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          isTriangle: false,
                          dropdownBD: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          isResultIconLabel: true,
                          resultWidth: widthSize * 0.35,
                          dropdownList: dropdownstatus,
                          defaultValue: null,
                          isResultLabel: true,
                          gap: 10,
                          placeholder:"Today",
                          dropdownItemPadding: const EdgeInsets.only(left: 20,right: 20),
                          selectedItemPadding: const EdgeInsets.only(left: 20,right: 20),
                          placeholderTS:const TextStyle(
                            color: Color(0XFFC1C1C1),
                          ),
                          selectedItemBD: BoxDecoration(
                            // color: const Color(0xffE8F5FF),
                            borderRadius: BorderRadius.circular(5),

                          ),
                          selectedItemTS: const TextStyle(
                              fontSize: 14,
                              color: buttoncolor,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                          resultTS:const TextStyle(
                              fontSize:  14,
                              color:  buttoncolor,
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
                        // value: checkedValue,
                        onChanged: (value) {
                          // val=1;
                          // customer.set_sort("order");
                          // mapset((){});
                          // setState(() {
                          //   // val = value;
                          // });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      const SizedBox(height: 5,),
                      const Divider(
                        color: Color(0XFFC1C1C1),
                        thickness: 1,

                      ),
                      // Remaning balanace
                      RadioListTile(
                        // checkColor: Colors.white,
                        activeColor: Colors.black,
                        value: 2,
                        groupValue: val,
                        contentPadding: const EdgeInsets.only(left: 10,right: 10),
                        title: CoolDropdown(
                          dropdownHeight: 150,
                          dropdownWidth:widthSize * 0.3,
                          resultBD: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          isTriangle: false,
                          dropdownBD: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          isResultIconLabel: true,
                          resultWidth: widthSize * 0.35,
                          dropdownList: dropdownstatus,
                          defaultValue: null,
                          isResultLabel: true,
                          gap: 10,
                          placeholder:"Completed",
                          dropdownItemPadding: const EdgeInsets.only(left: 20,right: 20),
                          selectedItemPadding: const EdgeInsets.only(left: 20,right: 20),
                          placeholderTS:const TextStyle(
                            color: Color(0XFFC1C1C1),
                          ),
                          selectedItemBD: BoxDecoration(
                            // color: const Color(0xffE8F5FF),
                            borderRadius: BorderRadius.circular(5),

                          ),
                          selectedItemTS: const TextStyle(
                              fontSize: 14,
                              color: buttoncolor,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                          resultTS:const TextStyle(
                              fontSize:  14,
                              color:  buttoncolor,
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
                        onChanged: (value) {
                          // val=2;
                          // customer.set_sort("balance");
                          // mapset((){});
                          // setState(() {
                          //   // val = value;
                          // });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      const  Divider(
                        color: Color(0XFFC1C1C1),
                        thickness: 1,

                      ),
                      const SizedBox(height:5,),
                      Center(
                        child: InkWell(
                          onTap: ()async{
                            Navigator.pop(context);
                            // if(_value==-1){
                            //   customer.set_sort("");
                            // }
                            // else{
                            //   is_loading=true;
                            //   setState(() {
                            //
                            //   });
                            //   await customer.get_customers_my();
                            //   is_loading=false;
                            //   setState(() {
                            //
                            //   });
                            // }
                            // Get.to(ShopDetail());

                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                color: buttoncolor,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: const Center(
                              child: Text("Ok",style: buttontext,),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          );


        });
  }
  detailbox(){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return AlertDialog(

            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: const EdgeInsets.only(right: 5.0),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                        child: Image.asset("assets/icons/cross.png",height: 50,width: 50,)),
                  ),
                ),
                const SizedBox(height: 5,),
                //heading and name
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10,),
                    Container(
                        width: widthSize*0.32,
                        child: const Center(child: Text("Muhammad Ashir Tariq ",style: boldtext,))),
                    const SizedBox(height: 5,),
                    Center(
                      child: Container(
                        width: widthSize*0.32,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("3069009838",style: App_popup_bold_text,),
                            const SizedBox(width: 50,),
                            const Text("Status",style: App_popup_bold_text,),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 5,),
                  ],
                ),
                const SizedBox(height: 10,),
                //detail of customer
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10,),
                    //Date&Time
                    Container(
                        width: widthSize*0.4,
                        margin: const EdgeInsets.only(left: 30,right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            const Text("Date & Time : ",style: normalStyle,),
                            Container(
                              // height: 50,
                              width: 130,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.withOpacity(0.3)
                              ),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:const [
                                   Text("24-12-21",style: App_popup_detail_heading_text,),
                                  SizedBox(height: 5,),
                                  Text("10:00 - 11:00",style: App_popup_detail_text,),

                                ],
                              ),
                            )

                          ],
                        )
                    ),
                    const SizedBox(height: 10,),
                    //Appointment For :
                    Container(
                        width: widthSize*0.4,
                        margin: const EdgeInsets.only(left: 30,right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            const Text("Appointment For :",style: normalStyle,),
                            Container(
                              // height: 50,
                              width: 130,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.3)
                              ),
                              child:const Center(
                                  child: Text("Alteration",style: App_popup_detail_heading_text,)),
                            )

                          ],
                        )
                    ),
                    const SizedBox(height: 10,),
                    //Appointment Location :
                    Container(
                        width: widthSize*0.4,
                        margin: const EdgeInsets.only(left: 30,right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            const Text("Appointment Location :",style: normalStyle,),
                            Container(
                              // height: 50,
                              width: 130,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.3)
                              ),
                              child:const Center(
                                  child: Text("Shop",style: App_popup_detail_heading_text,)),
                            )

                          ],
                        )
                    ),
                    const SizedBox(height: 10,),
                    // Google Address
                    Container(
                        width: widthSize*0.4,
                        margin: const EdgeInsets.only(left: 30,right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            const Text("Google Address :",style: normalStyle,),
                            Container(
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(right: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1.5
                                  ),
                                  color: Colors.white
                              ),
                              child:const Center(
                                  child: Icon(Icons.location_history,color: Colors.red,size: 30,)),
                            )

                          ],
                        )
                    ),
                    const SizedBox(height: 20,),
                    //order button
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: buttoncolor,
                          width: 1.5
                        )
                      ),
                      child: const Center(
                        child: Text(
                          "Order",style: buttontext1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    //measurement button
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: buttoncolor,
                              width: 1.5
                          )
                      ),
                      child: const Center(
                        child: Text(
                          "Measurement",style: buttontext1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ],
                )
              ],
            ),
          );

        }
          );
  }
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Directionality(

      textDirection:text_direction,
      child: Scaffold(
        drawer: const Drawer(
          child: Drawertrail(),
        ),
        backgroundColor: bgcolor,
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
                Text("appointment".tr,style: appbartext,),
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
        body:SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              //mobile field
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: widthSize*0.05,right: widthSize*0.05),
                  // width: widthSize * 0.7,
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
                                    textDirection:text_direction,
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
                              Container(
                                width: widthSize * 0.1,
                                child: Text(
                                  entery_valid == ""
                                      ? " "
                                      : entery_valid,
                                  style: TextStyle(
                                    fontSize:14,
                                    color: entery_valid == ""
                                        ? const Color(0xffC1C1C1)
                                        : Colors.red,
                                    fontWeight: FontWeight.w500,

                                  ),
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
                                      margin:lan.read("status")=="Arabic"?const EdgeInsets.only(left: 10,top: 20,): const EdgeInsets.only(left: 10,top: 20,),
                                      child: const FaIcon(
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
                                      margin: const EdgeInsets.only(right: 10),
                                      child: const FaIcon(
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
                              const SizedBox(height: 5,),
                              Text(
                                entery_valid== ""
                                    ? " "
                                    : entery_valid,
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
                        onTap: (){
                          Get.to(const NewAppointment());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: heightSize*0.07,
                          // width: widthSize*0.2,
                          decoration: BoxDecoration(
                              color: buttoncolor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Center(
                            child: Text(
                              "New Appointments +",style: buttontext,
                            ),
                          ),
                        ),
                      ),
                      // filter button
                      InkWell(
                        onTap: (){
                     FilterBox();
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
              const SizedBox(height: 10,),
              Container(
                height: heightSize*0.73,
                width: widthSize*0.8,
                margin: EdgeInsets.only(left: widthSize*0.05,right: widthSize*0.05),
                child: ListView.builder(
                    physics:  const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: 5,
                    itemBuilder: (BuildContext context,int index){
                      return InkWell(
                        onTap: (){
                          detailbox();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(10),
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
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // profile image and detail
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // profile image
                                  Container(
                                    height:heightSize*0.10,
                                    width: widthSize*0.060,
                                    margin: const EdgeInsets.only(left: 15),
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFC1C1C1),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: buttoncolor.withOpacity(0.3),
                                          blurRadius: 1.0,
                                          // offset: Offset(0.0, 0.75)
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  // customer name header
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:const [
                                      SizedBox(height: 10,),
                                      Text("Muhammad Ashir Tariq ",style: boldtext,),
                                      SizedBox(height: 5,),
                                      Text("Appointment For: Alteration",style: mediumsubheadingtext,),
                                      SizedBox(height: 5,),
                                    ],
                                  ),
                                ],
                              ),
                              const Expanded(child:SizedBox()),

                              //other details date status
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      //dress type
                                      Container(
                                        margin: const EdgeInsets.only(left: 2),
                                        height: heightSize*0.08,
                                        width: widthSize*0.19,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFC1C1C1).withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child:CoolDropdown(
                                          dropdownHeight: 150,
                                          dropdownWidth:widthSize * 0.2,
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
                                          dropdownList: dropdownstatus,
                                          defaultValue: null,
                                          isResultLabel: true,
                                          gap: 10,
                                          placeholder:"Select",
                                          dropdownItemPadding: const EdgeInsets.only(left: 20,right: 20),
                                          selectedItemPadding: const EdgeInsets.only(left: 20,right: 20),
                                          placeholderTS:Apregulartext,
                                          selectedItemBD: BoxDecoration(
                                            // color: const Color(0xffE8F5FF),
                                            borderRadius: BorderRadius.circular(5),

                                          ),
                                          selectedItemTS: const TextStyle(
                                              fontSize: 14,
                                              color: buttoncolor,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins"),
                                          resultTS:const TextStyle(
                                              fontSize:  14,
                                              color:  buttoncolor,
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
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      //reshudcle
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              Get.to(const ReAppointment());
                      },
                                            child: Container(
                                              margin: const EdgeInsets.only(left: 5),
                                              height: heightSize*0.1,
                                              width: widthSize*0.03,
                                              // decoration: BoxDecoration(
                                              //     color: Color(0xFFC1C1C1).withOpacity(0.2),
                                              //     borderRadius: BorderRadius.circular(10)
                                              // ),
                                              child: Center(
                                                  child:Image.asset("assets/icons/refresh.png",color: Colors.red,) ),
                                            ),
                                          ),
                                          Center(
                                            child:lan.read("status")=="Arabic"? const Text("قميص",style: Apsmalltext,):const Text("Rescheduled",style: Apsmalltext,),
                                          )                                      ],
                                      )

                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    height: heightSize*0.08,
                                    width: widthSize*0.28,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFC1C1C1).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child:lan.read("status")=="Arabic"? const Text("قميص",style: Apregulartext,):const Text("27- Dec - 21 | 10:00 AM",style: Apregulartext,),
                                    ),
                                  ),
                                ],
                              ),


                            ],
                          ),
                        ),
                      );


                    }
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
