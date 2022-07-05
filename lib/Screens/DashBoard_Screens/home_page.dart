import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:tailorapp/Screens/Apointments/apointment_screen.dart';
import 'package:tailorapp/Screens/Order_Screen/order_main_screen.dart';
import 'package:tailorapp/Screens/Settings%20Screen/setting_main.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/profile.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/drawer.dart';
import '../customers_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final check = GetStorage('login');
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
                    Text("Logout".tr,textDirection: text_direction,style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                    Text("Are_You_Sure".tr,textDirection: text_direction,style: const TextStyle(color: Colors.black,fontSize: 16,),textAlign: TextAlign.center,),
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
                                  color: buttontextcolor,
                                  width: 1
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "back".tr,textDirection: text_direction,
                                style: const TextStyle(color: buttontextcolor,fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        InkWell(

                          onTap:() async {
                            await check.erase();
                            Get.offAll(const SiginPage());
                          },
                          child: Container(
                            width:  80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Logout".tr,
                                textDirection: text_direction,
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
  var profile=Get.put(profileController());
  var lan=GetStorage();
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
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 5,top: 5),
                  child: Image.asset(
                    logo_png,
                    height: 30,
                  ),),
                const SizedBox(width: 20,),
                Text("dashboard".tr,style: appbartext,),
              ],
            ),
            actions: [
              // InkWell(
              //   onTap: () {
              //     Get.to(const HomePage());
              //   },
              //   child: Container(
              //       padding: const EdgeInsets.all(5),
              //       height: 30,
              //       child: Image.asset(
              //         logo_png,
              //         height: 20,
              //       )
              //   ),
              // ),
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
                  height: 35,
                  width: 35,
                ),
              ),
              GestureDetector(
                onTap: () {
                  LogoutBox();
                },
                child: Icon(Icons.logout_outlined,size: 35,color: Colors.red,),
              ),
            ],
            // centerTitle: true,
            toolbarHeight: 45,
            automaticallyImplyLeading: true,
            backgroundColor: APPBARCOLOR,
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 2,
              ),
              //slider images
              Container(
                height: heightSize * 0.3,
                width: widthSize,
                color: buttoncolor,
                child :CarouselSlider(
                  items: [
                    for(int i=0; i<profile.data_profile.value['banner'].length;i++)
                      Container(
                        margin: const EdgeInsets.only(right: 10,left:10),
                        height: heightSize,
                        width: widthSize ,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(profile.data_profile.value['banner'][i]),fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(15),
                            color: buttoncolor
                        ),
                      )
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   // scrollDirection: Axis.horizontal,
                    //   itemCount: profile.data_profile.value['banner'].length,
                    //   itemBuilder: (BuildContext context,int index) {
                    //     print("bannerdata${ profile.data_profile.value['banner'].length}");
                    //     return Container(
                    //       margin: EdgeInsets.only(right: 10),
                    //       height: heightSize,
                    //       width: widthSize ,
                    //       decoration: BoxDecoration(
                    //           image: DecorationImage(image: NetworkImage(profile.data_profile.value['banner'][index]),fit: BoxFit.contain),
                    //           borderRadius: BorderRadius.circular(15),
                    //           color: buttoncolor
                    //       ),
                    //       // child: Center(
                    //       //   child: lan.read("status") == "Arabic" ? Text(
                    //       //     "اختر ملف", style: buttontext,) : Text(
                    //       //     "Slider Image ${index+1}", style: buttontext,),
                    //       // ),
                    //     );
                    //   },
                    // )
                  ],
                  //Slider Container properties
                  options: CarouselOptions(
                    // height: 180.0,

                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: heightSize*0.150,
                color: buttoncolor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: heightSize*0.14,
                      width: widthSize*0.080,
                      margin: const EdgeInsets.only(left: 5,right: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image:  DecorationImage(
                          image: NetworkImage(
                              profile.data_profile.value['logo']),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: buttoncolor,
                          width: 2,
                        ),
                        // borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    SizedBox(
                      width: widthSize*0.010,
                    ),
                    //shope name here
                    SizedBox(
                        width:widthSize* 0.16,
                        child:Text(
                          "${profile.data_profile.value['shop_name']}",
                          style: TextStyle(color: Colors.white, fontSize: widthSize*0.018),
                        )),
                    SizedBox(
                      width: widthSize*0.010,
                    ),
                    Container(
                      width: widthSize*0.717 ,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //pending order
                          Container(
                            width: widthSize * 0.15,
                            decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: buttoncolor,
                                    width: 2.0,
                                  ),
                                )),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.access_time_filled,
                                        size: widthSize*0.030,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        "25",
                                        style: TextStyle(
                                            color: headingtext, fontSize: widthSize*0.018),
                                      ),
                                    ],
                                  ),
                                  // Text("25", style: TextStyle(color: buttoncolor,fontSize: 25),),
                                  SizedBox(
                                    height: heightSize*0.010,
                                  ),
                                  Text(
                                    "Order_in_Progress".tr,
                                    textDirection: text_direction,
                                    style:
                                    TextStyle(color: headingtext, fontSize: widthSize*0.016),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // payement recived
                          Container(
                            width: widthSize * 0.14,
                            decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: buttoncolor,
                                    width: 2.0,
                                  ),
                                )),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: widthSize*0.030,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        "15",
                                        style: TextStyle(
                                            color: headingtext, fontSize: widthSize*0.018),
                                      ),
                                    ],
                                  ),
                                  // Text("25", style: TextStyle(color: buttoncolor,fontSize: 25),),
                                  SizedBox(
                                    height: heightSize*0.010,
                                  ),
                                  Text(
                                    "Appointments_Completed".tr,
                                    textDirection: text_direction,
                                    style:
                                    TextStyle(color: headingtext, fontSize: widthSize*0.016),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          // order complete
                          Container(
                            width: widthSize * 0.14,
                            decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: headingtext,
                                    width: 2.0,
                                  ),
                                )),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: widthSize*0.030,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        "12",
                                        style: TextStyle(
                                            color: headingtext, fontSize: widthSize*0.018),
                                      ),
                                    ],
                                  ),
                                  // Text("25", style: TextStyle(color: buttoncolor,fontSize: 25),),
                                  SizedBox(
                                    height: heightSize*0.010,
                                  ),
                                  Text(
                                    "Order_Complete".tr,
                                    textDirection: text_direction,
                                    style:
                                    TextStyle(color: headingtext, fontSize: widthSize*0.016),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //rating
                          Container(
                            width: widthSize * 0.14,
                            decoration:  const BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: buttoncolor,
                                    width: 2.0,
                                  ),
                                )
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: widthSize*0.030,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        "3.5",
                                        style: TextStyle(
                                            color: headingtext, fontSize: widthSize*0.018),
                                      ),
                                    ],
                                  ),
                                  // Text("25", style: TextStyle(color: buttoncolor,fontSize: 25),),
                                  SizedBox(
                                    height: heightSize*0.010,
                                  ),
                                  Text(
                                    "OverAll_Rating".tr,
                                    textDirection: text_direction,
                                    style:
                                    TextStyle(color: headingtext, fontSize: widthSize*0.016),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //delevred
                          SizedBox(
                            width: widthSize * 0.14,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.airplane_ticket_outlined,
                                        size: widthSize*0.030,
                                        color: Colors.green,
                                      ),

                                      Text(
                                        "15",
                                        style: TextStyle(
                                            color: buttoncolor, fontSize: widthSize*0.018),
                                      ),
                                    ],
                                  ),
                                  // Text("25", style: TextStyle(color: buttoncolor,fontSize: 25),),
                                  SizedBox(
                                    height: heightSize*0.010,
                                  ),
                                  Text(
                                    "Order_Delevered".tr,
                                    textDirection: text_direction,
                                    style:
                                    TextStyle(color: headingtext, fontSize: widthSize*0.016),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Services button
              // // old design
              // Container(
              //   height: heightSize*0.3,
              //   width: widthSize,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       InkWell(
              //         onTap: (){
              //           Get.to(Customers());
              //         },
              //         child: Container(
              //           height: 130,
              //           width: 130,
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(10),
              //             boxShadow: <BoxShadow>[
              //               BoxShadow(
              //                 color: buttoncolor,
              //                 blurRadius: 5.0,
              //                 // offset: Offset(0.0, 0.5)
              //               )
              //             ],
              //           ),
              //           child: Center(
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Center(
              //                   child: Container(
              //                     // width: 200,
              //                       height: 60,
              //                       child: Lottie.asset('assets/icons/clients.json', height: 60)),
              //                 ),
              //                 SizedBox(
              //                   height: 5,
              //                 ),
              //                 lan.read("status")=="Arabic"?Text(
              //                   "عملاء",
              //                   style: TextStyle(color: Colors.black, fontSize: 20),
              //                 ):Text(
              //                   "Customers",
              //                   style: TextStyle(color: Colors.black, fontSize: 20),
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(width: widthSize*0.1,),
              //       InkWell(
              //         onTap: (){
              //           Get.to(OrderMainPage());
              //         },
              //         child: Container(
              //           height: 130,
              //           width: 130,
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(10),
              //             boxShadow:const <BoxShadow>  [
              //               BoxShadow(
              //                 color: buttoncolor,
              //                 blurRadius: 5.0,
              //                 // offset: Offset(0.0, 0.5)
              //               )
              //             ],
              //           ),
              //           child: Center(
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Container(
              //                   // width: 200,
              //                     height: 80,
              //                     child: Lottie.asset('assets/animation/order.json', height: 60)),
              //                 const SizedBox(
              //                   height: 5,
              //                 ),
              //                 lan.read("status")=="Arabic"?const Text(
              //                   "الطلبات: 45",
              //                   style: TextStyle(color: Colors.black, fontSize: 20),
              //                 ):const Text(
              //                   "Orders: 45",
              //                   style: TextStyle(color: Colors.black, fontSize: 20),
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(width: widthSize*0.1,),
              //       Container(
              //         height: 130,
              //         width: 130,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(10),
              //           boxShadow:const[
              //             BoxShadow(
              //               color: buttoncolor,
              //               blurRadius: 5.0,
              //               // offset: Offset(0.0, 0.5)
              //             )
              //           ],
              //         ),
              //         child: Center(
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Center(
              //                 child: Container(
              //                   // width: 200,
              //                     height: 60,
              //                     child: Lottie.asset('assets/icons/opoint.json', height: 60)),
              //               ),
              //               const  SizedBox(
              //                 height: 5,
              //               ),
              //               lan.read("status")=="Arabic"?const Text(
              //                 "تعيينات",
              //                 style: TextStyle(color: Colors.black, fontSize: 20),
              //               ):const Text(
              //                 "Appointments",
              //                 style: TextStyle(color: Colors.black, fontSize: 20),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //       SizedBox(width: widthSize*0.1,),
              //       Container(
              //         height: 130,
              //         width: 130,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(10),
              //           boxShadow: const[
              //             BoxShadow(
              //               color: buttoncolor,
              //               blurRadius: 5.0,
              //               // offset: Offset(0.0, 0.5)
              //             )
              //           ],
              //         ),
              //         child: Center(
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Container(
              //                 // width: 200,
              //                   height: 60,
              //                   child: Lottie.asset('assets/icons/order.json', height: 100)),
              //               lan.read("status")=="Arabic"?const Text(
              //                 "محذوف",
              //                 style: TextStyle(color: Colors.black, fontSize: 20),
              //               ): const Text(
              //                 "Delevered",
              //                 style: TextStyle(color: Colors.black, fontSize: 20),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 15),
              SizedBox(
                // height: heightSize*0.3,
                width: widthSize,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(const Customers());
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey,
                              // offset: Offset(0, 2),

                            )
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: SizedBox(
                                  // width: 200,
                                    height: 60,
                                    child: Lottie.asset('assets/icons/clients.json', height: 60)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Customers".tr,
                                textDirection: text_direction,
                                style: normalStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: widthSize*0.1,),
                    InkWell(
                      onTap: (){
                        Get.to(const OrderMainPage());
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey,
                              // offset: Offset(0, 2),

                            )
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                // width: 200,
                                  height: 65,
                                  child: Lottie.asset('assets/animation/order.json', height: 60)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "orders".tr,
                                textDirection: text_direction,
                                style: normalStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: widthSize*0.1,),
                    InkWell(
                      onTap: (){
                        Get.to(const AppointmentsScreen());
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey,
                              // offset: Offset(0, 2),

                            )
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: SizedBox(
                                  // width: 200,
                                    height: 60,
                                    child: Lottie.asset('assets/icons/opoint.json', height: 60)),
                              ),
                              const  SizedBox(
                                height: 5,
                              ),
                              Text(
                                "appointment".tr,
                                textDirection: text_direction,
                                style: normalStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: widthSize*0.1,),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey,
                            // offset: Offset(0, 2),

                          )
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              // width: 200,
                                height: 60,
                                child: Lottie.asset('assets/icons/order.json', height: 100)),
                            Text(
                              "Delivered".tr,
                              textDirection: text_direction,
                              style: normalStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              //timer box here
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    // color: Colors.green,
                    width: widthSize*0.3,
                    child: Center(
                      child: Text("Your_Subscription_Will_Expire_In".tr,
                        textDirection: text_direction,
                        style: TextStyle(color: headingtext,fontSize:widthSize* 0.016),),
                    ),
                  ),
                  //couting text
                  SizedBox(
                    // color: Colors.red,
                    width: widthSize * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: heightSize*0.12,
                          width: widthSize*0.08,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                // offset: Offset(0, 2),

                              )
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("7",
                                    style: TextStyle(
                                        color: headingtext, fontSize: 20)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "hours".tr,
                                  textDirection: text_direction,
                                  style:
                                  const TextStyle(color: headingtext, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: widthSize*0.050,
                        ),
                        Container(
                          height: heightSize*0.12,
                          width: widthSize*0.08,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                // offset: Offset(0, 2),

                              )
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("10",
                                    style: TextStyle(
                                        color: headingtext, fontSize: 20)),
                                const SizedBox(
                                  height: 5,
                                ),
                                 Text(
                                  "Minutes".tr,
                                  textDirection: text_direction,
                                  style:
                                  const TextStyle(color: headingtext, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: widthSize*0.050,
                        ),
                        Container(
                          height: heightSize*0.12,
                          width: widthSize*0.08,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                // offset: Offset(0, 2),

                              )
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("20",
                                    style: TextStyle(
                                        color: headingtext, fontSize: 20)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Seconds".tr,
                                  textDirection: text_direction,
                                  style:
                                  const TextStyle(color: headingtext, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // color: Colors.green,
                    width: widthSize*0.3,
                    child: Center(
                      child:
                      Container(
                          height: heightSize*0.070,
                          width: widthSize*0.120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                              borderRadius:   BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(color: headingtext)
                              ],
                              border: Border.all(
                                  color: buttoncolor,
                                  width: 1
                              )
                          ),
                          child: Center(
                              child:
                              Text("Pay_Now".tr,textDirection: text_direction,style: TextStyle(color: buttoncolor,fontSize:widthSize* 0.016),)

                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: heightSize * 0.2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
