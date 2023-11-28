import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../Config/text_style.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LocalDataBase/localdata.dart';



class SpalashScreen extends StatefulWidget {
  const SpalashScreen({Key? key}) : super(key: key);

  @override
  _SpalashScreenState createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {
  double _textOpacity = 0.0;
  bool isLogin=false;

  var localBd;
  @override
  void initState(){
    // TODO: implement initState
    // injection();
    // init();
    localBd=Get.find<LocalDataGet>();
    checkLogin();

    Timer(Duration(seconds: 4), () {
      setState(() {
        isLogin?
        Navigator.pushReplacementNamed(context,MAIN_PAGE): Navigator.pushReplacementNamed(
            context, MAIN_PAGE);

        // Navigator.pushReplacementNamed(context,MAIN_PAGE): Navigator.pushReplacementNamed(
        //     context, LOGIN_PAGE_INTRO);
        // isLogin?
        // Navigator.pushReplacement(context, PageTransition(MainScreen())):Navigator.pushReplacement(context, PageTransition(MainScreen()));
      });
    });

    super.initState();
  }
  void checkLogin() async {
    var token=await localBd.getData();

    if (token.get('token') != null) {
      setState(() {
        isLogin=true;

      });
    } else {
      setState(() {
        isLogin=false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          height: 1.0.sh,
            width: 1.0.sw,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(50),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SvgPicture.asset('assets/images/logo.svg',height: 200,)
                        Text("Video Trending",style: boldText(24,color: Colors.blueGrey),)
                      ],
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 40,
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //
              //       children: [
              //         Text("Powered By",style: TextStyle(fontSize: 12),),
              //         SvgPicture.asset('assets/images/maaclogo.svg')
              //       ],
              //     ),
              //   ),
              // )
            ],
          )

        )
    );
  }


}

