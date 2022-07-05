import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';

import 'language.dart';
import 'login_with_email.dart';
import 'login_with_number.dart';

class SiginPage extends StatefulWidget {
  const SiginPage({Key? key}) : super(key: key);

  @override
  _SiginPageState createState() => _SiginPageState();
}

class _SiginPageState extends State<SiginPage>with SingleTickerProviderStateMixin {
  TextEditingController email = TextEditingController();
  var local = LocalizationService();
  TextEditingController password = TextEditingController();
  late TabController _tabController;
  bool _isVisible = false;

  var lan=GetStorage();
  bool curr=false;
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    _tabController =  TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()async {
        Get.offAll(const Loginscreen());
        return true;
      },
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            toolbarHeight: 40,
            automaticallyImplyLeading: false,
            backgroundColor: APPBARCOLOR,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 5,top: 5),
                    child: Image.asset(
                      logo_png,
                      height: 30,
                    ),),
                  const SizedBox(width: 50,),
                  Text("sign_up_/_sign_in".tr,textDirection: text_direction,style: appbartext,)
                ]
            ),
            leading: InkWell(
              onTap: () {
                Get.to(const Loginscreen());
              },
              child:const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //tabs are here
              Container(
                height: 60,
                width: widthSize,
                color: buttoncolor,
                child: Center(
                  child: TabBar(
                    controller: _tabController,
                    tabs:[
                      Tab(
                          child: Row(
                            textDirection: text_direction,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.phoneSquare,
                                // color: Colors.white,
                                size: 25,
                              ),
                              Text("login_with_mobile".tr,textDirection: text_direction,style: const TextStyle(fontSize: 18,),),
                              const SizedBox(width: 5,),
                            ],
                          )
                      ),
                      Tab(
                            child: Row(
                              textDirection: text_direction,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.envelope,
                                  // color: Colors.white,
                                  size: 25,
                                ),
                                Text("login_with_email".tr,textDirection: text_direction,style: const TextStyle(fontSize: 18),),
                                const SizedBox(width: 5,),
                              ],
                            )
                      ),

                    ],
                    unselectedLabelColor: const Color(0xff646464),
                    physics: const BouncingScrollPhysics(),
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    // indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 2.0,
                    indicatorPadding: const EdgeInsets.all(1),
                    isScrollable: true,
                  ),
                ),
              ),
              //tabbar views here
              const SizedBox(height: 20,),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: heightSize*0.800,
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        controller: _tabController,
                        children: <Widget>[
                          NumberPage(),
                          EmailPage(),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.048,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40,),

            ],
          ),
        ),
      ),
    );
  }
}
