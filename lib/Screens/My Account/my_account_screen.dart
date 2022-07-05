import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:tailorapp/CoolDropDown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:tailorapp/Screens/DashBoard_Screens/home_page.dart';
import 'package:tailorapp/Screens/Settings%20Screen/setting_main.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/cont_city.dart';
import 'package:tailorapp/controller/country.dart';
import 'package:tailorapp/controller/myaccount.dart';
import 'package:tailorapp/controller/signin.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/drawer.dart';
import 'package:tailorapp/utils/loader.dart';
class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  MyAccountState createState() => MyAccountState();
}

class MyAccountState extends State<MyAccount> {
  var obj=Get.put(MyAccountCon());
  var obg=Get.put(CountryController());
  var obj2=Get.put(country_controller_());
  TextEditingController name = TextEditingController();
  final FocusNode fname = FocusNode();
  TextEditingController lname = TextEditingController();
  final FocusNode flname = FocusNode();
  TextEditingController number = TextEditingController();
  final FocusNode fnumber = FocusNode();
  TextEditingController whatsapp = TextEditingController();
  final FocusNode fwhatsapp = FocusNode();
  TextEditingController email = TextEditingController();
  final FocusNode femail = FocusNode();
  TextEditingController state = TextEditingController();
  final FocusNode fstate = FocusNode();
  TextEditingController dob = TextEditingController();
  final FocusNode fdob = FocusNode();
  TextEditingController area = TextEditingController();
  final FocusNode farea = FocusNode();
  TextEditingController country = TextEditingController();
  final FocusNode fcountery = FocusNode();
  TextEditingController address = TextEditingController();
  final FocusNode faddress = FocusNode();
  bool _isVisible = false;
  var lan=GetStorage();
  var imageshow;
  var code="";
  var name_valid = "";
  var last_name_valid = "";
  var email_valid = "";
  var phone_valid = "";
  var whatsapp_valid = "";
  var state_valid = "";
  var dob_valid = "";
  var area_valid = "";
  var countery_valid = "";
  var address_valid = "";
  List dropdowncounteryList = [];
  List dropdownprovinceList = [];
  List dropdowncityList = [];
  var currendt_gender_index=-1;
  var cur_gender_index=-1;
  var current_country="";
  var current_province="";
  var current_city="";
  var current_gender="";
  List dropdownGenderList = [
    {
      'label': 'Male'.tr,
      'value': "1",
      'icon': const SizedBox(
        height: 25,
        width: 25,
        // child: SvgPicture.asset("assets/icons/check.svg"),
      ),
      'selectedIcon': SizedBox(
        key: UniqueKey(),
        width: 20,
        height: 20,
        child: SvgPicture.asset("assets/icons/check.svg"),
      ),
    },
    {
      'label': 'Female'.tr,
      'value': "2",
      'icon': const SizedBox(
        height: 25,
        width: 25,
        // child: SvgPicture.asset("assets/icons/check.svg"),
      ),
      'selectedIcon': SizedBox(
        key: UniqueKey(),
        width: 20,
        height: 20,
        child: SvgPicture.asset("assets/icons/check.svg"),
      ),
    },
    {
      'label': 'Other'.tr,
      'value': "3",
      'icon': const SizedBox(
        height: 25,
        width: 25,
        // child: SvgPicture.asset("assets/icons/check.svg"),
      ),
      'selectedIcon': SizedBox(
        key: UniqueKey(),
        width: 20,
        height: 20,
        child: SvgPicture.asset("assets/icons/check.svg"),
      ),
    },
    {
      'label': 'Prefer Not to Say'.tr,
      'value': "4",
      'icon': const SizedBox(
        height: 25,
        width: 25,
        // child: SvgPicture.asset("assets/icons/check.svg"),
      ),
      'selectedIcon': SizedBox(
        key: UniqueKey(),
        width: 20,
        height: 20,
        child: SvgPicture.asset("assets/icons/check.svg"),
      ),
    },
  ];
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  List dropdowncounterycode = [];
  List<String> codes = [
    '+971',
    '+920',
    '+921',
    '+923',
  ];
  final ImagePicker _picker = ImagePicker();
  @override
  var date= TextEditingController();
  DateTime selectedDate = DateTime.now();
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
                     Text("log_out".tr,style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                     Text("are_you_sure".tr,style: const TextStyle(color: Colors.black,fontSize: 16,),textAlign: TextAlign.center,),
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
                                  color: Colors.red,
                                  width: 1
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child:  Text(
                                "back".tr,
                                style: const TextStyle(color: buttoncolor,fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        InkWell(

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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1800),
        lastDate: DateTime(2101)
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date.text=picked.toLocal().toString().split(" ")[0];
      });
    }
  }
  var _image=null;
  var show_province=false;
  var show_city=false;
  var image_url="";
  XFile? image;
  var cur_cont_index=0;
  var cur_province_index=0;
  get_province(cont,selected,selected_city) async {
    setState(() {
      show_province=false;
      show_city=false;
    });
    await obj2.getprovance(cont,selected);
    if(obj2.province.length>0){
      setState(() {
        show_province=true;
      });
      get_city(obj2.province.value[obj2.cur_province_index.value]['label'],selected_city);
    }
    else{
      setState(() {
        show_province=false;
        // show_city=false;
      });
    }

  }
  get_city(cont,selected) async {
    // print("Selected city ${selected}");
    setState(() {
      show_city=false;
    });
    // print("get city");
    await obj2.getarea(cont,selected);
    if(obj2.area.length>0){
      setState(() {
        show_city=true;
      });
    }
    else{
      setState(() {
        show_city=false;
      });
    }
  }
  var loading=true;
  var signin= Get.put(SigninController());
  var cur_code=0;
  openAlertBox() {

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: 200,
                        // height: 60,
                        margin: const EdgeInsets.only(left: 10,right: 10),
                        child: Lottie.asset('assets/icons/confirm.json', height: 120)),
                    // Container(
                    //   height: 60,
                    //     child: Image.asset("assets/icons/lock.png",)),
                    const SizedBox(height: 15,),
                    Center(
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Center(
                            child: Text("Profile_Updated".tr,style: popup,textAlign: TextAlign.center,)),),
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      margin: const EdgeInsets.only(left: 50,right: 50),
                      child: InkWell(

                        onTap:(){
                         Get.back();
                        },
                        child: Container(
                          width:  60,
                          height: 40,
                          decoration: BoxDecoration(
                            color: buttoncolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "ok".tr,
                              style: const TextStyle(color: Colors.white,fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),

                  ],
                ),
              )
          );
        });
  }
  loaddata() async {
    await obj.get_my_account();
    print("scsdv ${obj.data_profile.value}");
    name.text=obj.data_profile.value['full_name']??"";
    number.text=obj.data_profile.value['phone']??"";
    email.text=obj.data_profile.value['email']??"";
    address.text=obj.data_profile.value['address']??"";
    whatsapp.text=obj.data_profile.value['whatsapp']??"";
    date.text=obj.data_profile.value['dob']??"";
    image_url=obj.data_profile.value['image']??"";
    address.text=obj.data_profile.value['address']??"";
    // var gend=obj.data_profile.value['gender']??"";
    if(obj.data_profile.value['gender']!=null){
      currendt_gender_index=int.parse(obj.data_profile.value['gender'].toString())-1;
      // print("gender now ${currendt_gender_index}");
      setState(() {

      });
      // var t = ["Male",'Female',]
    }
    // print("gend ${gend}");
    for (var i = 0; i < obg.data.length; i++) {
      if(obj.data_profile.value['country'] == obg.data.value[i]['country']){
        cur_cont_index=i;
      }
      dropdowncounteryList.add({
        'label': '${obg.data.value[i]['country']}',
        'value': i,
        'icon': const SizedBox(
          height: 25,
          width: 25,
          // child: SvgPicture.asset("assets/icons/check.svg"),
        ),
        'selectedIcon': SizedBox(
          key: UniqueKey(),
          width: 20,
          height: 20,
          child: SvgPicture.asset("assets/icons/check.svg"),
        ),
      });

    }
    for (var i = 0; i < obg.data.length; i++) {
      if(obg.data[i]['phone_code']==obj.data_profile.value['phone_code']){
        cur_code=i;
      }
      dropdowncounterycode.add({
        'label': '${obg.data.value[i]['phone_code']}',
        'value':i,
        'icon': SizedBox(
          height: 25,
          width: 25,
          child: Image.network(obg.data.value[i]['country_flag']),
        ),
        'selectedIcon': SizedBox(
          key: UniqueKey(),
          width: 20,
          height: 20,
          child: SvgPicture.asset("assets/icons/check.svg"),
        ),
      });
    }
    loading=false;
    await get_province(obj.data_profile.value['country'],obj.data_profile.value['province']??"",obj.data_profile.value['city']??"");

    setState(() {

    });
    // fnazme.text=profile.data_profile.value[''];
  }
  void initState() {
    loaddata();

    fname.addListener(() {
      print("focus node");
      if (!fname.hasFocus) {
        if (name.text.isEmpty) {
          name_valid = 'required'.tr;
          setState(() {});
          return;
        } else {
          name_valid = "null";
          setState(() {});
          return;
        }
      }
    });


    faddress.addListener(() {
      print("focus node");
      if (!faddress.hasFocus) {
        if (address.text.isEmpty) {
          address_valid = 'required'.tr;
          setState(() {});
          return;
        } else {
          address_valid  = "null";
          setState(() {});
          return;
        }
      }
    });
    femail.addListener(() {
      print("focus node");
      if (!femail.hasFocus) {
        if (email.text.isEmpty) {
          email_valid ='required'.tr;
          setState(() {});
          return;
        } else {
          email_valid = "null";
          setState(() {});
          return;
        }
      }
    });

    fcountery.addListener(() {
      print("focus node");
      if (!fcountery.hasFocus) {
        if (country.text.isEmpty) {
          countery_valid ='required'.tr;
          setState(() {});
          return;
        } else {
          countery_valid = "null";
          setState(() {});
          return;
        }
      }
    });
    fnumber.addListener(() {
      print("focus node");
      if (!fnumber.hasFocus) {
        if (number.text.trim().isEmpty) {
          phone_valid = 'required'.tr;
          setState(() {});
          return;
        }

        else if(obg.data.value[cur_cont_index]['phone_exm'].length >number.text.length ){
          phone_valid = "${'required'.tr} ${obg.data.value[cur_cont_index]['phone_exm'].length} Digits #";
          setState(() {});
          return;
        }else if(obg.data.value[cur_cont_index]['phone_exm'].length <number.text.length ){
          phone_valid = "${'required'.tr} ${obg.data.value[cur_cont_index]['phone_exm'].length} Digits #";
          setState(() {});
          return;
        }else {
          phone_valid ="null";
          setState(() {});
          return;
        }
      }
    });
    fwhatsapp.addListener(() {
      print("focus node");
      if (!fwhatsapp.hasFocus) {
        if (whatsapp.text.trim().isEmpty) {
          whatsapp_valid = 'required'.tr;
          setState(() {});
          return;
        }  else if(obg.data.value[cur_cont_index]['phone_exm'].length >whatsapp.text.length ){
          whatsapp_valid = "${'required'.tr} ${obg.data.value[cur_cont_index]['phone_exm'].length} Digits #";
          setState(() {});
          return;
        }else if(obg.data.value[cur_cont_index]['phone_exm'].length <whatsapp.text.length ){
          whatsapp_valid = "${'required'.tr} ${obg.data.value[cur_cont_index]['phone_exm'].length} Digits # ";
          setState(() {});
          return;
        }else {
          whatsapp_valid = "null";
          setState(() {});
          return;
        }
      }
    });
    fstate.addListener(() {
      print("focus node");
      if (!fstate.hasFocus) {
        if (state.text.isEmpty) {
          state_valid = "required".tr;
          setState(() {});
          return;
        } else {
          state_valid = "null";
          setState(() {});
          return;
        }
      }
    });
    farea.addListener(() {
      print("focus node");
      if (!farea.hasFocus) {
        if (area.text.isEmpty) {
          area_valid = "required".tr;
          setState(() {});
          return;
        } else {
          area_valid = "null";
          setState(() {});
          return;
        }
      }
    });
    fdob.addListener(() {
      print("focus node");
      if (!fdob.hasFocus) {
        if (dob.text.isEmpty) {
          dob_valid = "required".tr;
          setState(() {});
          return;
        } else {
          dob_valid = "null";
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
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        // drawer: const Drawer(
        //   child: Drawertrail(),
        // ),
        backgroundColor: bgcolor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child:const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
            ),
            toolbarHeight: 40,
            iconTheme: const IconThemeData(color: Colors.black),
            // automaticallyImplyLeading: false,
            backgroundColor: APPBARCOLOR,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 5,top: 5),
                  child: Image.asset(
                    logo_png,
                    height: 30,
                  ),),
                const SizedBox(width: 20,),
                Text("Account_Profile_Update".tr,style: appbartext,),
              ],
            ),
              actions: [
                // Container(
                //     padding: const EdgeInsets.all(5),
                //     height: 35,
                //     child: Image.asset(
                //       logo_png,
                //       height: 20,
                //     )),

                GestureDetector(
                  onTap: () {
                    Get.to(const HomePage());
                  },
                  child: Icon(Icons.home_outlined,size: 35,color: buttontextcolor.withOpacity(0.6),),
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
                  child: Image.asset(
                    icon_logout,
                    height: 35,
                    width: 35,
                  ),
                ),
        ],

          ),
        ),
        body:
        loading?const Center(child: Loader(),):
        SingleChildScrollView(
          child: Directionality(
            textDirection:text_direction,
            child:
            GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus( FocusNode());
              },
              child: Container(
                margin:
                EdgeInsets.only(left: widthSize * 0.15, right: widthSize * 0.15),
                child: Column(
                  children: [
                    SizedBox(
                      height: heightSize * 0.05,
                    ),
                    //image container
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          image: _image!=null?DecorationImage(
                            image:FileImage(File(image!.path.toString())),
                            fit: BoxFit.fill,
                          ):DecorationImage(image: NetworkImage(image_url),fit: BoxFit.fill,),
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.black12,
                          width: 2
                        )
                      ),
                      child:  InkWell(
                        onTap: () async {
                          showDialog(context: context, builder: (BuildContext context) {
                              return StatefulBuilder(builder: (context, MAPsetState) {
                                return AlertDialog(
                                  content: Container(
                                    height:260 ,
                                    width: 400,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height:200 ,
                                          width: 400,
                                          decoration: BoxDecoration(
                                            image: _image!=null?DecorationImage(
                                              image:FileImage(File(image!.path.toString())),
                                              fit: BoxFit.fill,
                                            ):DecorationImage(image: NetworkImage(image_url),fit: BoxFit.fill,),
                                            // color: Colors.white,

                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap:() async {
                                                image = await  _picker.pickImage(
                                                    source: ImageSource.gallery, imageQuality: 50
                                                );

                                                final bytes = File(image!.path).readAsBytesSync();
                                                _image =  "data:image/png;base64,"+base64Encode(bytes);
                                                // print(_image);
                                                // image
                                                MAPsetState((){});
                                                setState(() {
                                                  // imageshow= File(_image.path);
                                                });
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    color: buttoncolor,
                                                    borderRadius: BorderRadius
                                                        .circular(15)
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Change_Photo".tr, style: buttontext,),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap:(){
                                                Get.back();
                                              },
                                              child:Container(
                                                height: 40,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    color: buttoncolor,
                                                    borderRadius: BorderRadius
                                                        .circular(15)
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Cancel".tr, style: buttontext,),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });

                          }
                          );

                      },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: const EdgeInsets.only(left: 50,bottom: 5,right: 50),
                              child: const Icon(Icons.camera_enhance_outlined)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightSize * 0.05,
                    ),
                    //Name field whatsapp
                    Directionality(
                      textDirection:text_direction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            // width: widthSize * 0.300,
                            height: heightSize*0.080,
                            child: TextFormField(
                              // textDirection: TextDirection.ltr,
                              controller: name,
                              focusNode: fname,
                              style: fieldtext,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fillColor: Colors.black,
                                hintText: "Enter_Full_Name".tr,
                                hintStyle: formhinttext,
                                labelText: 'Full_Name'.tr,
                                labelStyle: formlabelStyle,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          name_valid == "" || name_valid == "null"
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
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                     // mobile whatsapp field
                    Directionality(
                      textDirection:text_direction,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: widthSize * 0.15,
                                height: heightSize*0.080,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 1
                                  ),
                                ),
                                child: Center(
                                  child: CoolDropdown(
                                    dropdownWidth: widthSize * 0.1,
                                    dropdownHeight: 150,
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
                                    dropdownItemReverse:true,
                                    resultWidth: widthSize * 0.17,
                                    dropdownList: dropdowncounterycode,
                                    defaultValue: dropdowncounterycode[cur_code],
                                    isResultLabel: true,
                                    gap: 4,
                                    placeholder: "+92",

                                    placeholderTS: TextStyle(
                                        fontSize:  widthSize*0.014,
                                        color:  const Color(0xff8a8a8a),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins"),
                                    selectedItemBD: BoxDecoration(

                                      borderRadius: BorderRadius.circular(5),

                                    ),
                                    selectedItemTS: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff0037da),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                    resultTS: TextStyle(
                                        fontSize:  widthSize*0.014,
                                        color:  const Color(0xff8a8a8a),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                    unselectedItemTS: TextStyle(
                                        fontSize:  widthSize*0.014,
                                        color: const Color(0xff212121),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                    onChange: (a) {

                                      setState(() {
                                        cur_cont_index=a['value'];
                                        // print("currentvalue${cur_cont_index}");
                                        code=a["label"];
                                        if (number.text.trim().isEmpty) {
                                          phone_valid ="";
                                          setState(() {});
                                          return;
                                        }
                                        else if(obg.data.value[cur_cont_index]['phone_exm'].length >number.text.length ){
                                          phone_valid = "${'required'.tr} ${obg.data.value[cur_cont_index]['phone_exm'].length} Digits #";
                                          setState(() {});
                                          // return;
                                        }
                                        else if(obg.data.value[cur_cont_index]['phone_exm'].length <number.text.length ){
                                          phone_valid = "${'required'.tr} ${obg.data.value[cur_cont_index]['phone_exm'].length} Digits #";
                                          setState(() {});
                                          // return;
                                        }else {
                                          phone_valid = "null";
                                          setState(() {});
                                          // return;
                                        }
                                        if (whatsapp.text.trim().isEmpty) {
                                          whatsapp_valid = "";
                                          setState(() {});
                                          return;
                                        }
                                        else if(obg.data.value[cur_cont_index]['phone_exm'].length >whatsapp.text.length ){
                                          whatsapp_valid =  "${obg.data.value[cur_cont_index]['phone_exm'].length} digits #";
                                          setState(() {});
                                        }else if(obg.data.value[cur_cont_index]['phone_exm'].length <whatsapp.text.length ){
                                          whatsapp_valid = "${'required'.tr} ${obg.data.value[cur_cont_index]['phone_exm'].length} digits # ";
                                          setState(() {});
                                          // return;
                                        }else {
                                          whatsapp_valid = "null";
                                          setState(() {});
                                          // return;
                                        }
                                      });
                                    },
                                    // dropdownItemReverse: false,
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
                              const SizedBox(height: 5,),

                            ],
                          ),
                          // mobile number
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: widthSize * 0.25,
                                height: heightSize*0.080,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textDirection: text_direction,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(obg.data.value[cur_cont_index]['phone_exm'].length),
                                  ],
                                  controller: number,
                                  focusNode: fnumber,
                                  style: fieldtext,

                                  decoration:
                                  InputDecoration(
                                    focusColor: Colors.white,
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    fillColor: Colors.black,
                                    hintText: "${obg.data.value[cur_cont_index]['phone_exm']}",
                                    //make hint text
                                    hintStyle: formhinttext,
                                    //create lable
                                    labelText:'Your_Mobile_Number'.tr,
                                    // //lable style
                                    labelStyle: formlabelStyle,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              phone_valid == "" || phone_valid == "null"
                                  ?const SizedBox():Text(phone_valid,
                                style: TextStyle(
                                  fontSize:14,
                                  color: phone_valid == ""
                                      ? const Color(0xffC1C1C1)
                                      : Colors.red,
                                  fontWeight: FontWeight.w500,

                                ),
                              )
                            ],
                          ),
                          //whatsapp number
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: widthSize * 0.25,
                                  height: heightSize*0.080,
                                  child:
                                  // lan.read("status")=="Arabic"?
                                  TextFormField(
                                    textDirection:text_direction,
                                    controller: whatsapp,
                                    focusNode: fwhatsapp,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                                      FilteringTextInputFormatter.digitsOnly,
                                      // LengthLimitingTextInputFormatter(obj.cur_code.value[obj.current_country.value]['phone_exm'].length),
                                    ],
                                    style: fieldtext,
                                    decoration: InputDecoration(
                                      focusColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        const BorderSide(color: Colors.black, width: 1.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      fillColor: Colors.black,
                                      hintText: "${obg.data.value[cur_cont_index]['phone_exm']}",
                                      //make hint text
                                      hintStyle: formhinttext,
                                      //create lable
                                      labelText: 'Whatsapp_#'.tr,
                                      //lable style
                                      labelStyle: formlabelStyle,
                                    ),
                                  )
                              ),
                              const SizedBox(height: 5,),
                              whatsapp_valid== "" || whatsapp_valid== "null"
                                  ?const SizedBox():Text(
                                whatsapp_valid ,
                                style: TextStyle(
                                  fontSize:14,
                                  color: whatsapp_valid  == ""
                                      ? const Color(0xffC1C1C1)
                                      : Colors.red,
                                  fontWeight: FontWeight.w500,

                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: heightSize*0.02,),
                    Directionality(
                      textDirection:text_direction,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Email
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email".tr,style: mtext,),
                              const SizedBox(height: 3,),
                              SizedBox(
                                width: widthSize * 0.33,
                                height: heightSize*0.080,
                                child: Directionality(
                                  textDirection:text_direction,
                                  child: TextFormField(
                                    textDirection:text_direction,
                                    controller: email,
                                    focusNode: femail,
                                    style: fieldtext,
                                    decoration:
                                    InputDecoration(
                                      focusColor: Colors.white,
                                      //add prefix icon
                                      suffix: Container(
                                        height: 20,
                                        width: 20,
                                        margin: const EdgeInsets.only(left: 10,top: 20,right: 10),
                                        child:const FaIcon(
                                          FontAwesomeIcons.envelope,
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
                                      hintText: "Enter_Your_Email".tr,
                                      //make hint text
                                      hintStyle: formhinttext,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              email_valid == "" || email_valid =="null"?const SizedBox():
                              Text(
                                 email_valid ,
                                style: TextStyle(
                                  fontSize:14,
                                  color: email_valid  == ""
                                      ? const Color(0xffC1C1C1)
                                      : Colors.red,
                                  fontWeight: FontWeight.w500,

                                ),
                              )
                            ],
                          ),
                          //Gender number
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Gender".tr,style: mtext,),
                              const SizedBox(height: 3,),
                              Container(
                                width: widthSize * 0.33,
                                height: heightSize*0.080,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 1
                                  ),
                                ),
                                child: Center(
                                  child: CoolDropdown(
                                    dropdownWidth: widthSize * 0.33,
                                    dropdownHeight: 150,
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
                                    resultWidth: widthSize * 0.33,
                                    dropdownList: dropdownGenderList,
                                    defaultValue: currendt_gender_index==-1?null:dropdownGenderList[currendt_gender_index],
                                    isResultLabel: true,
                                    gap: 4,
                                    placeholder: "Gender".tr,
                                    placeholderTS:const TextStyle(
                                        fontSize:  14,
                                        color:  Colors.black,
                                        fontWeight: FontWeight.bold,

                                        fontFamily: "Poppins"),
                                    selectedItemBD: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),

                                    ),
                                    selectedItemTS: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff0037da),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                    resultTS:const TextStyle(
                                        fontSize:  14,
                                        color:  Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                    unselectedItemTS:const TextStyle(
                                        fontSize:  15,
                                        color: Color(0xff212121),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                    onChange: (a) {
                                      setState(() {
                                        current_gender=a['value'];
                                        // code=a["label"];
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
                              const SizedBox(height: 5,),
                              Container(
                                width: widthSize * 0.1,
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: heightSize*0.015,),
                    //date of birth and country field
                    Directionality(
                      textDirection:text_direction,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //date of birth
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date_of_Birth".tr,style: mtext,),
                              const SizedBox(height: 3,),
                              InkWell(
                                onTap: () async {
                                  await _selectDate(context);
                                  // date.text="${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                                },
                                child: SizedBox(
                                  width: widthSize * 0.33,
                                  height: heightSize*0.080,
                                  child: Center(
                                    child: AbsorbPointer(
                                      child: TextFormField(

                                        controller: date,
                                        textDirection:text_direction,
                                        // controller: entery,
                                        // focusNode: fentery,
                                        style: fieldtext,
                                        decoration:
                                        InputDecoration(
                                          contentPadding: const EdgeInsets.all(10),
                                          focusColor: Colors.white,
                                          //add prefix icon
                                          suffix: Container(
                                            height: 20,
                                            width: 20,
                                            margin: const EdgeInsets.only(right: 10,left:10),
                                            child: const FaIcon(
                                              FontAwesomeIcons.calendar,
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
                                          hintText: "Date_of_Birth".tr,
                                          //make hint text
                                          hintStyle: formhinttext,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              dob_valid == "" || dob_valid == ""
                                  ?const SizedBox():Text(dob_valid ,
                                style: TextStyle(
                                  fontSize:14,
                                  color: dob_valid  == ""
                                      ? const Color(0xffC1C1C1)
                                      : Colors.red,
                                  fontWeight: FontWeight.w500,

                                ),
                              )
                            ],
                          ),

                          //Countery
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Country".tr,style: mtext,),
                              const SizedBox(height: 3,),
                              Container(
                                width: widthSize * 0.33,
                                height: heightSize*0.080,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 1
                                  ),
                                ),
                                child: Center(
                                  child: CoolDropdown(
                                    dropdownWidth: widthSize * 0.33,
                                    dropdownHeight: 150,
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
                                    resultWidth: widthSize * 0.33,
                                    dropdownList: dropdowncounteryList,
                                    defaultValue: dropdowncounteryList[cur_cont_index] ,
                                    isResultLabel: true,
                                    gap: 4,
                                    placeholder: "Pakistan".tr,

                                    placeholderTS:const TextStyle(
                                        fontSize:  14,
                                        color:  Colors.black,
                                        fontWeight: FontWeight.bold,

                                        fontFamily: "Poppins"),
                                    selectedItemBD: BoxDecoration(

                                      borderRadius: BorderRadius.circular(5),

                                    ),
                                    selectedItemTS: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff0037da),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                    resultTS:const TextStyle(
                                        fontSize:  14,
                                        color:  Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                    unselectedItemTS:const TextStyle(
                                        fontSize:  15,
                                        color: Color(0xff212121),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                    onChange: (a) {
                                      get_province(a['label'], "","");
                                      setState(() {
                                        current_country=a["label"];
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
                              const SizedBox(height: 5,),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: heightSize*0.015,),
                    //City/Area and State/Province field
                    Directionality(
                      textDirection:text_direction,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //State/Province
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("State/Province".tr,style: mtext,),
                              const SizedBox(height: 3,),
                              Container(
                                width: widthSize * 0.33,
                                height: heightSize*0.080,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 1
                                  ),
                                ),
                                child: Center(
                                  child: show_province? Obx(()=>
                                   CoolDropdown(
                                      dropdownWidth: widthSize * 0.33,
                                     dropdownHeight: 200,
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
                                      resultWidth: widthSize * 0.33,
                                      dropdownList: obj2.province.value,
                                      defaultValue: obj2.cur_province_index.value>obj2.province.length?null: obj2.province.value[obj2.cur_province_index.value],
                                      isResultLabel: true,
                                      gap: 4,
                                      placeholder: "Select_Province".tr,
                                      // dropdownItemPadding: EdgeInsets.only(left: 20,right: 20),
                                      // selectedItemPadding: EdgeInsets.only(left: 20,right: 20),
                                      placeholderTS:const TextStyle(
                                          fontSize:  14,
                                          color:  Color(0xff8a8a8a),
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
                                          color: Color(0xff0037da),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                      resultTS:const TextStyle(
                                          fontSize:  14,
                                          color:  Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                      unselectedItemTS:const TextStyle(
                                          fontSize:  15,
                                          color: Color(0xff212121),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                      onChange: (a) {
                                        get_city(a['label'],"");
                                        setState(() {
                                          current_province=a["label"];
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
                                  ): Text("Select_Country_First".tr),
                                ),
                              ),
                              const SizedBox(height: 5,),
                            ],
                          ),
                          //City/Area
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("City/Area".tr,style: mtext,),
                              const SizedBox(height: 3,),
                              Container(
                                width: widthSize * 0.33,
                                height: heightSize*0.080,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 1
                                  ),
                                ),
                                child: Center(
                                  child: show_city?Obx(()=>
                                   CoolDropdown(
                                      dropdownWidth: widthSize * 0.33,
                                     dropdownHeight: 200,
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
                                      resultWidth: widthSize * 0.33,
                                      dropdownList: obj2.area.value,
                                      defaultValue: obj2.cur_city_index.value>obj2.area.length?null:obj2.area.value[obj2.cur_city_index.value],
                                      isResultLabel: true,
                                      gap: 4,
                                      placeholder: "City/Area".tr,

                                      placeholderTS:const TextStyle(
                                          fontSize:  14,
                                          color:  Colors.black,
                                          fontWeight: FontWeight.bold,

                                          fontFamily: "Poppins"),
                                      selectedItemBD: BoxDecoration(

                                        borderRadius: BorderRadius.circular(5),

                                      ),
                                      selectedItemTS: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff0037da),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                      resultTS:const TextStyle(
                                          fontSize:  14,
                                          color:  Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                      unselectedItemTS:const TextStyle(
                                          fontSize:  15,
                                          color: Color(0xff212121),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                      onChange: (a) {

                                        setState(() {
                                          current_city=a["value"].toString();
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
                                  ):Text("Select_your_Province_first".tr),
                                ),
                              ),
                              const SizedBox(height: 5,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: heightSize*0.015,),
                    Directionality(
                      textDirection:text_direction,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Zip_Code".tr,style: mtext,),
                          const SizedBox(height: 3,),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            textDirection: text_direction,
                            controller: address,
                            focusNode: faddress,
                            style: fieldtext,
                            decoration:
                            InputDecoration(
                              focusColor: Colors.white,

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              focusedBorder:
                              OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.black,
                              hintText: "Zip_Code".tr,
                              //make hint text
                              hintStyle: formhinttext,

                            ),
                          ),
                          const SizedBox(height: 5,),
                          address_valid  == ""  || address_valid  == "null"
                              ?const SizedBox():Text(
                            address_valid  ,
                            style: TextStyle(
                              fontSize:14,
                              color: address_valid   == ""
                                  ? const Color(0xffC1C1C1)
                                  : Colors.red,
                              fontWeight: FontWeight.w500,

                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: heightSize * 0.015,
                    ),
                     // servive
                    //english
                    Center(
                      child: Container(
                        alignment: Alignment.center,

                        padding: const EdgeInsets.only(left: 15,right: 15),
                        width: widthSize * 0.6,
                        child: InkWell(
                          child:  Text('By_Pressing_Update_Profile'.tr,style: const TextStyle(fontSize: 18),),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightSize * 0.1,
                    ),
                    //Sign Up button
                    Center(
                      child: InkWell(
                        onTap: () async {
                          showDialog(context: context, builder: (BuildContext context) {
                            return  AlertDialog(
                              content: Container(
                                height:150 ,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),

                                child: const Center(child: Loader(),),
                              ),
                            );
                          }
                          );
                          var a = await obj.update_my_account(name.text, email.text, number.text, whatsapp.text, current_city, current_province, current_city, current_gender,address.text, _image, date.text);
                          Navigator.of(context).pop();
                          if(a){
                            openAlertBox();
                          }
                          else{
                            showDialog(context: context, builder: (BuildContext context) {
                              return  AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 20,),
                                    Container(
                                        width: 200,
                                        // height: 60,
                                        margin: const EdgeInsets.only(left: 10,right: 10),
                                        child: Lottie.asset('assets/icons/confirm.json', height: 120)),
                                    const SizedBox(height: 15,),
                                    Text("Please_resolve_following_errors".tr),
                                    const SizedBox(height: 5,),
                                    obj.update_error['email']!=null? Text("Email_Already_Exist".tr):const SizedBox(),
                                    const SizedBox(height: 5,),
                                    obj.update_error['phone']!=null? Text("Phone_number_Already_Exist".tr):const SizedBox(),
                                    const SizedBox(height: 5,),
                                    obj.update_error['whatsapp']!=null? Text("WhatsApp_number_Already_Exist".tr):const SizedBox(),
                                    const SizedBox(height: 5,),
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            color: buttoncolor,
                                            borderRadius: BorderRadius
                                                .circular(15)
                                        ),
                                        child: Center(
                                          child: Text(
                                            "ok".tr, style: buttontext,),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            );
                          }
                          // showDialog(context: context, builder: (BuildContext context) {
                          //   return  AlertDialog(
                          //     content: Container(
                          //       height:260 ,
                          //       width: 400,
                          //       decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(10)
                          //       ),
                          //
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           SizedBox(height: 20,),
                          //           Image.asset("assets/images/bell.png",height: 50,),
                          //           SizedBox(height: 30,),
                          //           Text("Thank You for joining us",style: popup,),
                          //           SizedBox(height: 20,),
                          //           Text(" Please login to your email account and verify Your Email",style: popup,textAlign: TextAlign.center,),
                          //           SizedBox(height: 30,),
                          //           Center(
                          //             child: InkWell(
                          //               onTap: (){
                          //                 Get.to(ShopDetail());
                          //                 // Navigator.pop(context);
                          //               },
                          //               child: Container(
                          //                 height: 40,
                          //                 width: 150,
                          //                 decoration: BoxDecoration(
                          //                     color: buttoncolor,
                          //                     borderRadius: BorderRadius.circular(15)
                          //                 ),
                          //                 child: Center(
                          //                   child: Text("Ok",style: buttontext,),
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   );
                          // }
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: buttoncolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: widthSize * 0.435,
                          height: heightSize*0.080,
                          child: Center(
                            child: Text(
                              "Update_Profile".tr,
                              style: buttontext,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: heightSize*0.2,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
