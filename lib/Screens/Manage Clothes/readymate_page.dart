import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:tailorapp/controller/oders.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/loader.dart';

class ReadymatePage extends StatefulWidget {

  @override
  OrderIdState createState() => OrderIdState();
}

class OrderIdState extends State<ReadymatePage> {
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
        body: SingleChildScrollView(
          // physics:  NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: heightSize*0.15,),
              Center(
                child: Container(
                  // width: 200,
                    height: 200,
                    child: Lottie.asset('assets/animation/coming.json',)),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
