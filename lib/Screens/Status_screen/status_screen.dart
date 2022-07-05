import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/signin.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';
class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  var signin= Get.put(SigninController());
  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return Colors.green;
    } else {
      return todoColor;
    }
  }
  final _processes = [
    'Order Signed',
    'Order Processed',
    'Shipped ',
    'Out for delivery ',
    'Delivered ',
  ];

  final _content = [
    '20/18',
    '20/18',
    '20/18',
    '20/18',
    '20/18',
  ];
  int _processIndex = 2;
  var lan=GetStorage();
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title:
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 5,top: 5),
                  child: Image.asset(
                    logo_png,
                    height: 60,
                  ),),
                const SizedBox(width: 50,),
                Text("Your_Application_Status".tr,style: appbartext,)
              ]
          )

          ,
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backgroundColor: APPBARCOLOR,

          // leading: InkWell(
          //   onTap: () {
          //     Get.back();
          //   },
          //   child: const Icon(
          //     Icons.arrow_back,
          //     color: Colors.black,
          //     size: 30,
          //   ),
          // ),
        ),
      ),
      body:SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: heightSize*0.1,),
            SizedBox(
              width: widthSize,
              // margin: EdgeInsets.only(left: widthSize*0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Application_Progress".tr,textDirection: text_direction,style: TextStyle(
                    fontSize: widthSize*0.035,
                    fontStyle: FontStyle.italic,
                    color: buttoncolor,
                    fontWeight: FontWeight.bold
                  ),),
                ],
              ),
            ),
            SizedBox(height: heightSize*0.035,),
            // Container(
            //   height: heightSize*0.4,
            //   child: StepperPage(),
            // ),
            Text("${"application_n".tr} ${signin.response.value['app_id']}",style: normalStyle,),
            SizedBox(height: heightSize*0.025,),
            Text("${"application_status".tr} ${"${signin.response.value['status']}".tr} ",style: normalStyle,),
            SizedBox(height: heightSize*0.025,),
            Text("${"reason".tr} ${"${signin.response.value['reason']}".tr} ",style: normalStyle,),
            SizedBox(height: heightSize*0.025,),
            LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              width: widthSize*0.4,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2500,
              percent: int.parse(signin.response.value['progress'].toString())/100,
              center: Text(" ${signin.response.value['progress']}%"),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.green,
            ),
            SizedBox(height: heightSize*0.025,),
            Text("${"email_360".tr} ${signin.response.value['email']}",style: normalStyle,),
            SizedBox(height: heightSize*0.025,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${"whastapp_360".tr} ",style: normalStyle,),
                Text("${signin.response.value['whatsapp']}",style: normalStyle,textDirection: TextDirection.ltr,),
              ],
            ),
            SizedBox(height: heightSize*0.015,),
            SizedBox(
                width: widthSize*0.6,
                child:  Center(
                    child: Text("PleaseLogintoShopWebAdminbelowURLforApplicationStatusanddocumentsubmission".tr,textDirection: text_direction,
                      style: normalStyle,textAlign: TextAlign.center,))),
            SizedBox(height: heightSize*0.015,),
            InkWell(

              onTap: (){
                _launchURL(signin.response.value['url']);
              },
              child: SizedBox(
                  width: widthSize*0.6,
                  child: Center(
                      child: Text("${signin.response.value['url']}",
                        style: webStyle,textAlign: TextAlign.center,))),
            ),
            SizedBox(height: heightSize*0.025,),

            InkWell(
              onTap: () async {
                Get.offAll(SiginPage());
          // Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: buttoncolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: widthSize * 0.5,
                height: heightSize*0.080,
                child: Center(
                  child: Text(
                    "sign_out".tr,
                    textDirection: text_direction,
                    style: buttontext,
                  ),
                ),
              ),
            ),
          ],


        ),
      ),
    );
  }
}
