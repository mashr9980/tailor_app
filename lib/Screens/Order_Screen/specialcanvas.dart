import 'dart:convert';

import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/controller/measurements.dart';
import 'package:tailorapp/controller/oders.dart';
import 'package:tailorapp/controller/product.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/painter/painter.dart';
class SpecialInstruction extends StatefulWidget {

  SpecialInstruction({Key? key,}) : super(key: key);

  @override
  _NewMeasurementState createState() => _NewMeasurementState();
}

class _NewMeasurementState extends State<SpecialInstruction> {
  var order=Get.put(OrdersController());

  var text=TextEditingController();
  late PainterController _painterController;
  // DrawModeController _drawModeController;
  ScrollController _scrollControllerForText = new ScrollController();
  ScrollController _scrollControllerForPainter = new ScrollController();
  late AnimationController _keyboardAnimationController;
  late Animation _animation;
  List<String> services = [
    'Alteration',
    'Stitching',
  ];
  TextEditingController number = TextEditingController();
  final FocusNode fnumber = FocusNode();

  TextEditingController description = TextEditingController();
  final FocusNode fdescription = FocusNode();
  List colors=[Colors.black,Colors.red,Colors.green,Colors.blue];
  List active=[true,false,false,false];
  List dropdownservicesList = [];
  List dropdownproductList = [];
  static  startSaveNoteTimer(){
    print("save");
  }
  static  startupdateNoteTimer(){
    print("update");
  }
  PainterController _newController() {
    print("sp ${order.sp_inst.value}");
    print("sp ${order.sp_image.value}");
    PainterController controller;
    controller = new PainterController(
        history_: order.sp_inst.isNotEmpty?order.sp_inst.value:null, compressionLevel: 4);

    controller.thickness = 5.0;
    controller.backgroundColor = Color.fromARGB(0, 255, 0, 0);
    // controller.eraseMode.c
    controller.setOnDrawStepListener(startSaveNoteTimer);
    controller.setOnHistoryUpdatedListener(startupdateNoteTimer);
    return controller;
  }

  @override
  void initState() {
    _painterController = _newController();

    super.initState();
  }
  // openAlertBox() {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         final double widthSize = MediaQuery.of(context).size.width;
  //         final double heightSize = MediaQuery.of(context).size.height;
  //         return WillPopScope(
  //           onWillPop: () async => false,
  //           child: StatefulBuilder(
  //               builder: (context, MsetState) {
  //                 return AlertDialog(
  //
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //                     contentPadding: EdgeInsets.only(top: 10.0),
  //                     content: SingleChildScrollView(
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.stretch,
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           SizedBox(height: 5,),
  //                           Center(child: Text("Enter Details",style: boldtext,)),
  //                           SizedBox(height: heightSize*0.025,),
  //                           //select you type
  //                           Center(
  //                             child: Container(
  //                               width: widthSize * 0.25,
  //                               height: heightSize*0.080,
  //                               decoration: BoxDecoration(
  //                                 border: Border.all(
  //                                     color: Color(0xffDDDDDD),
  //                                     width: 2
  //                                 ),
  //                                 borderRadius: BorderRadius.circular(10),
  //                                 color:Colors.white,
  //                                 boxShadow: const [
  //                                   // BoxShadow(
  //                                   //   color: Color(0xFFE8F5FF),
  //                                   //   blurRadius: 1.5,
  //                                   //   spreadRadius: 1.0, //extend the shadow
  //                                   // )
  //                                 ],
  //                               ),
  //                               // color: Colors.red,
  //                               child: CoolDropdown(
  //                                 dropdownHeight: 150,
  //                                 dropdownWidth:widthSize * 0.25,
  //                                 resultBD: BoxDecoration(
  //                                   color: Colors.transparent,
  //                                   borderRadius: BorderRadius.circular(5),
  //                                 ),
  //                                 isTriangle: false,
  //                                 dropdownBD: BoxDecoration(
  //                                   color: Colors.white,
  //                                   borderRadius: BorderRadius.circular(5),
  //                                 ),
  //                                 isResultIconLabel: true,
  //                                 resultWidth:widthSize * 0.55,
  //                                 dropdownList: dropdownservicesList,
  //                                 defaultValue: null,
  //                                 isResultLabel: true,
  //                                 gap: 4,
  //                                 placeholder: "Product Type",
  //                                 dropdownItemPadding: EdgeInsets.only(left: 20,right: 20),
  //                                 selectedItemPadding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
  //                                 placeholderTS:const TextStyle(
  //                                     fontSize:  14,
  //                                     color:  Color(0xff8a8a8a),
  //                                     fontWeight: FontWeight.bold,
  //                                     fontFamily: "Poppins"),
  //                                 selectedItemBD: BoxDecoration(
  //                                   // color: const Color(0xffE8F5FF),
  //                                   borderRadius: BorderRadius.circular(5),
  //
  //                                 ),
  //                                 selectedItemTS: const TextStyle(
  //                                     fontSize: 14,
  //                                     color: const Color(0xff0037da),
  //                                     fontWeight: FontWeight.w500,
  //                                     fontFamily: "Poppins"),
  //                                 resultTS:const TextStyle(
  //                                     fontSize:  14,
  //                                     color:  Color(0xff8a8a8a),
  //                                     fontWeight: FontWeight.w500,
  //                                     fontFamily: "Poppins"),
  //                                 unselectedItemTS:const TextStyle(
  //                                     fontSize:  15,
  //                                     color: const Color(0xff212121),
  //                                     fontWeight: FontWeight.w500,
  //                                     fontFamily: "Poppins"),
  //                                 onChange: (a) {
  //                                   measure.set_product_type(a['label']);
  //                                   MsetState(() {
  //                                   });
  //                                 },
  //                                 dropdownItemReverse: false,
  //                                 dropdownItemMainAxis: MainAxisAlignment.spaceBetween,
  //                                 resultMainAxis: MainAxisAlignment.start,
  //                                 labelIconGap: 10,
  //                                 resultIcon: SizedBox(
  //                                   width: 20,
  //                                   height: 20,
  //                                   child: SvgPicture.asset(
  //                                     'assets/icons/arrowdown.svg',
  //                                     color: Colors.black,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(height: heightSize*0.025,),
  //                           //select product type
  //                           measure.p_type.trim().isNotEmpty? Center(
  //                             child: Container(
  //                               // margin: EdgeInsets.only(right: 20,top: 20),
  //                               width: widthSize * 0.25,
  //                               height: heightSize*0.080,
  //                               decoration: BoxDecoration(
  //                                 border: Border.all(
  //                                     color: Color(0xffDDDDDD),
  //                                     width: 2
  //                                 ),
  //                                 borderRadius: BorderRadius.circular(10),
  //                                 color:Colors.white,
  //                                 boxShadow: const [
  //                                   // BoxShadow(
  //                                   //   color: Color(0xFFE8F5FF),
  //                                   //   blurRadius: 1.5,
  //                                   //   spreadRadius: 1.0, //extend the shadow
  //                                   // )
  //                                 ],
  //                               ),
  //                               // color: Colors.red,
  //                               child: measure.p_type.value=="Stitching"?CoolDropdown(
  //                                 dropdownHeight: 150,
  //                                 dropdownWidth:widthSize * 0.25,
  //                                 resultBD: BoxDecoration(
  //                                   color: Colors.transparent,
  //                                   borderRadius: BorderRadius.circular(5),
  //                                 ),
  //                                 isTriangle: false,
  //                                 dropdownBD: BoxDecoration(
  //                                   color: Colors.white,
  //                                   borderRadius: BorderRadius.circular(5),
  //                                 ),
  //                                 isResultIconLabel: true,
  //                                 resultWidth:widthSize * 0.55,
  //                                 dropdownList: dropdownproductList,
  //                                 defaultValue: null,
  //                                 isResultLabel: true,
  //                                 gap: 4,
  //                                 placeholder: "Product Name",
  //                                 dropdownItemPadding: EdgeInsets.only(left: 20,right: 20),
  //                                 selectedItemPadding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
  //                                 placeholderTS:const TextStyle(
  //                                     fontSize:  14,
  //                                     color:  Color(0xff8a8a8a),
  //                                     fontWeight: FontWeight.bold,
  //                                     fontFamily: "Poppins"),
  //                                 selectedItemBD: BoxDecoration(
  //                                   // color: const Color(0xffE8F5FF),
  //                                   borderRadius: BorderRadius.circular(5),
  //
  //                                 ),
  //                                 selectedItemTS: const TextStyle(
  //                                     fontSize: 14,
  //                                     color: const Color(0xff0037da),
  //                                     fontWeight: FontWeight.w500,
  //                                     fontFamily: "Poppins"),
  //                                 resultTS:const TextStyle(
  //                                     fontSize:  14,
  //                                     color:  Color(0xff8a8a8a),
  //                                     fontWeight: FontWeight.w500,
  //                                     fontFamily: "Poppins"),
  //                                 unselectedItemTS:const TextStyle(
  //                                     fontSize:  15,
  //                                     color: const Color(0xff212121),
  //                                     fontWeight: FontWeight.w500,
  //                                     fontFamily: "Poppins"),
  //                                 onChange: (a) {
  //                                   measure.set_product_id(products.data.value[a['value']]['id'].toString());
  //                                   // selected_hospital = a;
  //                                   // setState(() {
  //                                   //   id_hosp=selected_hospital["value"];
  //                                   //
  //                                   //   print("slelectedabcd${id_hosp}");
  //                                   // });
  //                                   // geteventdata(id_hosp);
  //                                   MsetState(() {
  //
  //                                   });
  //                                 },
  //                                 dropdownItemReverse: false,
  //                                 dropdownItemMainAxis: MainAxisAlignment.spaceBetween,
  //                                 resultMainAxis: MainAxisAlignment.start,
  //                                 labelIconGap: 10,
  //                                 resultIcon: SizedBox(
  //                                   width: 20,
  //                                   height: 20,
  //                                   child: SvgPicture.asset(
  //                                     'assets/icons/arrowdown.svg',
  //                                     color: Colors.black,
  //                                   ),
  //                                 ),
  //                               ):
  //                               TextFormField(
  //                                 // keyboardType: TextInputType.number,
  //                                 textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
  //                                 controller: number,
  //                                 focusNode: fnumber,
  //                                 style: fieldtext,
  //                                 decoration:lan.read("status")=="Arabic"? InputDecoration(
  //                                   focusColor: Colors.white,
  //                                   //add prefix icon
  //
  //                                   border: OutlineInputBorder(
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //
  //                                   focusedBorder: OutlineInputBorder(
  //                                     borderSide: const BorderSide(color: Colors.black, width: 1.0),
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //                                   fillColor: Colors.black,
  //                                   hintText: "Product Name",
  //                                   //make hint text
  //                                   hintStyle: formhinttext,
  //                                   hintTextDirection: TextDirection.rtl,
  //                                   //create lable
  //                                   labelText: 'البريد الإلكتروني / الجوال',
  //                                   //lable style
  //                                   labelStyle: formlabelStyle,
  //
  //                                 ):
  //                                 InputDecoration(
  //
  //                                   focusColor: Colors.white,
  //                                   //add prefix icon
  //
  //                                   border: OutlineInputBorder(
  //                                       borderRadius: BorderRadius.circular(10.0),
  //                                       borderSide:const BorderSide(
  //                                           color: Color(0XFFC1C1C1),
  //                                           width: 3
  //                                       )
  //                                   ),
  //                                   focusedBorder: OutlineInputBorder(
  //                                     borderSide: const BorderSide(color: Colors.black, width: 1.0),
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //                                   fillColor: Colors.black,
  //                                   hintText: "Enter the Product Name",
  //                                   //make hint text
  //                                   hintStyle: formhinttext,
  //                                   //create lable
  //                                   labelText: 'Product Name',
  //                                   //lable style
  //                                   labelStyle: formlabelStyle,
  //                                 ),
  //                               ),
  //                             ),
  //                           ):SizedBox(),
  //
  //                           SizedBox(height: heightSize*0.025,),
  //                           Center(
  //                             child: Container(
  //                               width: widthSize * 0.25,
  //                               height: heightSize*0.080,
  //                               decoration: BoxDecoration(
  //                                 border: Border.all(
  //                                     color: Color(0xffDDDDDD),
  //                                     width: 2
  //                                 ),
  //                                 borderRadius: BorderRadius.circular(10),
  //                                 color:Colors.white,
  //                                 boxShadow: const [
  //                                   // BoxShadow(
  //                                   //   color: Color(0xFFE8F5FF),
  //                                   //   blurRadius: 1.5,
  //                                   //   spreadRadius: 1.0, //extend the shadow
  //                                   // )
  //                                 ],
  //                               ),
  //                               child: TextFormField(
  //                                 // keyboardType: TextInputType.number,
  //                                 textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
  //                                 controller: description,
  //                                 focusNode: fdescription,
  //                                 style: fieldtext,
  //                                 decoration:lan.read("status")=="Arabic"? InputDecoration(
  //                                   focusColor: Colors.white,
  //                                   //add prefix icon
  //
  //                                   border: OutlineInputBorder(
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //
  //                                   focusedBorder: OutlineInputBorder(
  //                                     borderSide: const BorderSide(color: Colors.black, width: 1.0),
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //                                   fillColor: Colors.black,
  //                                   hintText: "Description",
  //                                   //make hint text
  //                                   hintStyle: formhinttext,
  //                                   hintTextDirection: TextDirection.rtl,
  //                                   //create lable
  //                                   labelText: 'البريد الإلكتروني / الجوال',
  //                                   //lable style
  //                                   labelStyle: formlabelStyle,
  //
  //                                 ):
  //                                 InputDecoration(
  //
  //                                   focusColor: Colors.white,
  //                                   //add prefix icon
  //
  //                                   border: OutlineInputBorder(
  //                                       borderRadius: BorderRadius.circular(10.0),
  //                                       borderSide:const BorderSide(
  //                                           color: Color(0XFFC1C1C1),
  //                                           width: 3
  //                                       )
  //                                   ),
  //                                   focusedBorder: OutlineInputBorder(
  //                                     borderSide: const BorderSide(color: Colors.black, width: 1.0),
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //                                   fillColor: Colors.black,
  //                                   hintText: "Enter Description i.e. My self/son/daughter/friend etc...",
  //                                   //make hint text
  //                                   hintStyle: formhinttext,
  //                                   //create lable
  //                                   labelText: 'Description',
  //                                   //lable style
  //                                   labelStyle: formlabelStyle,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(height: heightSize*0.025,),
  //                           //ok Google Map logo
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                             children: [
  //                               //save
  //                               InkWell(
  //
  //                                 onTap:() async {
  //                                   measure.set_product_name(number.text, description.text);
  //                                   PictureDetails a = _painterController.finish();
  //                                   var b = await a.toPNG();
  //                                   String base64String = base64Encode(b!);
  //                                   String header = "data:image/png;base64,";
  //                                   // var c = await Utf8Decoder().convert(b.ge);
  //                                   // print(c);
  //                                   // measure.update_measurement(header+base64String);
  //                                   await measure.add_measurements_my(header+base64String,widget.use_from_orders);
  //                                   Get.back();
  //                                   if(widget.use_from_orders)
  //                                     await measure.get_measurement_single(id: true);
  //                                   else
  //                                     await measure.get_measurement_single();
  //                                   Get.back();
  //                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                                     behavior: SnackBarBehavior.floating,
  //                                     margin: EdgeInsets.only(bottom: 100.0),
  //                                     content: Text("Measurement Added"),
  //                                   ));
  //                                   // Get.to(SiginPage());
  //                                 },
  //                                 child: Container(
  //                                   width:  100,
  //                                   height: 40,
  //                                   decoration: BoxDecoration(
  //                                     // color: buttoncolor,
  //                                     border: Border.all(color: buttoncolor),
  //                                     borderRadius: BorderRadius.circular(10),
  //                                   ),
  //                                   child: Center(
  //                                     child:lan.read("status")=="Arabic"? const Text(
  //                                       "موافق",
  //                                       style: TextStyle(color: buttoncolor,fontSize: 14),
  //                                       textAlign: TextAlign.center,
  //                                     ):const Text(
  //                                       "Save",
  //                                       style: TextStyle(color: buttoncolor,fontSize: 14),
  //                                       textAlign: TextAlign.center,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               InkWell(
  //                                 onTap:(){
  //                                   measure.set_product_type("");
  //                                   number.text="";
  //                                   description.text="";
  //                                   Get.back();
  //                                 },
  //                                 child: Container(
  //                                   padding: EdgeInsets.all(10),
  //                                   // width:  60,
  //                                   height: 40,
  //                                   decoration: BoxDecoration(
  //                                     color: buttoncolor,
  //                                     borderRadius: BorderRadius.circular(10),
  //                                   ),
  //                                   child: Center(
  //                                     child:lan.read("status")=="Arabic"? Text(
  //                                       "موافق",
  //                                       style: TextStyle(color: Colors.white,fontSize: 14),
  //                                       textAlign: TextAlign.center,
  //                                     ): Text(
  //                                       "Cancel",
  //                                       style: TextStyle(color: Colors.white,fontSize: 14),
  //                                       textAlign: TextAlign.center,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               //save and order button
  //                               InkWell(
  //                                 // onTap:(){
  //                                 //   Get.to(SiginPage());
  //                                 // },
  //                                 child: Container(
  //                                   padding: EdgeInsets.all(10),
  //                                   // width:  60,
  //                                   height: 40,
  //                                   decoration: BoxDecoration(
  //                                     color: buttoncolor,
  //                                     borderRadius: BorderRadius.circular(10),
  //                                   ),
  //                                   child: Center(
  //                                     child:lan.read("status")=="Arabic"? Text(
  //                                       "موافق",
  //                                       style: TextStyle(color: Colors.white,fontSize: 14),
  //                                       textAlign: TextAlign.center,
  //                                     ): Text(
  //                                       "Save & Order",
  //                                       style: TextStyle(color: Colors.white,fontSize: 14),
  //                                       textAlign: TextAlign.center,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //
  //                           SizedBox(height: 15,),
  //
  //                         ],
  //                       ),
  //                     )
  //                 );
  //               }),
  //         );
  //       });
  // }
  var lan=GetStorage();
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            title:lan.read("status")=="Arabic"?const Text("رأي الزبون",style: appbartext):const Text("Special Instructions",style: appbartext,),
            actions: [
              Container(
                  padding: EdgeInsets.all(5),
                  height: 35,
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 20,
                  )),
              SizedBox(width: 25,),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "assets/icons/setting.png",
                  height: 60,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "assets/icons/nbell.png",
                  height: 60,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "assets/icons/whats.png",
                  height: 60,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "assets/icons/logout.png",
                  height: 60,
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: heightSize*0.15,
              color: buttoncolor,
              width: widthSize,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //BOX COLORS
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Colors",style: measurementstrip,
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            for(int i=0;i<colors.length;i++)
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      _painterController.drawColor=colors[i];
                                      setState(() {

                                      });
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: colors[i],
                                          border: _painterController.drawColor==colors[i]? Border.all(
                                              color: Colors.white,
                                              width: 3
                                          ):null,
                                          borderRadius: BorderRadius.circular(60)
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                ],
                              ),

                            // Container(
                            //   height: 35,
                            //   width: 35,
                            //   decoration: BoxDecoration(
                            //       color: Colors.red,
                            //       borderRadius: BorderRadius.circular(60)
                            //   ),
                            // ),
                            // SizedBox(width: 10,),
                            // Container(
                            //   height: 35,
                            //   width: 35,
                            //   decoration: BoxDecoration(
                            //       color: Colors.green,
                            //       borderRadius: BorderRadius.circular(60)
                            //   ),
                            // ),
                            // SizedBox(width: 10,),
                            // Container(
                            //   height: 35,
                            //   width: 35,
                            //   decoration: BoxDecoration(
                            //       color: Colors.blue,
                            //       borderRadius: BorderRadius.circular(60)
                            //   ),
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                  //clear button
                  InkWell(
                    onTap: (){
                      _painterController.clear();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Clear All",style: measurementstrip,
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              // color: Colors.black,
                              borderRadius: BorderRadius.circular(60),
                              // border: Border.all(color: Colors.white,width:1 )
                            ),
                            child:Center(
                              child: Icon(Icons.cancel_outlined,color: Colors.white,size: 35,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //erase button
                  InkWell(
                    onTap: (){
                      _painterController.eraseMode = !_painterController.eraseMode;
                      setState(() {

                      });
                    },
                    child: Container(
                      color: _painterController.eraseMode?Colors.blue:Colors.transparent,
                      width: 80,
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Erase",style: measurementstrip,
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              // color: Colors.black,
                              borderRadius: BorderRadius.circular(60),
                              // border: Border.all(color: Colors.white,width:1 )
                            ),
                            child:Center(
                              child: Icon(Icons.phonelink_erase ,color: Colors.white,size: 35,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //undo button
                  InkWell(
                    onTap:(){
                      _painterController.undo();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Undo",style: measurementstrip,
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              // color: Colors.black,
                              borderRadius: BorderRadius.circular(60),
                              // border: Border.all(color: Colors.white,width:1 )
                            ),
                            child:Center(
                              child: Icon(Icons.undo_outlined,color: Colors.white,size: 35,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //redo button
                  InkWell(
                    onTap: (){
                      _painterController.redo();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Redo",style: measurementstrip,
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              // color: Colors.black,
                              borderRadius: BorderRadius.circular(60),
                              // border: Border.all(color: Colors.white,width:1 )
                            ),
                            child:Center(
                              child: Icon(Icons.redo_outlined,color: Colors.white,size: 35,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //save button
                  InkWell(
                    onTap: () async {
                      var paintHistory = _painterController.history;
                      PictureDetails a = _painterController.finish();
                      var b = await a.toPNG();
                      String base64String = base64Encode(b!);
                      String header = "data:image/png;base64,";
                      order.set_sp_(paintHistory,header+base64String,);
                      Get.back();


                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Save",style: measurementstrip,
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              // color: Colors.black,
                              borderRadius: BorderRadius.circular(60),
                              // border: Border.all(color: Colors.white,width:1 )
                            ),
                            child:Center(
                              child: Icon(Icons.check_circle_outline ,color: Colors.white,size: 35,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //dont save and cance; button
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap:(){
                            order.set_sp_("","");
                            Get.back();
                          },
                          child: const Text(
                            "Don't Save",style: measurementstrip,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        InkWell(
                          onTap:(){
                            // order.set_sp_("","");
                            Get.back();
                          },
                          child: Container(
                            height: 35,
                            // width: 35,
                            decoration: BoxDecoration(
                              // color: Colors.black,
                              borderRadius: BorderRadius.circular(60),
                              // border: Border.all(color: Colors.white,width:1 )
                            ),
                            child:const Center(
                              child:   Text(
                                "Cancel",style: measurementstrip,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(height: heightSize*0.03,),
            Container(
              height: heightSize*0.74,
              width: widthSize,
              color: Colors.grey.withOpacity(0.3),
              margin: EdgeInsets.all(5),
              child: Center(
                  child: Painter(_painterController,)
                // Text(
                //   "Draw here what you want "
                // ),
              ),
            )
          ],

        ),
      ),
    );
  }
}
