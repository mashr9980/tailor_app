import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
            width: 200,
            // height: 60,
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Lottie.asset('assets/animation/loader.json', height: 120)),
      ),
    );
  }
}
