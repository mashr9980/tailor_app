import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/app_styles.dart';
class Customer_detail extends StatefulWidget {
  const Customer_detail({Key? key}) : super(key: key);

  @override
  _Customer_detailState createState() => _Customer_detailState();
}

class _Customer_detailState extends State<Customer_detail> {
  var lan=GetStorage();
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45.0),
        child: AppBar(

          title: Text("Customer_Details".tr,style: appbartext,),
          actions: [
            Container(
                padding: const EdgeInsets.all(5),
                height: 35,
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 20,
                )),
            const SizedBox(width: 25,),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                "assets/icons/setting.png",
                height: 60,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                "assets/icons/nbell.png",
                height: 60,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                "assets/icons/whats.png",
                height: 60,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                "assets/icons/logout.png",
                height: 60,
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
              size: 35,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              height: heightSize*0.2,
              width: widthSize,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Haham Ahmad",style: customerStyle,),
                  SizedBox(height: heightSize*0.020,),
                  Container(
                    height: heightSize*0.135,
                    width: widthSize*0.0800,
                    decoration: BoxDecoration(
                      color: buttoncolor,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: Icon(Icons.person,size: heightSize*0.060,color: Colors.white,),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              height: heightSize*0.15,
              width: widthSize,
              color: buttoncolor,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text("Email Addres",style: customerStyle2,),
                        SizedBox(height: 10,),
                        Text("hashamahmad717@gmail.com",style: customerStyle2,)

                      ],
                    ),
                    const SizedBox(width: 30,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text("Phone Number",style: customerStyle2,),
                        SizedBox(height: 10,),
                        Text("+923069009838",style: customerStyle2,)

                      ],
                    ),
                    const SizedBox(width: 30,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text("Deleviery Address",style: customerStyle2,),
                        SizedBox(height: 10,),
                        Text("DHA Phase 6 Lahore Pakistan",style: customerStyle2,)

                      ],
                    ),

                  ],
                ),
              ),

            ),
            const SizedBox(height: 30,),
            //buttons
            Container(
              height: heightSize*0.3,
              width: widthSize,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    // onTap: (){
                    //   Get.to(Customers());
                    // },
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: buttoncolor,
                            blurRadius: 5.0,
                            // offset: Offset(0.0, 0.5)
                          )
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.person,
                              size: 40,
                              color: buttoncolor,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Customers",
                              style: TextStyle(color: buttoncolor, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: widthSize*0.1,),
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow:const <BoxShadow>  [
                        BoxShadow(
                          color: buttoncolor,
                          blurRadius: 5.0,
                          // offset: Offset(0.0, 0.5)
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:const [
                          Text(
                            "45",
                            style: TextStyle(color: buttoncolor, fontSize: 30),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Orders",
                            style: TextStyle(color: buttoncolor, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: widthSize*0.1,),
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: buttoncolor,
                          blurRadius: 5.0,
                          // offset: Offset(0.0, 0.5)
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "15",
                            style: TextStyle(color: buttoncolor, fontSize: 30),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Appointments",
                            style: TextStyle(color: buttoncolor, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: widthSize*0.1,),
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: buttoncolor,
                          blurRadius: 5.0,
                          // offset: Offset(0.0, 0.5)
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.person,
                            size: 40,
                            color: buttoncolor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Orders",
                            style: TextStyle(color: buttoncolor, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
