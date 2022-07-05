import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:tailorapp/Screens/DashBoard_Screens/home_page.dart';
import 'package:tailorapp/Screens/Settings%20Screen/setting_main.dart';
import 'package:tailorapp/Screens/login_screens/signin_main.dart';
import 'package:tailorapp/controller/product.dart';
import 'package:tailorapp/localization/localization_service.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_images.dart';
import 'package:tailorapp/utils/app_styles.dart';
import 'package:tailorapp/utils/loader.dart';
class MangeStichingScreen extends StatefulWidget {
  const MangeStichingScreen({Key? key}) : super(key: key);

  @override
  _MangeStichingScreenState createState() => _MangeStichingScreenState();
}

class _MangeStichingScreenState extends State<MangeStichingScreen> {
  var product= Get.put(ProductController());
  var lan=GetStorage();
  var loading =true;
  TextEditingController name = TextEditingController();
  final FocusNode fname = FocusNode();
  TextEditingController price = TextEditingController();
  final FocusNode fprice = FocusNode();
  openAlertBox() {

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return AlertDialog(

              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 15,),
                    Center(
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Center(
                            child: Text("add_product".tr,style: popup,textAlign: TextAlign.center,)),),
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      margin: const EdgeInsets.only(left: 50,right: 50),
                      child: InkWell(

                        onTap:(){
                          Get.back();
                        },
                        child: Container(
                          width: widthSize*0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: widthSize*0.3,
                                height: heightSize*0.080,
                                child: TextFormField(
                                  // textDirection: TextDirection.ltr,
                                  controller: name,
                                  focusNode: fname,
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
                                    hintText: "enter_Product_Name".tr,
                                    //make hint text
                                    hintStyle: formhinttext,
                                    //create lable
                                    labelText: 'enter_Product_Name'.tr,
                                    //lable style
                                    labelStyle: formlabelStyle,
                                  ),
                                ),
                              ),
                              SizedBox(height: heightSize*0.025,),
                              Container(
                                width: widthSize*0.3,
                                height: heightSize*0.080,
                                child: TextFormField(
                                  // textDirection: TextDirection.ltr,
                                  keyboardType: TextInputType.number,
                                  controller: price,
                                  focusNode: fprice,
                                  style: fieldtext,
                                  decoration: InputDecoration(
                                    focusColor: Colors.red,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    fillColor: Colors.black,
                                    hintText: "${'Enter_Price_Per_Unit'.tr} (${product.unit.value})",
                                    //make hint text
                                    hintStyle: formhinttext,
                                    //create lable
                                    labelText: '${'Enter_Price_Per_Unit'.tr} (${product.unit.value})',
                                    //lable style
                                    labelStyle: formlabelStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: heightSize*0.055,),
                    Container(
                      margin: const EdgeInsets.only(left: 50,right: 50),
                      child: InkWell(

                        onTap:()async{
                          product.set_product(name.text,price.text);
                          var a = await product.create_products();
                          if(a){
                            name.clear();
                            price.clear();
                            load_data();
                            Get.back();
                          }
                          else{
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    content: Container(
                                      // height: 260,
                                      // width: 400,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)
                                      ),

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 20,),
                                          // Image.asset("assets/images/bell.png",
                                          //   height: 50,),
                                          Container(
                                              width: 200,
                                              // height: 60,
                                              margin: const EdgeInsets.only(left: 10,right: 10),
                                              child: Lottie.asset('assets/animation/wrong.json', height: 120)),
                                          const SizedBox(height: 30,),
                                          Text("product_exist".tr,textAlign: TextAlign.center,
                                            style: popup,),
                                          const SizedBox(height: 20,),
                                          // Text(
                                          //   " Please login to your email account and verify Your Email",
                                          //   style: popup,
                                          //   textAlign: TextAlign.center,),
                                          // SizedBox(height: 30,),
                                          Center(
                                            child: InkWell(
                                              onTap: () {
                                                // Get.to(ShopDetail());
                                                Navigator.pop(context);
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
                                                    "Ok".tr,textDirection: text_direction, style: buttontext,),
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

                          }

                        },
                        child: Container(
                          width:  60,
                          height: 40,
                          decoration: BoxDecoration(
                            color: buttoncolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child:  Text(
                              "Save".tr,
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
  editAlertBox(id,index) {

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return AlertDialog(

              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15,),
                    Center(
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Center(
                            child: Text("Update_Product".tr,style: popup,textAlign: TextAlign.center,)),),
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      margin: const EdgeInsets.only(left: 50,right: 50),
                      child: InkWell(
                        onTap:(){
                          Get.back();
                        },
                        child: Container(
                          width: widthSize*0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: widthSize*0.3,
                                height: heightSize*0.080,
                                child: TextFormField(
                                  // textDirection: TextDirection.ltr,
                                  controller: name,
                                  focusNode: fname,
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
                                    hintText: "enter_Product_Name".tr,
                                    //make hint text
                                    hintStyle: formhinttext,
                                    //create lable
                                    labelText: 'enter_Product_Name'.tr,
                                    //lable style
                                    labelStyle: formlabelStyle,
                                  ),
                                ),
                              ),
                              SizedBox(height: heightSize*0.025,),
                              Container(
                                width: widthSize*0.3,
                                height: heightSize*0.080,
                                child: TextFormField(
                                  // textDirection: TextDirection.ltr,
                                  controller: price,
                                  focusNode: fprice,
                                  keyboardType: TextInputType.number,
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
                                    hintText: "${'Enter_Price_Per_Unit'.tr} (${product.unit.value})",
                                    //make hint text
                                    hintStyle: formhinttext,
                                    //create lable
                                    labelText: '${'Enter_Price_Per_Unit'.tr} (${product.unit.value})',
                                    //lable style
                                    labelStyle: formlabelStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: heightSize*0.055,),
                    Container(
                      margin: const EdgeInsets.only(left: 50,right: 50),
                      child: InkWell(

                        onTap:()async{
                          product.set_product(name.text,price.text);
                          var a = await product.update_products(id,index);
                          if(a) {
                            load_data();
                            name.clear();
                            price.clear();
                            Get.back();
                          }
                          else{
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    content: Container(
                                      // height: 260,
                                      // width: 400,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)
                                      ),

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 20,),
                                          // Image.asset("assets/images/bell.png",
                                          //   height: 50,),
                                          Container(
                                              width: 200,
                                              // height: 60,
                                              margin: const EdgeInsets.only(left: 10,right: 10),
                                              child: Lottie.asset('assets/animation/wrong.json', height: 120)),
                                          const SizedBox(height: 30,),
                                          Text("product_exist".tr,textAlign: TextAlign.center,
                                            style: popup,),
                                          const SizedBox(height: 20,),
                                          // Text(
                                          //   " Please login to your email account and verify Your Email",
                                          //   style: popup,
                                          //   textAlign: TextAlign.center,),
                                          // SizedBox(height: 30,),
                                          Center(
                                            child: InkWell(
                                              onTap: () {
                                                // Get.to(ShopDetail());
                                                Navigator.pop(context);
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
                                                    "Ok".tr,textDirection: text_direction, style: buttontext,),
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

                          }


                        },
                        child: Container(
                          width:  60,
                          height: 40,
                          decoration: BoxDecoration(
                            color: buttoncolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child:  Text(
                              "Save".tr,
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
  load_data()async{
    await product.get_products();
    loading=false;
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load_data();
  }
  LogoutBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double widthSize = MediaQuery.of(context).size.width;
          final double heightSize = MediaQuery.of(context).size.height;
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: const EdgeInsets.only(top: 30.0),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    const SizedBox(height: 20,),
                     Text("Logout".tr,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                     Text("Are_You_Sure".tr,style: TextStyle(color: Colors.black,fontSize: 16,),textAlign: TextAlign.center,),
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
                                child: Text(
                                  "Logout".tr,
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
  @override

  Widget build(BuildContext context) {

    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    var lan=GetStorage();
    return Directionality(
      textDirection:text_direction,
      child: Scaffold(
        // drawer: Drawer(
        //   child: Drawertrail(),
        // ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            iconTheme: const IconThemeData(color: iconscolor),
            toolbarHeight: 40,
            automaticallyImplyLeading: false,
            centerTitle: false,
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
                Text(
                  "manage_stiching_product".tr,
                  style: appbartext,
                ),
              ],
            ),
            actions: [
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
            leading: InkWell(
              onTap: () {
                Get.to(const SettingMain());
              },
              child:const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(left: widthSize*0.10,right: widthSize*0.10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: heightSize*0.045,),
                Container(
                  width: widthSize,
                  height: heightSize*0.090,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("list_of_all_stitching_product".tr,style: mtext,),
                      InkWell(
                        onTap: (){
                          openAlertBox();
                        },
                        child: Container(
                          height: heightSize*0.060,
                          width: widthSize*0.13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: buttoncolor
                          ),
                          child: Center(
                            child: Text("add_product".tr,style: buttontext,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: heightSize*0.015,),
                Container(
                  height: heightSize*0.7,
                  child:     loading?const Center(child: Loader(),):Obx(()=>


                      product.data.length==0? Center(child: Text("No_products_available".tr),):
                      ListView.builder(
                        physics:  const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 20),
                        itemCount: product.data.length,
                        itemBuilder: (BuildContext context,int index){
                          return Container(
                            margin: EdgeInsets.only(left: widthSize*0.06,right: widthSize*0.06,bottom: heightSize*0.015),
                            width: widthSize,
                            height: heightSize*0.14,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xffDDDDDD),
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
                                Container(
                                  margin: const EdgeInsets.only(left: 5,right: 5),
                                  height: heightSize*0.05,
                                  width: widthSize*0.1,
                                  child: Center(
                                    child:Text("${product.data.value[index]['name']}",style: boldregulartext,),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 5,left:5),
                                      height: heightSize*0.05,
                                      width: widthSize*0.08,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: Colors.grey.withOpacity(0.3)
                                      ),
                                      child: Center(
                                        child: Text("${product.data.value[index]['price']} ${product.data.value[index]['unit']}",style: boldregulartext,),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            name.text=product.data.value[index]['name'];
                                            price.text=product.data.value[index]['price'];
                                            editAlertBox(product.data.value[index]['id'],index);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Image.asset("assets/icons/edit.png"),
                                          ),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            showDialog(context: context, builder: (BuildContext context) {
                                              return  AlertDialog(
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                                                content: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const SizedBox(height: 15,),
                                                    Container(
                                                        width: 120,
                                                        // height: 60,
                                                        margin: const EdgeInsets.only(left: 10,right: 10),
                                                        child: Lottie.asset('assets/animation/delete.json', height: 120)),
                                                    Center(child: Text("Are_You_Sure_you_want_to_delete".tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),)),
                                                    const SizedBox(height: 15,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            await product.delete_products(product.data.value[index]['id'], index);
                                                            load_data();
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                                color: buttoncolor,
                                                                borderRadius: BorderRadius
                                                                    .circular(15)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "Yes".tr, style: buttontext,),
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: (){
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                                color: buttoncolor,
                                                                borderRadius: BorderRadius
                                                                    .circular(15)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "No".tr, style: buttontext,),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              );
                                            }
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Image.asset("assets/icons/delete.png"),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),

                              ],
                            ),
                          );
                        }
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.045,)

              ],

            ),
          ),
        ),
      ),
    );
  }
}
