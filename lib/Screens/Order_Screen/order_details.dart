import 'dart:convert';
import 'dart:io';

import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/Screens/Contact_us_screen/contact_us_screen.dart';
import 'package:tailorapp/Screens/Order_Screen/specialcanvas.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/customers.dart';
import 'package:tailorapp/controller/measurements.dart';
import 'package:tailorapp/controller/oders.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailorapp/utils/loader.dart';
class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  OrderDetailsState createState() => OrderDetailsState();
}

class OrderDetailsState extends State<OrderDetails> {
  var order=Get.put(OrdersController());
  DateTime selectedDate = DateTime.now();
  var measure = Get.put(MeasurementsController());
  var customer=Get.put(CustomerController());
  var date= TextEditingController();
var quantity=TextEditingController();
  var total_price=TextEditingController();
  var advance=TextEditingController();
  var remaining=TextEditingController();
  var cur_pay = "";
  var cur_delivery="";
  List<String> services = [
    "At shop", "At Customer Home", "At Customer Office"

  ];
  List<String> Payment = [
    "Cash",

  ];
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  final ImagePicker _picker = ImagePicker();
  var _image=null;
  openAlertBox2(image) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return WillPopScope(
            onWillPop: () async => false,
            child: StatefulBuilder(
                builder: (context, MsetState) {
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
                            SizedBox(height: 5,),
                            Image.network(image),

                            //ok Google Map logo
                            InkWell(
                              onTap:(){
                                Get.back();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                // width:  60,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: buttoncolor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child:lan.read("status")=="Arabic"? Text(
                                    "موافق",
                                    style: TextStyle(color: Colors.white,fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ): Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white,fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            // SizedBox(height: 15,),

                          ],
                        ),
                      )
                  );
                }),
          );
        });
  }
  List dropdownservicesList = [];
  List dropdownpaymentList = [];
  void initState() {
    for (var i = 0; i < services.length; i++) {
      dropdownservicesList.add(
        {
          'label': '${services[i]}',
          'value': '${services[i]}',
          'icon': Container(
            key: UniqueKey(),
            height: 20,
            width: 20,
            // child: SvgPicture.asset("assets/icons/check.svg"),
          ),
          'selectedIcon': Container(
            key: UniqueKey(),
            width: 20,
            height: 20,
            child: SvgPicture.asset("assets/icons/check.svg"),
          ),
        },
      );
    }
    for (var i = 0; i < Payment.length; i++) {
      dropdownpaymentList.add(
        {
          'label': '${Payment[i]}',
          'value': '${Payment[i]}',
          'icon': Container(
            key: UniqueKey(),
            height: 20,
            width: 20,
            // child: SvgPicture.asset("assets/icons/check.svg"),
          ),
          'selectedIcon': Container(
            key: UniqueKey(),
            width: 20,
            height: 20,
            child: SvgPicture.asset("assets/icons/check.svg"),
          ),
        },
      );
    }
    super.initState();
  }
  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return StatefulBuilder(
              builder: (context, MsetState) {
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
                          SizedBox(height: 5,),
                          Center(child: Text("Enter Details",style: boldtext,)),
                          SizedBox(height: heightSize*0.025,),
                          //select you type
                          Center(
                            child: Container(
                              width: widthSize * 0.25,
                              height: heightSize*0.080,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xffDDDDDD),
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
                              child: CoolDropdown(
                                dropdownHeight: 150,
                                dropdownWidth:widthSize * 0.25,
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
                                resultWidth:widthSize * 0.55,
                                dropdownList: dropdownservicesList,
                                defaultValue: null,
                                isResultLabel: true,
                                gap: 4,
                                placeholder: "Type",
                                dropdownItemPadding: EdgeInsets.only(left: 20,right: 20),
                                selectedItemPadding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
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
                                  cur_delivery=a['label'];
                                  MsetState(() {
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
                          SizedBox(height: heightSize*0.025,),
                          //select product type
                          Center(
                            child: Container(
                              // margin: EdgeInsets.only(right: 20,top: 20),
                              width: widthSize * 0.25,
                              height: heightSize*0.080,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xffDDDDDD),
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
                              child: CoolDropdown(
                                dropdownHeight: 150,
                                dropdownWidth:widthSize * 0.25,
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
                                resultWidth:widthSize * 0.55,
                                dropdownList: dropdownpaymentList,
                                defaultValue: null,
                                isResultLabel: true,
                                gap: 4,
                                placeholder: "Payment",
                                dropdownItemPadding: EdgeInsets.only(left: 20,right: 20),
                                selectedItemPadding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
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
                                  cur_pay=a['label'];
                                  // selected_hospital = a;
                                  // setState(() {
                                  //   id_hosp=selected_hospital["value"];
                                  //
                                  //   print("slelectedabcd${id_hosp}");
                                  // });
                                  // geteventdata(id_hosp);
                                  MsetState(() {

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
                          SizedBox(height: heightSize*0.025,),
                          //ok Google Map logo
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //save
                              InkWell(

                                // onTap:(){
                                //   Get.to(SiginPage());
                                // },
                                child: Container(
                                  width:  100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    // color: buttoncolor,
                                    border: Border.all(color: buttoncolor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child:lan.read("status")=="Arabic"? const Text(
                                      "موافق",
                                      style: TextStyle(color: buttoncolor,fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ):const Text(
                                      "Save",
                                      style: TextStyle(color: buttoncolor,fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              //save and order button
                              InkWell(
                                onTap:(){
                                  // Get.to(SiginPage());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  // width:  60,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: buttoncolor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child:lan.read("status")=="Arabic"? Text(
                                      "موافق",
                                      style: TextStyle(color: Colors.white,fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ): Text(
                                      "Save & Order",
                                      style: TextStyle(color: Colors.white,fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 15,),

                        ],
                      ),
                    )
                );
              });
        });
  }
  TextEditingController entery = TextEditingController();
  final FocusNode fentery = FocusNode();
  var lan=GetStorage();
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
        bottomNavigationBar: InkWell(
          onTap: () async {
            showDialog(context: context, builder: (BuildContext context) {
              return  WillPopScope(
                onWillPop: ()async{return false;},
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                      height:heightSize ,
                      width: widthSize,
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(10)
                      // ),

                      child: Center(child:Loader())
                  ),
                ),
              );
            }
            );
            await order.add_order(measure.data_single.value[measure.current_draw.value]['measure_id'],customer.data_my.value[customer.current_customer.value]['id'], date.text, quantity.text, total_price.text, advance.text, remaining.text, cur_delivery, cur_pay, _image,);
            Get.back();
            Get.back();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 100.0),
              content: Text("Order Added Successfully"),
            ));
           },
          child: Container(
            height: heightSize*0.1,
            width: 20,

            decoration: BoxDecoration(
                color: buttoncolor,
                borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.only(bottom: 10,left: widthSize*0.3,right: widthSize*0.3),
            child:const Center(
              child: Text("Confirm Order",style:buttontext,),
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            title:lan.read("status")=="Arabic"?const Text("رأي الزبون",style: appbartext):const Text("New Order",style: appbartext,),
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                width: widthSize,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // profile
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(customer.data_my.value[customer.current_customer.value]['image'])
                        ),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(60)
                      ),
                    ),
                    //cleints detail
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Text("${customer.data_my.value[customer.current_customer.value]['name']}",style: boldtext,),
                        SizedBox(height: 5,),
                        Text("${customer.data_my.value[customer.current_customer.value]['phone']}",style: mediumsubheadingtext,),
                      ],
                    ),
                    //last order
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Last Order Date ",style: orderstrip,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "${customer.data_my.value[customer.current_customer.value]['last_order']??"-"}",style: orderstrip,
                          ),
                        ],
                      ),
                    ),
                    //Due Ammount
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Due Ammount ",style: orderstripred,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "${customer.data_my.value[customer.current_customer.value]['balance_due']} ",style: orderstripred,
                          ),
                        ],
                      ),
                    ),
                    //Total Order
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Total Order",style: orderstrip,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "${customer.data_my.value[customer.current_customer.value]['orders']}",style: orderstrip,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 2,
              ),
              SizedBox(height: 5,),
            //  order id & detail
              Container(
                margin: EdgeInsets.only(left: widthSize*0.07,right: widthSize*0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Order ID: 123456",style: orderstrip,),
                    Text("Booking Date : ${DateTime.now().day} - ${DateTime.now().month} - ${DateTime.now().year}",style: orderstrip,),
                  ],
                ),
              ),
              SizedBox(height: heightSize*0.025,),
            //  order details data
              Container(
                margin: EdgeInsets.only(left: widthSize*0.1,right: widthSize*0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Selected Measurement",style: orderstrip,),
                    SizedBox(height: heightSize*0.015,),
                    // strip data
                    Container(
                  width: widthSize*0.75,
                  height: heightSize*0.14,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xffDDDDDD),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // profile image
                      InkWell(
                        onTap:(){
                          openAlertBox2(measure.data_single.value[measure.current_draw.value]['measureimage']);
                    },
                        child: Container(
                          height:heightSize*0.10,
                          width: widthSize*0.060,
                          margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            color: Color(0XFFC1C1C1),
                            image: DecorationImage(
                                image:NetworkImage( measure.data_single.value[measure.current_draw.value]['measureimage'])
                            ),
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
                      ),
                      // customer name header
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Text("${measure.data_single.value[measure.current_draw.value]['name']}",style: boldtext,),
                          SizedBox(height: 5,),
                          Text("Description: ${measure.data_single.value[measure.current_draw.value]['description']}",style: mediumsubheadingtext,),
                        ],
                      ),
                      //dress type
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: heightSize*0.08,
                        width: widthSize*0.1,
                        decoration: BoxDecoration(
                            color: Color(0xFFC1C1C1).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child:lan.read("status")=="Arabic"? Text("قميص",style: boldregulartext,):Text("${measure.data_single.value[measure.current_draw.value]['product_type']=="Stitching"?measure.data_single.value[measure.current_draw.value]['product_name_st']:measure.data_single.value[measure.current_draw.value]['product_name']}",style: boldregulartext,),
                        ),
                      ),
                      //dress status
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: heightSize*0.08,
                        width: widthSize*0.1,
                        decoration: BoxDecoration(
                            color: Color(0xFFC1C1C1).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child:lan.read("status")=="Arabic"? Text("قميص",style: boldregulartext,):Text("${measure.data_single.value[measure.current_draw.value]['product_type']}",style: boldregulartext,),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Image.asset("assets/icons/edit.png"),
                      ),

                    ],
                  ),
                    ),
                    SizedBox(height: heightSize*0.015,),
                    Text("Upload Fabric Cloth",style: orderstrip,),
                    SizedBox(height: heightSize*0.015,),
                    // upload fabric
                    Container(
                      width: widthSize*0.75,
                      height: heightSize*0.14,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffDDDDDD),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // profile image
                          InkWell(
                            onTap: () async {
                              XFile? image = await  _picker.pickImage(
                                  source: ImageSource.gallery, imageQuality: 50
                              );


                                // _image = image;
                                final bytes = File(image!.path).readAsBytesSync();
                                _image =  "data:image/png;base64,"+base64Encode(bytes);
                                // print(_image);
                                // image
                              setState(() {
                              });
                            },
                            child: Container(
                              height:heightSize*0.08,
                              width: widthSize*0.2,
                              margin: EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                color: buttoncolor,
                                borderRadius: BorderRadius.circular(10),

                              ),
                              child:const Center(
                                child: Text("Choose File",style: buttontext,),
                              ),
                            ),
                          ),
                          SizedBox(width: widthSize*0.1,),
                          // customer name header
                          _image==null?
                          Text("No file Choosen",style: mediumsubheadingtext,):Text("Image Picked",style: mediumsubheadingtext,),

                        ],
                      ),
                    ),

                    SizedBox(height: heightSize*0.015,),
                    //start date  & total quantity
                    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select Delivery Date",style: orderstrip,),
                                SizedBox(height: heightSize*0.015,),
                                // upload fabric
                                Container(
                                  width: widthSize*0.35,
                                  height: heightSize*0.1,
                                  child: InkWell(
                                    onTap: () async {
                                      await _selectDate(context);
                                      date.text="${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                                    },
                                    child:AbsorbPointer(
                                      child: TextFormField(
                                        controller: date,
                                        textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                                        // controller: entery,
                                        // focusNode: fentery,
                                        style: fieldtext,
                                        decoration:lan.read("status")=="Arabic"? InputDecoration(
                                          focusColor: Colors.white,
                                          //add prefix icon
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          suffix: Container(
                                            height: 20,
                                            width: 20,
                                            margin: EdgeInsets.only(right: 10),
                                            child: FaIcon(
                                              FontAwesomeIcons.calendar,
                                              color: buttoncolor,
                                              size: 20,
                                            ),
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
                                            margin: EdgeInsets.only(right: 10),
                                            child: FaIcon(
                                              FontAwesomeIcons.calendar,
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
                                          hintText: "Select Your Date",
                                          //make hint text
                                          hintStyle: formhinttext,
                                          // //create lable
                                          // labelText: 'Mobile Number',
                                          // //lable style
                                          // labelStyle: formlabelStyle,
                                        ),
                                      ),
                                    ),
                                  )


                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Quantity",style: orderstrip,),
                                SizedBox(height: heightSize*0.015,),
                                // upload fabric
                                Container(
                                  width: widthSize*0.35,
                                  height: heightSize*0.1,
                                  child:TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: quantity,
                                    textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                                    // controller: entery,
                                    // focusNode: fentery,
                                    style: fieldtext,
                                    decoration:lan.read("status")=="Arabic"? InputDecoration(
                                      focusColor: Colors.white,
                                      //add prefix icon
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      suffix: Container(
                                        height: 20,
                                        width: 20,
                                        margin: EdgeInsets.only(right: 10),
                                        child: FaIcon(
                                          FontAwesomeIcons.digitalOcean,
                                          color: buttoncolor,
                                          size: 20,
                                        ),
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
                                        margin: EdgeInsets.only(right: 10),
                                        child: FaIcon(
                                          FontAwesomeIcons.digitalOcean,
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
                                      hintText: "10",
                                      //make hint text
                                      hintStyle: formhinttext,
                                      // //create lable
                                      // labelText: 'Mobile Number',
                                      // //lable style
                                      // labelStyle: formlabelStyle,
                                    ),
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                    SizedBox(height: heightSize*0.02,),
                    //total price advance   & total quantity
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Price",style: orderstrip,),
                            SizedBox(height: heightSize*0.015,),
                            Container(
                              width: widthSize*0.2,
                              height: heightSize*0.1,
                              child:TextFormField(
                                onChanged: (e){
                                        if(e.trim().isNotEmpty) {
                                          remaining.text =
                                              (double.parse(total_price.text) - double.parse(advance.text))
                                                  .toString();
                                          setState(() {

                                          });
                                        }
                                },
                                keyboardType: TextInputType.number,
                                controller: total_price,
                                textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                                // controller: entery,
                                // focusNode: fentery,
                                style: fieldtext,
                                decoration:lan.read("status")=="Arabic"? InputDecoration(
                                  focusColor: Colors.white,
                                  //add prefix icon
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  suffix: Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.only(right: 10),
                                    child: FaIcon(
                                      FontAwesomeIcons.digitalOcean,
                                      color: buttoncolor,
                                      size: 20,
                                    ),
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
                                    margin: EdgeInsets.only(right: 10),
                                    child: FaIcon(
                                      FontAwesomeIcons.digitalOcean,
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
                                  hintText: "10",
                                  //make hint text
                                  hintStyle: formhinttext,
                                  // //create lable
                                  // labelText: 'Mobile Number',
                                  // //lable style
                                  // labelStyle: formlabelStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Advance",style: orderstrip,),
                            SizedBox(height: heightSize*0.015,),
                            // upload fabric
                            Container(
                              width: widthSize*0.2,
                              height: heightSize*0.1,
                              child:TextFormField(
                                onChanged: (e){
                                  if(e.trim().isNotEmpty){
                                    remaining.text = (double.parse(total_price.text)-double.parse(advance.text)).toString();
                                 setState(() {

                                 });
                                  }
                                },
                                keyboardType: TextInputType.number,
                                controller: advance,
                                textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                                // controller: entery,
                                // focusNode: fentery,
                                style: fieldtext,
                                decoration:lan.read("status")=="Arabic"? InputDecoration(
                                  focusColor: Colors.white,
                                  //add prefix icon
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  suffix: Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.only(right: 10),
                                    child: FaIcon(
                                      FontAwesomeIcons.digitalOcean,
                                      color: buttoncolor,
                                      size: 20,
                                    ),
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
                                    margin: EdgeInsets.only(right: 10),
                                    child: FaIcon(
                                      FontAwesomeIcons.digitalOcean,
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
                                  hintText: "10",
                                  //make hint text
                                  hintStyle: formhinttext,
                                  // //create lable
                                  // labelText: 'Mobile Number',
                                  // //lable style
                                  // labelStyle: formlabelStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Remaining",style: orderstrip,),
                            SizedBox(height: heightSize*0.015,),
                            Container(
                              width: widthSize*0.2,
                              height: heightSize*0.1,
                              child:TextFormField(
                                controller: remaining,
                                enabled: false,
                                keyboardType: TextInputType.number,
                                textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                                // controller: entery,
                                // focusNode: fentery,
                                style: fieldtext,
                                decoration:lan.read("status")=="Arabic"? InputDecoration(
                                  focusColor: Colors.white,
                                  //add prefix icon
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  suffix: Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.only(right: 10),
                                    child: FaIcon(
                                      FontAwesomeIcons.digitalOcean,
                                      color: buttoncolor,
                                      size: 20,
                                    ),
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
                                    margin: EdgeInsets.only(right: 10),
                                    child: FaIcon(
                                      FontAwesomeIcons.digitalOcean,
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
                                  hintText: "10",
                                  //make hint text
                                  hintStyle: formhinttext,
                                  // //create lable
                                  // labelText: 'Mobile Number',
                                  // //lable style
                                  // labelStyle: formlabelStyle,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),

                    SizedBox(height: heightSize*0.015,),
                    Text("Add Special Instruction",style: orderstrip,),
                    SizedBox(height: heightSize*0.015,),
                    // Special Instruction
                    Container(
                      width: widthSize*0.75,
                      height: heightSize*0.14,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffDDDDDD),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // profile image
                          InkWell(
                            onTap: () async {
                              print("main ${order.sp_inst}");
                              Get.to(SpecialInstruction());
                              // XFile? image = await  _picker.pickImage(
                              //     source: ImageSource.gallery, imageQuality: 50
                              // );
                              //
                              //
                              // // _image = image;
                              // final bytes = File(image!.path).readAsBytesSync();
                              // _image =  "data:image/png;base64,"+base64Encode(bytes);
                              // // print(_image);
                              // // image
                              // setState(() {
                              // });
                            },
                            child: Container(
                              height:heightSize*0.08,
                              width: widthSize*0.2,
                              margin: EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                color: buttoncolor,
                                borderRadius: BorderRadius.circular(10),

                              ),
                              child:const Center(
                                child: Text("Add Instruction",style: buttontext,),
                              ),
                            ),
                          ),
                          SizedBox(width: widthSize*0.1,),
                          // customer name header
                          order.sp_inst.isEmpty?
                          Text("No Instruction added",style: mediumsubheadingtext,):Text("Special Instruction added (Click again to review)",style: mediumsubheadingtext,),

                        ],
                      ),
                    ),
                    SizedBox(height: heightSize*0.02,),

                    const Text("Delivery Type",style: orderstrip,),
                    SizedBox(height: heightSize*0.015,),
                    //develvery typre
                    Directionality(
                      textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                      child: CoolDropdown(
                        dropdownWidth: widthSize*0.6,
                        resultBD: BoxDecoration(
                          // color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey
                          )
                        ),
                        isTriangle: false,
                        dropdownBD: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        isResultIconLabel: true,
                        resultWidth: widthSize,
                        dropdownList: dropdownservicesList,
                        defaultValue: null,
                        isResultLabel: true,
                        gap: 4,
                        placeholder: "Delivery Type",
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
                          // setState(() {
                          //   code=a["label"];
                          // });
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
                    SizedBox(height: heightSize*0.02,),
                    const Text("Payment Method",style: orderstrip,),
                    SizedBox(height: heightSize*0.015,),
                    //develvery typre
                    Directionality(
                      textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                      child: CoolDropdown(
                        dropdownWidth: widthSize*0.6,
                        resultBD: BoxDecoration(
                          // color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.grey
                            )
                        ),
                        isTriangle: false,
                        dropdownBD: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        isResultIconLabel: true,
                        resultWidth: widthSize,
                        dropdownList: dropdownpaymentList,
                        defaultValue: null,
                        isResultLabel: true,
                        gap: 4,
                        placeholder: "Payment Method",
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
                          // setState(() {
                          //   code=a["label"];
                          // });
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
                  ],
                ),
              ),
              SizedBox(height: heightSize*0.1,),
            ],

          ),
        ),
      ),
    );
  }
}
