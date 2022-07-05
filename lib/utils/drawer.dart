import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/Screens/Apointments/apointment_screen.dart';
import 'package:tailorapp/Screens/Contact_us_screen/contact_us_screen.dart';
import 'package:tailorapp/Screens/DashBoard_Screens/calendar_page.dart';
import 'package:tailorapp/Screens/DashBoard_Screens/home_page.dart';
import 'package:tailorapp/Screens/Find%20Customer/find_customer_screen.dart';
import 'package:tailorapp/Screens/Measurement%20Screens/measurement_main_screen.dart';
import 'package:tailorapp/Screens/My%20Account/my_account_screen.dart';
import 'package:tailorapp/Screens/Order_Screen/order_main_screen.dart';
import 'package:tailorapp/Screens/Settings%20Screen/setting_main.dart';
import 'package:tailorapp/Screens/customers_screen.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/profile.dart';
import 'package:tailorapp/localization/localization_service.dart';

import 'app_colors.dart';
import 'app_images.dart';
import 'app_styles.dart';
class Drawertrail extends StatefulWidget {
  const Drawertrail({Key? key}) : super(key: key);

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<Drawertrail> {
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
                     Text("log_out".tr,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                     Text("are_you_sure".tr,style: const TextStyle(color: Colors.black,fontSize: 16,),textAlign: TextAlign.center,),
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
                                child:  Text(
                                  "back".tr,
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
                                child:  Text(
                                  "log_out".tr,
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
  var lan=GetStorage();
  var profile=Get.put(profileController());
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Directionality(
        textDirection: text_direction,
        child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage("${profile.data_profile.value['logo']}"),
                      )), child: null,
               ),
              SizedBox(height: heightSize*0.015,),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("${profile.data_profile.value['shop_name']}",style: drawerheading,),
                    )
                  ],
                ),
              ),
              const Divider(),
              //dashboard
              ListTile(
                onTap: (){
                  Get.to(const HomePage());
                },
                title: Row(
                  children: <Widget>[
                    Image.asset(dashboard,height: 30,width: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("dashboard".tr,style: drawersubheading,),
                    )
                  ],
                ),
              ),
              //my account
              ListTile(
                onTap: (){
                  Get.to(const MyAccount());
                },
                title: Row(
                  children: <Widget>[
                    Image.asset(iconprofile,height: 30,width: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child:  Text("my_account".tr),
                    )
                  ],
                ),
              ),
              const Divider(),
              //Find Customer
              ListTile(
                onTap: (){
                  Get.to(const Customers());
                },
                title: Row(
                  children: <Widget>[
                    Image.asset(fcustomer,height: 30,width: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child:  Text("Customers".tr),
                    )
                  ],
                ),
              ),
              //appointments
              const Divider(),
              ListTile(
                onTap: (){
                  Get.to(const AppointmentsScreen());
                },
                title: Row(
                  children: <Widget>[
                    Image.asset(appointments,height: 30,width: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("appointment".tr),
                    )
                  ],
                ),
              ),
              const Divider(),
              //Find orders
              ListTile(
                onTap: (){
                  Get.to(const OrderMainPage());
                },
                title: Row(
                  children: <Widget>[
                    Image.asset(orders,height: 30,width: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("order".tr),
                    )
                  ],
                ),
              ),
              const Divider(),
              //Measurement
              ListTile(
                onTap: (){
                  Get.to(const MainMeasurement());
                },
                title: Row(
                  children: <Widget>[
                    Image.asset(measurement,height: 30,width: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("measurement".tr),
                    )
                  ],
                ),
              ),
              const Divider(),
              //settings
              ListTile(
                title: InkWell(
                  onTap:(){
                    Get.to(const SettingMain());
                  },
                  child: Row(
                    children: <Widget>[
                      Image.asset(setting,height: 30,width: 30,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("settings".tr),
                      )
                    ],
                  ),
                ),
              ),
              //Subscrption
              const Divider(),
              ListTile(
                onTap: (){
                  Get.to(const Calendar());
                },
                title: Row(
                  children: <Widget>[
                    Image.asset(subscribe,height: 30,width: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Subscription".tr),
                    )
                  ],
                ),
              ),
              const Divider(),
              //Terms & conditions
              ListTile(
                title: Row(
                  children: <Widget>[
                    Image.asset(terms,height: 30,width: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Terms_&_conditions".tr),
                    )
                  ],
                ),
              ),
              const Divider(),
              //1S360 You Tube
              ListTile(
                title: Row(
                  children: <Widget>[
                    Image.asset(youtube,height: 30,width: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("1S360_YouTube".tr),
                    )
                  ],
                ),
              ),
              //1S360 Contact Us
              const Divider(),
              ListTile(
                onTap: (){
                  Get.to(const Contactus());
                },
                title: Row(
                  children: <Widget>[
                    Image.asset(contact,height: 30,width: 30,),
                     Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("1S360_Contact_Us".tr),
                    )
                  ],
                ),
              ),
              SizedBox(height: heightSize*0.015,),
              Center(
                child: InkWell(
                  onTap: (){
                    LogoutBox();
                  },
                  child: Container(height: heightSize*0.080,width: widthSize*0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: Colors.red)
                        ],
                        border: Border.all(color: Colors.red,width: 1)
                    ),
                    child: Center(child: Text("sign_out".tr,style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.red),)),
                  ),
                ),
              ),
              SizedBox(height: heightSize*0.025,),
            ],
          ),
      ),
    );

  }
}
