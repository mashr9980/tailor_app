import 'dart:convert';

import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/measurements.dart';
import 'package:tailorapp/controller/product.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/painter/painter.dart';
class NewMeasurement extends StatefulWidget {
  bool new_note;
  bool use_from_orders;
   NewMeasurement({Key? key, this.new_note=false,this.use_from_orders=false}) : super(key: key);

  @override
  _NewMeasurementState createState() => _NewMeasurementState();
}

class _NewMeasurementState extends State<NewMeasurement> {
  var products=Get.put(ProductController());
  var measure = Get.put(MeasurementsController());
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
     PainterController controller;
    if(widget.new_note){
       controller = new PainterController(
          history_: measure.data_single.value[measure.current_draw.value]['draw'], compressionLevel: 4);
    }
    else {
       controller = new PainterController(
          history_: null, compressionLevel: 4);
    }
    controller.thickness = 5.0;
    controller.backgroundColor = Color.fromARGB(0, 255, 0, 0);
    // controller.eraseMode.c
    controller.setOnDrawStepListener(startSaveNoteTimer);
    controller.setOnHistoryUpdatedListener(startupdateNoteTimer);
    return controller;
  }
  stitch_products() async {
    await products.get_products();
    for (var i = 0; i < products.data.length; i++) {
      dropdownproductList.add(
        {
          'label': '${products.data.value[i]['name']}',
          'value': i,
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
  }
  @override
  void initState() {
    _painterController = _newController();
    stitch_products();
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
    super.initState();
  }
  openAlertBox() {
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
                            placeholder: "Product Type",
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
                              measure.set_product_type(a['label']);
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
                      measure.p_type.trim().isNotEmpty? Center(
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
                          child: measure.p_type.value=="Stitching"?CoolDropdown(
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
                            dropdownList: dropdownproductList,
                            defaultValue: null,
                            isResultLabel: true,
                            gap: 4,
                            placeholder: "Product Name",
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
                              measure.set_product_id(products.data.value[a['value']]['id'].toString());
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
                          ):
                          TextFormField(
                            // keyboardType: TextInputType.number,
                            textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                            controller: number,
                            focusNode: fnumber,
                            style: fieldtext,
                            decoration:lan.read("status")=="Arabic"? InputDecoration(
                              focusColor: Colors.white,
                              //add prefix icon

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.black,
                              hintText: "Product Name",
                              //make hint text
                              hintStyle: formhinttext,
                              hintTextDirection: TextDirection.rtl,
                              //create lable
                              labelText: 'البريد الإلكتروني / الجوال',
                              //lable style
                              labelStyle: formlabelStyle,

                            ):
                            InputDecoration(

                              focusColor: Colors.white,
                              //add prefix icon

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
                              hintText: "Enter the Product Name",
                              //make hint text
                              hintStyle: formhinttext,
                              //create lable
                              labelText: 'Product Name',
                              //lable style
                              labelStyle: formlabelStyle,
                            ),
                          ),
                        ),
                      ):SizedBox(),

                      SizedBox(height: heightSize*0.025,),
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
                          child: TextFormField(
                            // keyboardType: TextInputType.number,
                            textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                            controller: description,
                            focusNode: fdescription,
                            style: fieldtext,
                            decoration:lan.read("status")=="Arabic"? InputDecoration(
                              focusColor: Colors.white,
                              //add prefix icon

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.black,
                              hintText: "Description",
                              //make hint text
                              hintStyle: formhinttext,
                              hintTextDirection: TextDirection.rtl,
                              //create lable
                              labelText: 'البريد الإلكتروني / الجوال',
                              //lable style
                              labelStyle: formlabelStyle,

                            ):
                            InputDecoration(

                              focusColor: Colors.white,
                              //add prefix icon

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
                              hintText: "Enter Description i.e. My self/son/daughter/friend etc...",
                              //make hint text
                              hintStyle: formhinttext,
                              //create lable
                              labelText: 'Description',
                              //lable style
                              labelStyle: formlabelStyle,
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

                            onTap:() async {
                              measure.set_product_name(number.text, description.text);
                              PictureDetails a = _painterController.finish();
                              var b = await a.toPNG();
                              String base64String = base64Encode(b!);
                              String header = "data:image/png;base64,";
                              // var c = await Utf8Decoder().convert(b.ge);
                              // print(c);
                              // measure.update_measurement(header+base64String);
                              await measure.add_measurements_my(header+base64String,widget.use_from_orders);
                              Get.back();
                              if(widget.use_from_orders)
                                await measure.get_measurement_single(id: true);
                              else
                                await measure.get_measurement_single();
                              Get.back();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(bottom: 100.0),
                                content: Text("Measurement Added"),
                              ));
                              // Get.to(SiginPage());
                            },
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
                          InkWell(
                            onTap:(){
                              measure.set_product_type("");
                              number.text="";
                              description.text="";
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
                          //save and order button
                          InkWell(
                            // onTap:(){
                            //   Get.to(SiginPage());
                            // },
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
            }),
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
            title:lan.read("status")=="Arabic"?const Text("رأي الزبون",style: appbartext):const Text("Measurements",style: appbartext,),
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

                      measure.set_data(paintHistory,_painterController.drawColor.red,
                          _painterController.drawColor.green,
                          _painterController.drawColor.blue,
                          _painterController.thickness);


                      // history;
                      print("Paint ${paintHistory}");
                      if(!widget.new_note){
                        openAlertBox();
                      }
                      else{
                         PictureDetails a = _painterController.finish();
                        var b = await a.toPNG();
                         String base64String = base64Encode(b!);
                         String header = "data:image/png;base64,";
                         // var c = await Utf8Decoder().convert(b.ge);
                         // print(c);
                        await measure.update_measurement(header+base64String);
                         Get.back();
                         await measure.get_measurement_single();
                         // Get.back();
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                           behavior: SnackBarBehavior.floating,
                           margin: EdgeInsets.only(bottom: 100.0),
                           content: Text("Measurement Added"),
                         ));
                        // print(b);
                      }

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
                        const Text(
                          "Don't Save",style: measurementstrip,
                        ),
                        const SizedBox(height: 10,),
                        Container(
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
                      ],
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(height: heightSize*0.03,),
            Container(
              height: heightSize*0.7,
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
