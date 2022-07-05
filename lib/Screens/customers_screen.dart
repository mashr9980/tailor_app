import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/controller/country.dart';
import 'package:tailorapp/controller/customers.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/drawer.dart';
import 'package:tailorapp/utils/loader.dart';

import 'Customers_detail.dart';
import 'DashBoard_Screens/home_page.dart';
import 'Measurement Screens/customer_measurement.dart';
import 'login_screens/signin_main.dart';
class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  var obj = Get.put(CountryController());
  // var code="";
  var show_search=false;
  var customer=Get.put(CustomerController());
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
  // List dropdowncounterycode = [];
  var entery_valid = "";
  var code="";
  bool checkedValue=false;
  var is_loading=true;
  get_customer() async{
    is_loading=true;
    setState(() {

    });
    await customer.get_customers_my();
    is_loading=false;
    setState(() {

    });
  }
  void initState() {
    get_customer();
    for (var i = 0; i < obj.data.length; i++) {
      dropdowncounterycode.add({
        'label': '${obj.data.value[i]['phone_code']}',
        'value': obj.data.value[i]['id'],
        'icon': SizedBox(
          height: 25,
          width: 25,
          child: Image.network(obj.data.value[i]['country_flag']),
        ),
        'selectedIcon': SizedBox(
          key: UniqueKey(),
          width: 20,
          height: 20,
          child: SvgPicture.asset("assets/icons/check.svg"),
        ),
      });
    }
    code=obj.data[obj.current_country.value]['phone_code'];
    fentery.addListener(() {
      // print("focus node");
      if (!fentery.hasFocus) {
        if (entery.text.isEmpty) {
          entery_valid = "Required This Field ";
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
  // var current_sort="";
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
                     Text("log_out".tr,style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                     Text("are_you_sure".tr,style: const TextStyle(color: Colors.black,fontSize: 16,),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(

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
                        InkWell(

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
                                "log_out".tr,
                                style: const TextStyle(color: Colors.white,fontSize: 14),
                                textAlign: TextAlign.center,
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
  openAlertBox() {

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
                    const SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: widthSize*0.02,left: widthSize*0.02),
                            child: Image.asset("assets/icons/cross.png",height: 30,)),
                      ),
                    ),
                    const SizedBox(height: 10,),
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
                              margin: EdgeInsets.only(left: widthSize*0.01,right: widthSize*0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height:heightSize*0.10,
                                    width: widthSize*0.060,
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFC1C1C1),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage("${customer.current_pop_data['image']}")),
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
                                  SizedBox(
                                    width: widthSize*0.25,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: heightSize*0.010,),
                                        Text("${customer.current_pop_data['name']}",style: normalStyle,),
                                        SizedBox(height: heightSize*0.005,),
                                        Text("${customer.current_pop_data['phone']}",style: normal1Style,),
                                      ],
                                    ),

                                  ),
                                  SizedBox(
                                    width: widthSize*0.25,
                                    child: Row(
                                      children: [
                                        Image.asset("assets/icons/whats.png"),
                                        const SizedBox(width: 5,),
                                        const Text("03069009838",style: normal1Style,),
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
                                  SizedBox(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child:  Text("Total_Order".tr,style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  SizedBox(
                                    width: widthSize*0.25,
                                    child: Text("${customer.current_pop_data['orders']}",style: normalStyle,),

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
                                  SizedBox(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child:  Text("Due_Balance".tr,style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  SizedBox(
                                    width: widthSize*0.25,
                                    child: Text("${customer.current_pop_data['balance_due']}",style: normalStyle,),

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
                                  SizedBox(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child:  Text("Last_Order_Date".tr,style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  SizedBox(
                                    width: widthSize*0.25,
                                    child: Text("${customer.current_pop_data['last_order']??"-"}",style: normalStyle,),

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
                                  SizedBox(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child:  Text("address".tr,style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  SizedBox(
                                    width: widthSize*0.25,
                                    child: Text("${customer.current_pop_data['address']??"-"}",style: normalStyle,),

                                  )
                                ],
                              ),
                            ),
                            // SizedBox(height: heightSize*0.025,),
                            // // Last Google Map logo
                            // Container(
                            //   margin: EdgeInsets.only(left: widthSize*0.03),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //         width: widthSize*0.15,
                            //         // height:heightSize*0.10,
                            //         child: Text("Google Map logo",style:normalStyle ,),
                            //       ),
                            //       SizedBox(width: widthSize*0.02,),
                            //       Container(
                            //         width: widthSize*0.25,
                            //         child: lan.read("status")=="Arabic"?Text("-",style: normalStyle,):Text("-",style: normalStyle,),
                            //
                            //       )
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: heightSize*0.025,),
                            // Last Work Adress
                            // Container(
                            //   margin: EdgeInsets.only(left: widthSize*0.03),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //         width: widthSize*0.15,
                            //         // height:heightSize*0.10,
                            //         child: Text("Work Address",style:normalStyle ,),
                            //       ),
                            //       SizedBox(width: widthSize*0.02,),
                            //       Container(
                            //         width: widthSize*0.25,
                            //         child: lan.read("status")=="Arabic"?Text("Google location",style: normalStyle,):Text("Google location",style: normalStyle,),
                            //
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(height: heightSize*0.025,),
                            // Last Google Map logo
                            Container(
                              margin: EdgeInsets.only(left: widthSize*0.03,right: widthSize*0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child:  Text("Google_Map_Home".tr,style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  SizedBox(
                                    width: widthSize*0.25,
                                    child: Text("${customer.current_pop_data.value['home']??"-"}",style: normalStyle,),

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
                                  SizedBox(
                                    width: widthSize*0.15,
                                    // height:heightSize*0.10,
                                    child: Text("Google_Map_work".tr,style:normalStyle ,),
                                  ),
                                  SizedBox(width: widthSize*0.02,),
                                  SizedBox(
                                    width: widthSize*0.25,
                                    child: Text("${customer.current_pop_data.value['work']??"-"}",style: normalStyle,),

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
                                Get.to(const CustomerMeasurement());
                              },
                              child: Container(
                                margin: EdgeInsets.only(top:heightSize*0.12,right: widthSize*0.1,left: widthSize*0.1),
                                height: heightSize*0.08,
                                width: widthSize*0.1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: buttoncolor,
                                        width: 1
                                    )
                                ),
                                child: Center(
                                  child: Text("measurement".tr,style: regularbuttontext,),
                                ),
                              ),
                            ),
                            SizedBox(height: heightSize*0.025,),
                            //Appointment
                            Container(
                              margin: EdgeInsets.only(right: widthSize*0.1,left: widthSize*0.1),
                              height: heightSize*0.08,
                              width: widthSize*0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: buttoncolor,
                                      width: 1
                                  )
                              ),
                              child: Center(
                                child: Text("appointment".tr,style: regularbuttontext,),
                              ),
                            ),
                            SizedBox(height: heightSize*0.025,),
                            //Order
                            Container(
                              margin: EdgeInsets.only(right: widthSize*0.1,left: widthSize*0.1),
                              height: heightSize*0.08,
                              width: widthSize*0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: buttoncolor,
                                      width: 1
                                  )
                              ),
                              child: Center(
                                child: Text("order".tr,style: regularbuttontext,),
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30,),
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
                    const SizedBox(height: 15,),

                  ],
                ),
              )
          );
        });
  }
  void _openCustomDialog() {
    showGeneralDialog(barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {

          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: StatefulBuilder(

                builder: (context,mapset) {
                  return AlertDialog(

                    titleTextStyle:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: buttoncolor,),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    title:
                     Center(child: Text("Sort_By".tr)),
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
                        RadioListTile(
                          // checkColor: Colors.white,
                          activeColor: Colors.black,
                          value: 1,
                          groupValue: val,
                          contentPadding: const EdgeInsets.only(left: 10,right: 10),
                          title: Text("High_to_low_Order".tr,style:
                          const TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.w500,fontSize: 16,
                            fontFamily: "Poppins",),),
                          // value: checkedValue,
                          onChanged: (value) {
                            val=1;
                            customer.set_sort("order");
                            mapset((){});
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
                          value: 2,
                          groupValue: val,
                          contentPadding: const EdgeInsets.only(left: 10,right: 10),
                          title: Text("Remaining_Balance".tr,style:
                          const TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.w500,fontSize: 16,
                            fontFamily: "Poppins",),),
                          // value: checkedValue,
                          onChanged: (value) {
                            val=2;
                            customer.set_sort("balance");
                            mapset((){});
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
                            onTap: ()async{
                              Navigator.pop(context);
                              if(_value==-1){
                                customer.set_sort("");
                              }
                              else{
                                is_loading=true;
                                setState(() {

                                });
                                await customer.get_customers_my();
                                is_loading=false;
                                setState(() {

                                });
                              }
                              // Get.to(ShopDetail());

                            },
                            child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: buttoncolor,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child:  Center(
                                child:  Text("ok".tr,style: buttontext,),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
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
  bool _value = false;
  int val = -1;
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Directionality(

      textDirection:text_direction,
      child: Scaffold(
        backgroundColor: bgcolor,
        drawer: const Drawer(
          child: Drawertrail(),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45.0),
          child: AppBar(
            iconTheme: const IconThemeData(color: iconscolor),
            title:  Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 5,top: 5),
                  child: Image.asset(
                    logo_png,
                    height: 30,
                  ),),
                const SizedBox(width: 20,),
                Text("Customers".tr,style: appbartext,),
              ],
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
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              //mobile field
              Center(
                child: SizedBox(
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
                                      // dropdownList: dropdowncounterycode,
                                      dropdownList: dropdowncounterycode,
                                      defaultValue: dropdowncounterycode[obj.current_country.value],
                                      // defaultValue: null,
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
                                      dropdownItemReverse: true,
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
                              // Container(
                              //   width: widthSize * 0.1,
                              //   child: Text(
                              //     entery_valid == ""
                              //         ? " "
                              //         : entery_valid,
                              //     style: TextStyle(
                              //       fontSize:14,
                              //       color: entery_valid == ""
                              //           ? Color(0xffC1C1C1)
                              //           : Colors.red,
                              //       fontWeight: FontWeight.w500,
                              //
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          // mobile number
                          const SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: widthSize * 0.447,
                                height: heightSize*0.080,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (e) async {
                                    if(e.trim().isNotEmpty){
                                      is_loading=true;
                                      setState(() {

                                      });
                                      await customer.get_customers_search(e,code);
                                      is_loading=false;
                                      setState(() {

                                      });
                                      show_search=true;

                                    }
                                    else{
                                      show_search=false;
                                    }
                                    setState(() {

                                    });

                                  },
                                  textDirection:text_direction,
                                  controller: entery,
                                  focusNode: fentery,
                                  style: fieldtext,
                                  decoration:
                                  InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    focusColor: Colors.white,
                                    //add prefix icon
                                    suffixIcon: IconButton(
                                      onPressed: null,
                                      icon:
                                      Icon(FontAwesomeIcons.search,color: buttoncolor,),
                                    ),
                                    // suffix: Container(
                                    //   height: 20,
                                    //   width: 20,
                                    //   margin: const EdgeInsets.only(right: 10,left: 10),
                                    //   child: const FaIcon(
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
                                    hintText: "Enter_Your_Number".tr,
                                    //make hint text
                                    hintStyle: formhinttext,
                                    //create lable
                                    labelText: 'mobile_number'.tr,
                                    //lable style
                                    labelStyle: formlabelStyle,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              // Text(
                              //   entery_valid== ""
                              //       ? " "
                              //       : entery_valid,
                              //   style: TextStyle(
                              //     fontSize:14,
                              //     color: entery_valid == ""
                              //         ? Color(0xffC1C1C1)
                              //         : Colors.red,
                              //     fontWeight: FontWeight.w500,
                              //
                              //   ),
                              // )
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          _openCustomDialog();
                        },
                        child: SizedBox(
                          height: heightSize*0.080,
                          width:60 ,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Sort".tr,style: TextStyle(color: buttoncolor,fontSize: widthSize*0.016,fontWeight: FontWeight.bold),),
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
              is_loading?const Center(child: Loader(),):
              entery.text.trim().isNotEmpty?Obx(()=>customer.loading_search.isTrue?
              const Center(child:Loader()):
                  customer.data_search.length==0? Center(child:Text("No_Customers_found_with_this_phone_number".tr,style: buttontext1,)):
                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(left: widthSize*0.13,right: widthSize*0.13),
                    height: heightSize*0.8,
                    child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 100,top: 20),
                        scrollDirection: Axis.vertical,
                        // physics: NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 600,
                            childAspectRatio: 7 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: customer.data_search.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return customer.data_search[index]['added']?InkWell(
                            onTap: () async {
                              await customer.set_current_data(customer.data_search[index]);
                              // customer.set_customer(customer.data_my.length-1);
                              openAlertBox();
                              // Get.to(Customer_detail());
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10,right: 10),
                              width: widthSize*0.2,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: const Offset(20, 20),
                                    blurRadius: 1.5,
                                    spreadRadius: -13,

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
                                      color: const Color(0XFFC1C1C1),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                          image: NetworkImage(customer.data_search[index]['image'],)
                                      ),
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
                                  SizedBox(
                                    width: widthSize*0.25,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: heightSize*0.010,),
                                        Text("${customer.data_search[index]['name']}",style: normalStyle,),
                                        SizedBox(height: heightSize*0.005,),
                                        Text("${customer.data_search[index]['phone']}",style: normal1Style,),
                                        Text("${"bal_due".tr} ${customer.data_search[index]['balance_due']} ",style: normal2Style,),
                                        SizedBox(height: heightSize*0.005,),
                                        Text("${"t_order".tr} ${customer.data_search[index]['orders']}",style: normalStyle,),
                                      ],
                                    ),

                                  )
                                ],
                              ),
                            ),
                          ):Container(
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            width: widthSize*0.2,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: buttoncolor.withOpacity(0.5),
                                    blurRadius: 3.0,
                                    offset: const Offset(0.0, 0.75)
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
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(customer.data_search[index]['image'])
                                    ),
                                    color: const Color(0XFFC1C1C1),
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
                                SizedBox(
                                  width: widthSize*0.25,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: heightSize*0.010,),
                                      Text("${customer.data_search[index]['name']}",style: normalStyle,),
                                      SizedBox(height: heightSize*0.005,),
                                      Text("${customer.data_search[index]['phone']}",style: normal1Style,),

                                      Obx(()=> Center(
                                          child: customer.data_search[index]['add_load']?const Loader():InkWell(
                                             onTap: () async {
                                               if(customer.data_search[index]['add_status']=="Add to my shop")
                                               {
                                                 await customer.set_customer_s(index);
                                                await  customer.add_customers_my(index);

                                               }
                                               await customer.set_current_data(customer.data_my.value[customer.data_my.length-1]);
                                               openAlertBox();

                                             },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: buttoncolor,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              width: widthSize * 0.22,
                                              height: heightSize*0.050,
                                              child: Center(
                                                child: Text(
                                                  "${customer.data_search[index]['add_status']}".tr,
                                                  style: buttontext,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      // lan.read("status")=="Arabic"?Text("الرصيد المستحق 2500 روبية",style: normal2Style,):Text("Due Balance 2500 Rs",style: normal2Style,),
                                    ],
                                  ),

                                )
                              ],
                            ),
                          );
                        }),
                  ),
              ):
              Obx(
                ()=> customer.loading.isTrue?const Center(child: Loader(),):
                customer.data_my.length==0? Center(child: Text("No_Customers_found_that_belongs_to_your_shop".tr,style: buttontext1,)):
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(left: widthSize*0.13,right: widthSize*0.13),
                  height: heightSize*0.8,
                  child: GridView.builder(
                    padding: const EdgeInsets.only(bottom: 100,top: 20),
                      scrollDirection: Axis.vertical,
                      // physics: NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 600,
                          childAspectRatio: 7 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: customer.data_my.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: ()async{
                            await customer.set_current_data(customer.data_my.value[index]);
                            customer.set_customer(index);
                            openAlertBox();
                            // Get.to(Customer_detail());
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10,right: 10),
                            width: widthSize*0.2,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: const Offset(20, 20),
                                  blurRadius: 1.5,
                                  spreadRadius: -13,

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
                                    color: const Color(0XFFC1C1C1),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                        image: NetworkImage(customer.data_my[index]['image'])
                                    ),
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
                                SizedBox(
                                  width: widthSize*0.25,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: heightSize*0.010,),
                                      Text("${customer.data_my[index]['name']}",style: normalStyle,),
                                      SizedBox(height: heightSize*0.005,),
                                      Text("${customer.data_my[index]['phone']}",style: normal1Style,),
                                      Text("${"bal_due".tr} ${customer.data_my[index]['balance_due']} ",style: normal2Style,),
                                      SizedBox(height: heightSize*0.005,),
                                      Text("${"t_order".tr} ${customer.data_my[index]['orders']}",style: normalStyle,),
                                    ],
                                  ),

                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
              // InkWell(
              //   onTap: (){
              //     openAlertBox();
              //   },
              //     child: Text('sasa')),
            ],
          ),
        ),
      ),
    );
  }
}
