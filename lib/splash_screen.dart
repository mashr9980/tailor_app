import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/controller/country.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';

import 'Screens/DashBoard_Screens/home_page.dart';
import 'Screens/login_screens/language.dart';
import 'Screens/login_screens/signin_main.dart';
import 'controller/profile.dart';
import 'localization/localization_service.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var obj=Get.put(CountryController());
  var profile=Get.put(profileController());
  var con=GetStorage("logindata");
  var lan=GetStorage();
  final check = GetStorage('login');
  bool done =false;
  get_cont() async {
    await obj.get_county();
  }
  bool _first = true;
  // get_check() async {
  //   var user = await check.read("tailor_id");
  //   if(user!=null){
  //     done=true;
  //     setState(() {
  //     });
  //   }
  // }
  var local = LocalizationService();
  @override
  void initState()  {
     get_cont();
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 5),
          () async{
        var user = await check.read("tailor_id");
        var bus = await check.read("bus_id");
       var conter= con.read("country");
       var lang= con.read("status");

       // print("checking${con.read("country")}");
       if(conter!=null && lang!=null){
         local.changeLocale(lang);
         if(user!=null && bus!=null){
           await profile.get_my_business();
           Get.offAll(const HomePage());
         }else{
           Get.to(const SiginPage());
         }
       }else{
         Get.to(const Loginscreen());
       }

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return  Scaffold(
      backgroundColor: bgcolor,
      body:  SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: heightSize,
                width: widthSize,
                child: Image.asset("assets/images/bg.png",fit: BoxFit.fill,)),
            Center(
              child: AnimatedCrossFade(

                  duration: const Duration(seconds: 3),
                  firstCurve: Curves.bounceInOut,
                  crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstChild: Image.asset(logo_png,height: 250,),
                  secondChild: const Text("Wellcome to Tailor App")
              ),
            ),
            const SizedBox(height: 100,),
            // check.read("tailor_id")!=null?SizedBox():Positioned(
            //   top: heightSize*0.700,
            //   left: widthSize*0.4,
            //   right: widthSize*0.4,
            //   child: InkWell(
            //     onTap: (){
            //       // if(lan!=null){
            //       //   Get.to( SiginPage());
            //       // }
            //       // else{
            //         Get.to( Loginscreen());
            //       // }
            //
            //     },
            //     child: Container(
            //       height: 40,
            //       width: 100,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15),
            //         color: buttoncolor,
            //       ),
            //       child: Center(
            //         child: Text("Get Started",style: buttontext,),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      )

    );
  }
}
