import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/Screens/Measurement%20Screens/new_measurement_screen.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/customers.dart';
import 'package:tailorapp/controller/measurements.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/loader.dart';

import 'order_details.dart';
class MeasurementDetails extends StatefulWidget {
  const MeasurementDetails({Key? key}) : super(key: key);

  @override
  MeasurementDetailsState createState() => MeasurementDetailsState();
}

class MeasurementDetailsState extends State<MeasurementDetails> {
  var lan=GetStorage();
  var measure = Get.put(MeasurementsController());
  var customer=Get.put(CustomerController());
  @override
  void initState() {
    // TODO: implement initState
    measure.get_measurement_single(id: true);
    super.initState();

  }
  openAlertBox(image) {
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
        bottomNavigationBar: Container(
          height: heightSize*0.1,
          width: 20,

          decoration: BoxDecoration(
            color: buttoncolor,
            borderRadius: BorderRadius.circular(10)
          ),
          margin: EdgeInsets.only(bottom: 10,left: widthSize*0.3,right: widthSize*0.3),
          child:const Center(
            child: Text("Select Measurement",style:buttontext,),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(

            title:lan.read("status")=="Arabic"?Text("رأي الزبون",style: appbartext): Text("List of Measurement History",style: appbartext,),
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
              SizedBox(height: heightSize*0.03,),
              Container(
                height: heightSize*0.1,
                width: widthSize,
                margin: EdgeInsets.only(left: widthSize*0.1,right: widthSize*0.15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // customer name header
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text("${customer.data_my.value[customer.current_customer.value]['name']}",style: boldtext,),
                        SizedBox(height: 5,),
                        Text("${customer.data_my.value[customer.current_customer.value]['phone']}",style: mediumsubheadingtext,),
                      ],
                    ),
                    //add measutrement
                    InkWell(
                      onTap: (){
                        Get.to(NewMeasurement());
                      },
                      child: Container(
                        height: heightSize*0.07,
                        width: widthSize*0.2,
                        decoration: BoxDecoration(
                            color: buttoncolor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text(
                            "New Measurement +",style: buttontext,
                          ),
                        ),
                      ),
                    )
                  ],

                ),
              ),
              //list view builder
              Container(
                height: heightSize*0.7,
                margin: EdgeInsets.only(left: widthSize*0.07,right: widthSize*0.09),
                child: Obx(

                      ()=> measure.loading_single.isTrue?
                      Center(child:Loader()) :
                      measure.data_single.length==0?Center(child:Text("This Customer have no measurements",style: buttontext1,)):ListView.builder(
                      physics:  BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 20,bottom: 40),
                      itemCount: measure.data_single.length,
                      itemBuilder: (BuildContext context,int index){
                        return InkWell(
                          onTap: (){
                            measure.set_current_draw(index);
                            Get.to(OrderDetails());
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //order button
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: buttoncolor,
                                          width: 1
                                      )
                                  ),
                                ),
                                // strip data
                                Container(
                                  width: widthSize*0.6,
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
                                          // print(measure.data_single.value[index]['measureimage']);
                                          openAlertBox(measure.data_single.value[index]['measureimage']);
                                        },
                                        child: Container(
                                          height:heightSize*0.10,
                                          width: widthSize*0.060,
                                          margin: EdgeInsets.only(left: 15),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage( measure.data_single.value[index]['measureimage'])),
                                            color: Color(0XFFC1C1C1),
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
                                          Text("${measure.data_single.value[index]['name']} ",style: boldtext,),
                                          SizedBox(height: 5,),
                                          Text("Description: ${measure.data_single.value[index]['description']}",style: mediumsubheadingtext,)
                                        ],
                                      ),
                                      //dress type
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
                                          child:lan.read("status")=="Arabic"? Text("قميص",style: boldregulartext,):Text("${measure.data_single.value[index]['product_type']=="Stitching"?measure.data_single.value[index]['product_name_st']:measure.data_single.value[index]['product_name']}",style: boldregulartext,),
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
                                          child:lan.read("status")=="Arabic"? Text("قميص",style: boldregulartext,):Text("${measure.data_single.value[index]['product_type']}",style: boldregulartext,),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              measure.set_current_draw(index);
                                              Get.to(NewMeasurement(new_note: true,use_from_orders: true,));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              child: Image.asset("assets/icons/edit.png"),
                                            ),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              measure.dellete_measurement(index);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              child: Image.asset("assets/icons/delete.png"),
                                            ),
                                          )
                                        ],
                                      )

                                    ],
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

            ],

          ),
        ),
      ),
    );
  }
}
