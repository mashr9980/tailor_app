import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/Screens/Measurement%20Screens/customer_measurement.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/drawer.dart';
class ReAppointment extends StatefulWidget {
  const ReAppointment({Key? key}) : super(key: key);

  @override
  AppointmentsScreenState createState() => AppointmentsScreenState();
}

class AppointmentsScreenState extends State<ReAppointment> {
  var lan=GetStorage();
  TextEditingController entery = TextEditingController();
  final FocusNode fentery = FocusNode();
  List dropdownstatus = [];
  List dropdownlocations = [];
  List<String> status = [
    'Measurement',
    'Stiching',
    'Alteration',
  ];
  List<String> location = [
    'At Shope',
    'At Home',
    'At Office',
  ];
  var entery_valid = "";
  var code;
  String? date;
  datetime() {
    DateTime dateToday =new DateTime.now();
    date = dateToday.toString().substring(0,10);
  }
  bool checkedValue=false;
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
    for (var i = 0; i < location.length; i++) {
      dropdownlocations.add({
        'label': '${location[i]}',
        'value': '${location[i]}',
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

                  titleTextStyle:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: buttoncolor,),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  title: lan.read("status")=="Arabic"? Center(child: Text("صنف حسب")):
                  Center(child: Text("Sort By")),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 5,),
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
                        contentPadding: EdgeInsets.only(left: 10,right: 10),
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
                          dropdownItemPadding: EdgeInsets.only(left: 20,right: 20),
                          selectedItemPadding: EdgeInsets.only(left: 20,right: 20),
                          placeholderTS:TextStyle(
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
                              color: const Color(0xff212121),
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
                      SizedBox(height: 5,),
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
                        contentPadding: EdgeInsets.only(left: 10,right: 10),
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
                          dropdownItemPadding: EdgeInsets.only(left: 20,right: 20),
                          selectedItemPadding: EdgeInsets.only(left: 20,right: 20),
                          placeholderTS:TextStyle(
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
                              color: const Color(0xff212121),
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
                      SizedBox(height:5,),
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
                            child: Center(
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

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.only(right: 5.0),
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
                SizedBox(height: 5,),
                //heading and name
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    Container(
                        width: widthSize*0.32,
                        child: Center(child: Text("Muhammad Ashir Tariq ",style: boldtext,))),
                    SizedBox(height: 5,),
                    Center(
                      child: Container(
                        width: widthSize*0.32,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("3069009838",style: App_popup_bold_text,),
                            SizedBox(width: 50,),
                            Text("Status",style: App_popup_bold_text,),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 5,),
                  ],
                ),
                SizedBox(height: 10,),
                //detail of customer
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    //Date&Time
                    Container(
                        width: widthSize*0.4,
                        margin: EdgeInsets.only(left: 30,right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Text("Date & Time : ",style: normalStyle,),
                            Container(
                              // height: 50,
                              width: 130,
                              padding: EdgeInsets.all(5),
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
                    SizedBox(height: 10,),
                    //Appointment For :
                    Container(
                        width: widthSize*0.4,
                        margin: EdgeInsets.only(left: 30,right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Text("Appointment For :",style: normalStyle,),
                            Container(
                              // height: 50,
                              width: 130,
                              padding: EdgeInsets.all(5),
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
                    SizedBox(height: 10,),
                    //Appointment Location :
                    Container(
                        width: widthSize*0.4,
                        margin: EdgeInsets.only(left: 30,right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Text("Appointment Location :",style: normalStyle,),
                            Container(
                              // height: 50,
                              width: 130,
                              padding: EdgeInsets.all(5),
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
                    SizedBox(height: 10,),
                    // Google Address
                    Container(
                        width: widthSize*0.4,
                        margin: EdgeInsets.only(left: 30,right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Text("Google Address :",style: normalStyle,),
                            Container(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(right: 30),
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
                    SizedBox(height: 20,),
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
                      child: Center(
                        child: Text(
                          "Order",style: buttontext1,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
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
                      child: Center(
                        child: Text(
                          "Measurement",style: buttontext1,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
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

      textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
      child: Scaffold(
        // drawer: Drawer(
        //   child: Drawertrail(),
        // ),
        backgroundColor: bgcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            iconTheme: IconThemeData(color: iconscolor),
            title:lan.read("status")=="Arabic"?Text("رأي الزبون",style: appbartext):const Text("Re Schedule Appointment",style: appbartext,),
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
        body:SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: heightSize,
            width: widthSize,
            margin: EdgeInsets.only(left: widthSize*0.1,right: widthSize*0.1),
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(10),
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
                            margin: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                              color: Color(0XFFC1C1C1),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: buttoncolor.withOpacity(0.3),
                                  blurRadius: 1.0,
                                  // offset: Offset(0.0, 0.75)
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
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
                      //last appointment date
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:const [
                          SizedBox(height: 10,),
                          Text("Last Appoinment Date ",style: boldtext,),
                          SizedBox(height: 5,),
                          Text("24 Dec 21 | 10:00 AM",style: normalStyle,),
                          SizedBox(height: 5,),
                        ],
                      ),



                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: Row(
                    children: [
                      Text("Appointment Booking date:",style: boldregulartext,),
                      SizedBox(width: 15,),
                      Text("${DateTime.now().toString().substring(0,10)}",style: normalStyle,)
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                //Appointment for
                CoolDropdown(
                  dropdownHeight: 200,
                  dropdownWidth:widthSize*0.7,
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
                  resultWidth: widthSize,
                  dropdownList: dropdownstatus,
                  defaultValue: null,
                  isResultLabel: true,
                  gap: 10,
                  placeholder:"Appointment For",
                  dropdownItemPadding: EdgeInsets.only(left: 20,right: 20),
                  selectedItemPadding: EdgeInsets.only(left: 20,right: 20),
                  placeholderTS:TextStyle(
                      color: Color(0XFFC1C1C1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold
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
                      color: const Color(0xff212121),
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
                SizedBox(height: heightSize*0.03,),
                //Calender
                Container(
                  height: heightSize*0.080,
                  width: widthSize,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1.3
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Date and Time",style: TextStyle(
                          color: Color(0XFFC1C1C1),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      Icon(Icons.calendar_today_sharp,color: Colors.red,)
                    ],
                  ),
                ),
                SizedBox(height: heightSize*0.03,),
                //Appoinment Location
                CoolDropdown(
                  dropdownHeight: 200,
                  dropdownWidth:widthSize*0.7,
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
                  resultWidth: widthSize,
                  dropdownList: dropdownlocations,
                  defaultValue: null,
                  isResultLabel: true,
                  gap: 10,
                  placeholder:"Appoinment Location",
                  dropdownItemPadding: EdgeInsets.only(left: 20,right: 20),
                  selectedItemPadding: EdgeInsets.only(left: 20,right: 20),
                  placeholderTS:TextStyle(
                      color: Color(0XFFC1C1C1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold
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
                      color: const Color(0xff212121),
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
                SizedBox(height: heightSize*0.06,),
                Center(
                  child: Container(
                    height: heightSize*0.090,
                    width: widthSize*0.4,
                    padding: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                      color: buttoncolor,
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1.3
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:const Center(
                      child: Text("Re Schedule Appointment",style: buttontext,),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
