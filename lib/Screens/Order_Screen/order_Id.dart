import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/Screens/Measurement%20Screens/customer_measurement.dart';
import 'package:tailorapp/controller/oders.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/loader.dart';

import 'new_order_screen.dart';
class OrderId extends StatefulWidget {
  const OrderId({Key? key}) : super(key: key);

  @override
  OrderIdState createState() => OrderIdState();
}

class OrderIdState extends State<OrderId> {
  var orders= Get.put(OrdersController());
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  var lan=GetStorage();
  TextEditingController entery = TextEditingController();
  final FocusNode fentery = FocusNode();
  List dropdowncounterycode = [];
  List dropdownprogress = [];
  List<String> codes = [
    '+971',
    '+920',
    '+921',
    '+923',
  ];
  var switch_=false;
  List<String> progress = [
    'In Progrss',
    'Stitching',
    'Cutting',
    "Ready",
    "Delivered",
  ];
  var entery_valid = "";
  var code;
  bool checkedValue=false;
  void initState() {
    for (var i = 0; i < codes.length; i++) {
      dropdownprogress.add({
        'label': '${progress[i]}',
        'value': '${progress[i]}',
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
          entery_valid = lan.read("status")=="Arabic"?"مطلوب هذا الحقل":"Required This Field ";
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

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: bgcolor,
        body: RefreshIndicator(
          onRefresh: orders.get_order,
          child: SingleChildScrollView(
            // physics:  NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: heightSize*0.03,),
                Center(
                  child: Container(
                    width: widthSize * 0.71,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // contery code
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // mobile number
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: widthSize * 0.45,
                                  height: heightSize*0.080,
                                  child: TextFormField(
                                    onChanged: (e){
                                      if(e.trim().isNotEmpty){
                                        switch_=true;
                                        setState(() {

                                        });
                                        orders.get_order_by_id(e);
                                      }
                                      else{
                                        switch_=false;
                                        setState(() {

                                        });
                                      }
                                    },
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
                                        margin:lan.read("status")=="Arabic"?EdgeInsets.only(left: 10,top: 20,): EdgeInsets.only(left: 10,top: 20,),
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
                                        margin: EdgeInsets.only(right: 10),
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
                                      hintText: "Order ID",
                                      //make hint text
                                      hintStyle: formhinttext,
                                      //create lable
                                      labelText: 'Order ID',
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
                            Get.to(NewOrder());
                          },
                          child: Container(
                            height: heightSize*0.080,
                            width: widthSize*0.15,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: buttoncolor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                "New Order +",style: buttontext,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //list view builder
                Container(
                  height: heightSize*0.72,
                  width: widthSize*0.7,
                  margin: EdgeInsets.only(left: widthSize*0.15,right: widthSize*0.15,),
                  child: Obx(
                        ()=> switch_?
                        orders.loading_id.isTrue?Center(child:Loader()): orders.data_search_id.length==0?Center(child:Text("You do not have any orders yet",style: buttontext1,)):
                        ListView.builder(
                            physics:  BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 10,bottom: 20),
                            itemCount: orders.data_search_id.length,
                            itemBuilder: (BuildContext context,int index){
                              return Container(
                                margin: EdgeInsets.only(bottom: 15),

                                // height: heightSize*0.14,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    // customer name header
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10,),
                                        Text("${orders.data_search_id.value[index]['name']}",style: boldtext,),
                                        SizedBox(height: 5,),
                                        Text("${orders.data_search_id.value[index]['phone']}",style: mediumsubheadingtext,),
                                        SizedBox(height: 5,),
                                        Text("Due Balance: ${orders.data_search_id.value[index]['due']}",style: mediumsubredtext,),
                                        SizedBox(height: 5,),
                                        Text("Order ID: ${orders.data_search_id.value[index]['id']}",style: boldtext,),
                                        SizedBox(height: 5,),
                                        Text("Delivery Date: ${orders.data_search_id.value[index]['deliver_date']}",style: mediumsubheadingtext,),
                                        SizedBox(height: 5,),
                                      ],
                                    ),
                                    //buttons update assignm

                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: heightSize*0.08,
                                              width: widthSize*0.2,
                                              padding: EdgeInsets.all(10),
                                              // width: widthSize*0.15,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFC1C1C1).withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Center(
                                                child: Directionality(
                                                  textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                                                  child: CoolDropdown(
                                                    dropdownWidth: widthSize * 0.15,
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
                                                    dropdownList: dropdownprogress,
                                                    defaultValue: dropdownprogress[int.parse(orders.data_search_id.value[index]['status'])-1],
                                                    isResultLabel: true,
                                                    gap: 4,
                                                    placeholder: "In Progress",
                                                    // dropdownItemPadding: EdgeInsets.only(left: 20,right: 20),
                                                    // selectedItemPadding: EdgeInsets.only(left: 20,right: 20),
                                                    placeholderTS:const TextStyle(
                                                        fontSize:  14,
                                                        color:  Colors.black,
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
                                                    onChange: (a) async {
                                                      await orders.change_order(orders.data_search_id.value[index]['id'],a["value"]);
                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                        behavior: SnackBarBehavior.floating,
                                                        margin: EdgeInsets.only(bottom: 100.0),
                                                        content: Container(width: widthSize/3,child: Text("Status Changed")),
                                                      ));
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
                                            InkWell(
                                              onTap: () async {
                                                var response = await flutterShareMe.shareToWhatsApp(msg: "Your Order # ${orders.data_search_id.value[index]['id']} \n Name ${orders.data_search_id.value[index]['name']} \n Deliver Date: ${orders.data_search_id.value[index]['deliver_date']}\nBalance Due ${orders.data_search_id.value[index]['due']}\n Status ${progress[int.parse(orders.data_search_id.value[index]['status'])-1]}");
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.only(left:10 ),
                                                  height: heightSize*0.08,
                                                  width: widthSize*0.05,
                                                  padding: EdgeInsets.all(10),
                                                  // width: widthSize*0.15,
                                                  decoration: BoxDecoration(

                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Image.asset("assets/icons/whats.png")
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        // button
                                        Row(
                                          children: [
                                            Container(
                                              height: heightSize*0.08,
                                              width: widthSize*0.12,
                                              padding: EdgeInsets.all(10),
                                              // width: widthSize*0.15,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: buttoncolor,
                                                      width: 1
                                                  )
                                              ),
                                              child: Center(
                                                child:lan.read("status")=="Arabic"? Text("قميص",style: boldregulartext,):Text("Assign ",style: buttontext1,),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              height: heightSize*0.08,
                                              width: widthSize*0.12,
                                              padding: EdgeInsets.all(10),
                                              // width: widthSize*0.15,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: buttoncolor,
                                                      width: 1
                                                  )
                                              ),
                                              child: Center(
                                                child:lan.read("status")=="Arabic"? Text("قميص",style: boldregulartext,):Text("Update ",style: buttontext1,),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )

                                  ],
                                ),
                              );

                            }
                        )
                            :
                        orders.loading.isTrue?Center(child:Loader()): orders.data_my.length==0?Center(child:Text("You do not have any orders yet",style: buttontext1,)):
                        RefreshIndicator(
                          onRefresh: orders.get_order,
                          child: ListView.builder(
                          physics:  BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 10,bottom: 20),
                          itemCount: orders.data_my.length,
                          itemBuilder: (BuildContext context,int index){
                            return Container(
                              margin: EdgeInsets.only(bottom: 15),

                              // height: heightSize*0.14,
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
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // customer name header
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("${orders.data_my.value[index]['name']}",style: boldtext,),
                                      SizedBox(height: 5,),
                                      Text("${orders.data_my.value[index]['phone']}",style: mediumsubheadingtext,),
                                      SizedBox(height: 5,),
                                      Text("Due Balance: ${orders.data_my.value[index]['due']}",style: mediumsubredtext,),
                                      SizedBox(height: 5,),
                                      Text("Order ID: ${orders.data_my.value[index]['id']}",style: boldtext,),
                                      SizedBox(height: 5,),
                                      Text("Delivery Date: ${orders.data_my.value[index]['deliver_date']}",style: mediumsubheadingtext,),
                                      SizedBox(height: 5,),
                                    ],
                                  ),
                                  //buttons update assignm

                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: heightSize*0.08,
                                            width: widthSize*0.2,
                                            padding: EdgeInsets.all(10),
                                            // width: widthSize*0.15,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFC1C1C1).withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(
                                              child: Directionality(
                                                textDirection:lan.read("status")=="Arabic"?TextDirection.rtl: TextDirection.ltr,
                                                child: CoolDropdown(
                                                  dropdownWidth: widthSize * 0.15,
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
                                                  dropdownList: dropdownprogress,
                                                  defaultValue: dropdownprogress[int.parse(orders.data_my.value[index]['status'])-1],
                                                  isResultLabel: true,
                                                  gap: 4,
                                                  placeholder: "In Progress",
                                                  // dropdownItemPadding: EdgeInsets.only(left: 20,right: 20),
                                                  // selectedItemPadding: EdgeInsets.only(left: 20,right: 20),
                                                  placeholderTS:const TextStyle(
                                                      fontSize:  14,
                                                      color:  Colors.black,
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
                                                  onChange: (a) async {
                                                    await orders.change_order(orders.data_my.value[index]['id'],a["value"]);
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      behavior: SnackBarBehavior.floating,
                                                      margin: EdgeInsets.only(bottom: 100.0),
                                                      content: Container(width: widthSize/3,child: Text("Status Changed")),
                                                    ));
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
                                          InkWell(
                                            onTap: () async {
                                              var response = await flutterShareMe.shareToWhatsApp(msg: "Your Order # ${orders.data_my.value[index]['id']} \n Name ${orders.data_my.value[index]['name']} \n Deliver Date: ${orders.data_my.value[index]['deliver_date']}\nBalance Due ${orders.data_my.value[index]['due']}\n Status ${progress[int.parse(orders.data_my.value[index]['status'])-1]}");
                                            },
                                            child: Container(
                                                margin: EdgeInsets.only(left:10 ),
                                                height: heightSize*0.08,
                                                width: widthSize*0.05,
                                                padding: EdgeInsets.all(10),
                                                // width: widthSize*0.15,
                                                decoration: BoxDecoration(

                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Image.asset("assets/icons/whats.png")
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      // button
                                      Row(
                                        children: [
                                          Container(
                                            height: heightSize*0.08,
                                            width: widthSize*0.12,
                                            padding: EdgeInsets.all(10),
                                            // width: widthSize*0.15,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: buttoncolor,
                                                    width: 1
                                                )
                                            ),
                                            child: Center(
                                              child:lan.read("status")=="Arabic"? Text("قميص",style: boldregulartext,):Text("Assign ",style: buttontext1,),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            height: heightSize*0.08,
                                            width: widthSize*0.12,
                                            padding: EdgeInsets.all(10),
                                            // width: widthSize*0.15,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: buttoncolor,
                                                    width: 1
                                                )
                                            ),
                                            child: Center(
                                              child:lan.read("status")=="Arabic"? Text("قميص",style: boldregulartext,):Text("Update ",style: buttontext1,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )

                                ],
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
      ),
    );
  }
}
