import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/signup.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';

class ShopDetail extends StatefulWidget {
  const ShopDetail({Key? key}) : super(key: key);

  @override
  _ShopDetailState createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  var signup=Get.put(SignupController());
  // var _selectedcat=[];
  get_location()async{

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var longitude=position.longitude.toString();
    var latitude=position.latitude.toString();
    // var placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    // var placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    // print("place marks ${placemarks}");
    final coordinates = Coordinates(
        position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first =addresses.first;
    // print("${first.featureName} : ${first.addressLine}");
    signup.set_location_bus(latitude,longitude,first.addressLine);
  }
  var obj = Get.put(SignupController());
  TextEditingController name = TextEditingController();
  final FocusNode fname = FocusNode();
  TextEditingController shope = TextEditingController();
  final FocusNode fshope = FocusNode();
  var name_valid = "";
  var shope_valid = "";

  var lan=GetStorage();
  List<String> services = [
    'Alteration',
    'Stiching',
    'Fabric',
    "Readymade Clothes"
  ];
  List<String> services2 = [
    'Alteration',
    'New Stitching',
    'Fabric',
    "Readymade Clothes"
  ];
  List<String> categorey = [
    'Men',
    'Women',
    'Kids',
  ];
  List<String> intrested = [
    'Add my Shope Online',
    'Provide a Point of Sale System',
    'Logistic Solutions',
  ];
  List<String> intrested2 = [
    'Register Shop',
    'Point of Sale',
    'Logistics Solution',
  ];
  var selected_cat = [];
  var selected_intrested = [];
  var selected_services = [];
  List dropdowncategoreyList = [
    Category(id:  'Men'.tr,name:  'Men',),
    Category(id:'Women'.tr,name: 'Women'),
    Category(id:'Kids'.tr,name:'Kids'),

  ];
  List dropdownservicesList = [
    Service(id: 'alteration'.tr, name:'Alteration', ),
    Service(id: 'Stitching'.tr, name: 'New Stitching',),
    Service(id: 'Fabric'.tr, name: 'Fabric',),
    Service(id: 'Readymade Clothes'.tr, name: 'Readymade Clothes',),
  ];
  List dropdownintrestedList = [
    Intrest(id: 'Add my Shop Online'.tr, name: 'Register Shop'),
    Intrest(id: 'Provide a Point of Sale System'.tr, name: 'Point of Sale'),
    Intrest(id:  'Logistic Solutions'.tr, name: 'Logistics Solution'),
  ];
  // final _items1 =
  // dropdowncategoreyList
  //     .map((animal) => MultiSelectItem<Category>(animal, animal.name))
  //     .toList();
  @override
  void initState() {
    get_location();
    fname.addListener(() {
      // print("focus node");
      if (!fname.hasFocus) {
        if (name.text.isEmpty) {
          name_valid = "required".tr;
          setState(() {});
          return;
        } else {
          name_valid = "null";
          setState(() {});
          return;
        }
      }
    });
    fshope.addListener(() {
      print("focus node");
      if (!fshope.hasFocus) {
        if (shope.text.isEmpty) {
          shope_valid = "required".tr;
          setState(() {});
          return;
        } else {
          shope_valid ="null";
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
    return WillPopScope(
      onWillPop: ()async{
        Get.offAll(const SiginPage());
        return true;
      },
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            backgroundColor: APPBARCOLOR,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 5,top: 5),
                    child: Image.asset(
                      logo_png,
                      height: 60,
                    ),),
                  const SizedBox(width: 50,),
                  Text("register_my_tailor_shop".tr,textDirection: text_direction,style: appbartext,) ]
            ),
            leading: InkWell(
              onTap: () {
                Get.to(const SiginPage());
              },
              child:const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Directionality(
              textDirection:text_direction,
              child: Container(
                margin:
                EdgeInsets.only(left: widthSize * 0.09, right: widthSize * 0.09),
                child: Column(
                  children: [
                    SizedBox(
                      height: heightSize * 0.05,
                    ),
                    // field Shope Name
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widthSize * 0.55,
                          height: heightSize*0.080,
                          child: Center(
                            child: TextFormField(
                              textDirection: text_direction,
                              controller: name,
                              focusNode: fname,
                              style: fieldtext,
                              decoration:
                              InputDecoration(
                                disabledBorder: InputBorder.none,
                                focusColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderSide:const BorderSide(color: Color(0xFFC1C1C1), width: 10.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Color(0xFFC1C1C1), width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fillColor: Colors.black,
                                hintText: "enter_shop_name".tr,
                                //make hint text
                                hintStyle: formhinttext,
                                //create lable
                                labelText: 'shop_name'.tr,
                                //lable style
                                labelStyle: formlabelStyle,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2,),
                        name_valid =="" || name_valid =="null"
                            ?const SizedBox():Text(name_valid,
                          style: TextStyle(
                            fontSize:14,
                            color: name_valid == ""
                                ? const Color(0xffC1C1C1)
                                : Colors.red,
                            fontWeight: FontWeight.w500,

                          ),
                        )
                      ],
                    ),
                    SizedBox(height: heightSize*0.030,),
                    //Shope Address
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widthSize * 0.55,
                          height: heightSize*0.1,
                          child: TextFormField(
                            // keyboardType: TextInputType.text,
                            // maxLines: null,
                            textDirection: text_direction,
                            controller: shope,
                            focusNode: fshope,
                            style: fieldtext,
                            decoration:
                            InputDecoration(
                              disabledBorder: InputBorder.none,
                              focusColor: Colors.white,

                              border: OutlineInputBorder(
                                borderSide:const BorderSide(color: Color(0xFFC1C1C1), width: 10.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Color(0xFFC1C1C1), width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.black,
                              hintText: "Enter_Shop_Address".tr,
                              //make hint text
                              hintStyle: formhinttext,
                              //create lable
                              labelText: 'shop_address'.tr,
                              //lable style
                              labelStyle: formlabelStyle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2,),
                        shope_valid == "" || shope_valid =="null"?const SizedBox():Text(shope_valid,
                          style: TextStyle(
                            fontSize:14,
                            color: shope_valid == ""
                                ? const Color(0xffC1C1C1)
                                : Colors.red,
                            fontWeight: FontWeight.w500,

                          ),
                        )
                      ],
                    ),
                    SizedBox(height: heightSize*0.030,),
                    //select you categorey
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(right: 10,left:10),
                            width: widthSize * 0.55,
                            // height: heightSize*0.05,
                            child: Text(
                              "Category".tr,
                              style: formlabelStyle,)),
                        const SizedBox(height: 10),
                        Center(
                          child: SizedBox(
                            // padding: EdgeInsets.only(right: 10,top: 10),
                            width: widthSize * 0.55,
                            child:
                            MultiSelectChipField(
                              headerColor: buttoncolor,
                              title: Text("select_category".tr,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                              items: dropdowncategoreyList.map((e) => MultiSelectItem(e.name, e.id)).toList(),
                              icon: const Icon(Icons.check,color: Colors.white,),
                              selectedChipColor: buttoncolor,
                              selectedTextStyle: const TextStyle(color: Colors.white),
                              onTap: (values) {
                                selected_cat=values;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heightSize*0.015,),
                    //select you Services
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(right: 10,left:10),
                            width: widthSize * 0.55,
                            // height: heightSize*0.05,
                            child: Text("Services".tr,style: formlabelStyle,)),
                        const SizedBox(height: 10),
                        //// Bilal Ahmad Commit

                        Center(
                          child:
                          SizedBox(
                            width: widthSize * 0.55,
                            child:
                            MultiSelectChipField(
                              headerColor: buttoncolor,
                              title: Text("Chose_Services".tr,textDirection: text_direction,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                              icon: const Icon(Icons.check,color: Colors.white,),
                              selectedChipColor: buttoncolor,
                              selectedTextStyle: const TextStyle(color: Colors.white),
                              items: dropdownservicesList.map((e) => MultiSelectItem(e.name, e.id)).toList(),
                              // listType: MultiSelectListType.CHIP,
                              onTap: (values) {
                                selected_services=values;
                                // var _selectedservice = values;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heightSize*0.015,),
                    //select I am Interested In
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(right: 10,left:10),
                            width:widthSize * 0.55,
                            // height: heightSize*0.05,
                            child: Text("I_am_Interested_In".tr,textDirection: text_direction,style: formlabelStyle,)),
                        const SizedBox(height: 10),
                        //// Bilal Ahmad Commit
                        Center(
                          child: SizedBox(
                            // padding: EdgeInsets.only(right: 10,top: 10),
                            width: widthSize * 0.55,
                            child:

                            MultiSelectChipField(
                              headerColor: buttoncolor,
                              title: Text("Choose_Interest".tr,textDirection: text_direction,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                              icon: const Icon(Icons.check,color: Colors.white,),
                              selectedChipColor: buttoncolor,
                              selectedTextStyle: const TextStyle(color: Colors.white),
                              items: dropdownintrestedList.map((e) => MultiSelectItem(e.name, e.id)).toList(),
                              // listType: MultiSelectListType.CHIP,
                              onTap: (values) {
                                selected_intrested= values;
                                // var _selectedintrest = values;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heightSize*0.055,),
                    //Sign Up button
                    Center(
                      child: InkWell(
                        onTap:name_valid=="null" && shope_valid=="null"?() async{
                          showDialog(context: context, builder: (BuildContext context) {
                            return  AlertDialog(
                              shape:const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
                              content: Directionality(
                                textDirection:text_direction,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 15,),
                                    Container(
                                        width: 120,
                                        // height: 60,
                                        margin: const EdgeInsets.only(left: 10,right: 10),
                                        child: Lottie.asset('assets/animation/submiting.json', height: 120)),
                                    const SizedBox(height: 10,),
                                    Center(
                                      child: Text("Submitting_Your_Shop_Details".tr,textDirection: text_direction,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                    ),
                                    const SizedBox(height: 10,),
                                    Center(
                                      child: Text("Please_Wait".tr,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                                    )


                                  ],
                                ),
                              ),

                            );
                          }
                          );
                          await obj.shopdetail(name.text,shope.text, selected_cat, selected_services, selected_intrested);
                          Navigator.pop(context);

                          showDialog(context: context, builder: (BuildContext context) {
                            return  AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
                              content: Directionality(
                                textDirection:text_direction,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 15,),
                                    Container(
                                        width: 150,
                                        // height: 60,
                                        margin: const EdgeInsets.only(left: 10,right: 10),
                                        child: Lottie.asset('assets/animation/document.json', height: 150)),
                                   const SizedBox(height: 10,),

                                    Center(child: Text("thank_you_for_registering_with_us".tr,style: popup,)),
                                    const SizedBox(height: 5,),

                                     Center(child: Text("${"application_n".tr} ${obj.response_busin.value['id']}",style: popup,textAlign: TextAlign.center,)),
                                    const SizedBox(height: 5,),

                                    Center(child: Text("Our_One_Service_360_Team_will_contact_you_shortly".tr,style: popup,textAlign: TextAlign.center,)),
                                    const SizedBox(height: 5,),

                                     Center(child: Row(
                                       children: [
                                         Text("${"whastapp_360".tr}",style: popup,textAlign: TextAlign.center,),
                                         Text("${obj.response_busin.value['whatsapp']}",textDirection: TextDirection.ltr,style: popup,textAlign: TextAlign.center,),
                                       ],
                                     )),
                                    const SizedBox(height: 5,),
                                     Center(child: Text("${"email_360".tr} ${obj.response_busin.value['email']}",style: popup,textAlign: TextAlign.center,)),
                                    const SizedBox(height: 20,),
                                    Center(
                                      child: InkWell(
                                        onTap: (){
                                          Get.offAll(const SiginPage());
                                          // Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: buttoncolor,
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Center(
                                            child: Text("ok".tr,style: buttontext,),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          );
                        }:null,
                        child: Container(
                          decoration: BoxDecoration(
                            color:name_valid=="null" && shope_valid=="null"? buttoncolor:buttoncolor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: widthSize * 0.5,
                          height: heightSize*0.080,
                          child:  Center(
                            child: Text(
                              "submit_my_application".tr,
                              style: buttontext,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightSize * 0.20,
                    ),
                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }

}
class Intrest {
  final String id;
  final String name;

  Intrest({
    required this.id,
    required this.name,
  });
}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });
}

class Service {
  final String id;
  final String name;

  Service({
    required this.id,
    required this.name,
  });
}