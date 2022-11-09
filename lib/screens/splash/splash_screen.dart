import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teambill/res/colors.dart';
import 'package:teambill/res/images.dart';
import 'package:teambill/screens/home/home_screen.dart';
import 'package:teambill/screens/signin/signin_screen.dart';
import '../../api/api.dart';
import '../../blocs/application/application_bloc.dart';
import '../../blocs/application/application_event.dart';
import '../../local_database/data.dart';
import '../../model/model.dart';
import '../../utils/translate.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  late ApplicationBloc _applicationBloc;
    late DB db;
  @override
  void initState() {
    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    _applicationBloc.add(SetupApplication());
    db = DB();
    navigate();
    super.initState();
  }






  void navigate() {

    Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userToken = prefs.getString('userToken').toString();
      String t_url = prefs.getString('tenantUrl').toString();
      String login = prefs.getBool('isLogin').toString();
      print(login);
      if(login == 'true') {
        // connections();
        // customerlist();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));

      }else{
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignInScreen()));
      }
    });
    // AppPref().isLogin == true
    //     ? Get.off(() => OnBoardingScreen())
    //     : Get.offAll(() => OnBoardingScreen());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.marengo,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SvgPicture.asset(AppImage.appLogosvg,height: height*0.07,width: width*0.1,)
                // Image.asset(Images.Logo, width: 120, height: 120),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 300),
          //   child: SizedBox(
          //     width: 26,
          //     height: 26,
          //     child: CircularProgressIndicator(strokeWidth: 2),
          //   ),
          // )
        ],
      ),
    );
  }

  // void connections() async
  // {
  //   CustomerModel res = await Api().getConnectionslist();
  //
  //   print("Response getconnectionslist: ${res}");
  //
  //   setState(() {
  //     if (res.status == "Success") {
  //       print("getCustomerlist Response msg : ${res.data}");
  //       // connectionsModel = res;
  //       for (int i = 0; i < res.data.length; i++) {
  //         // data.add(res.data[i]);
  //         // db.insertData(res.data[i]);
  //       }
  //       print("getconnections list: ${res.data}");
  //     }
  //     else {
  //       print("Error Response msg : ${res.toString()}");
  //     }
  //   });
  // }
  // void customerlist() async
  // {
  //   // _customerlist.clear();
  //   CustomerModel res = await Api().getCustomerlist();
  //
  //   print("Response getCustomerlist: ${res}");
  //
  //   setState(() {
  //     if (res.status == "Success") {
  //       print("getCustomerlist Response msg : ${res.data}");
  //
  //       for (int i = 0; i < res.data.length; i++) {
  //
  //         // db.insertData(res.data[i]);
  //
  //       }
  //
  //
  //       print("_customer list: ${res.data}");
  //     }
  //     else {
  //       print("Error Response msg : ${res.toString()}");
  //     }
  //   });
  // }
}
