import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:teambill/model/model.dart';
import 'package:teambill/screens/home/home_screen.dart';
import '../../api/api.dart';
import '../../local_database/data.dart';
import '../../res/colors.dart';
import '../../utils/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late DB db;
  UserModel? customeralldeviceModel;
  final _customeralldevicelist = [
    'Select',
  ];
  TextEditingController _emailtextController =
      TextEditingController(text: 'h@schlatterer.net');
  TextEditingController _passtextController =
      TextEditingController(text: '*123456!');
  TextEditingController _urltextController =
      TextEditingController(text: 'https://testi.st-tbl.de');
  //TextEditingController _subdomaintextController = TextEditingController();
  bool isChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    db = DB();
    _emailtextController = TextEditingController(text: 'h@schlatterer.net');
    _passtextController = TextEditingController(text: '*123456!');
    _urltextController = TextEditingController(text: 'https://testi.st-tbl.de');
    //_subdomaintextController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          height: height * 0.55,
          width: width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Translate.of(context)!.translate('Welcome_back') +
                    " " +
                    Translate.of(context)!.translate('team_billing'),
                style: TextStyle(
                  fontFamily: 'NotoSansSC-Bold.otf',
                  fontWeight: FontWeight.bold,
                  color: AppColor.marengo,
                  fontSize: width * 0.05,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translate.of(context)!
                        .translate('E_MAIL_ADDRESSE')
                        .toUpperCase(),
                    style: TextStyle(
                      color: AppColor.marengo,
                      fontSize: height * 0.015,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  TextField(
                    controller: _emailtextController,
                    decoration: new InputDecoration(
                      hintText: Translate.of(context)!.translate('email'),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.grayborder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.blue,
                        ),
                      ),
                      hintStyle: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                      labelStyle: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                    ),
                  ),
                  //
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translate.of(context)!.translate('password').toUpperCase(),
                    style: TextStyle(
                      color: AppColor.marengo,
                      fontSize: height * 0.015,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  TextField(
                    controller: _passtextController,
                    obscureText: true,
                    decoration: new InputDecoration(
                      hintText: Translate.of(context)!.translate('password'),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.grayborder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.blue,
                        ),
                      ),
                      hintStyle: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                      labelStyle: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translate.of(context)!
                        .translate('Tenant_url')
                        .toUpperCase(),
                    style: TextStyle(
                      color: AppColor.marengo,
                      fontSize: height * 0.015,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  TextField(
                    controller: _urltextController,
                    decoration: new InputDecoration(
                      hintText: Translate.of(context)!
                          .translate('https://xyz.ab-pqr.de/'),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.grayborder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.blue,
                        ),
                      ),
                      hintStyle: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                      labelStyle: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        value: isChecked,
                        onChanged: (v) {
                          setState(() {
                            isChecked = v!;
                            print(isChecked);
                          });
                        },
                      ),
                      Text(
                        Translate.of(context)!.translate('remain_signed_in'),
                        style: TextStyle(
                          color: AppColor.marengo,
                          fontSize: height * 0.015,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    Translate.of(context)!.translate('forgot_password'),
                    style: TextStyle(
                      color: AppColor.blue,
                      fontSize: height * 0.015,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      Translate.of(context)!.translate('log_in'),
                      style: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.white,
                      ),
                    ),
                    Icon(Icons.arrow_forward_rounded)
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColor.blue),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.015)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 30))),
                onPressed: () async {
                  if (_emailtextController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please enter Email-Id!");
                  } else if (_passtextController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please enter Password!");
                  } else if (_passtextController.text.length < 8) {
                    Fluttertoast.showToast(
                        msg: "Password length should be 8 character!");
                  }
                  /*else if(_subdomaintextController.text.isEmpty){
                    Fluttertoast.showToast(msg: "Please enter Subdomain!");
                  }*/
                  else if (_urltextController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please enter URL!");
                  } else if (!RegExp(
                          r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?')
                      .hasMatch(_urltextController.text)) {
                    Fluttertoast.showToast(msg: "Invalid URL!");
                  } else {
                    bool result =
                        await InternetConnectionChecker().hasConnection;
                    if (result == true) {
                      // NEW
                      login(
                          '',
                          _urltextController.text,
                          _emailtextController.text,
                          _passtextController.text,
                          isChecked);
                      // OLD
                      //login(_subdomaintextController.text,_urltextController.text,_emailtextController.text,_passtextController.text,isChecked);

                    } else {
                      Fluttertoast.showToast(
                          msg: "Please check your internet connection!");
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(String t_subdomain, String t_url, String email, String password,
      bool keepsignin) async {
    FocusScope.of(context).unfocus();
    final lastChar = (t_url[t_url.length - 1]);
    final updatedT_URL = t_url + ((lastChar != '/') ? '/' : '');
    UserModel? res = await Api().getToken(
        t_subdomain, updatedT_URL, email, password, keepsignin, context);
    print("Response: ${res}");
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
  //
  // void getCustomeralldevicelist() async {
  //   _customeralldevicelist.clear();
  //   _customeralldevicelist.add('Select');
  //   FocusScope.of(context).unfocus();
  //   UserModel res = await Api().getCustomeralldevicelist();
  //
  //   print("Response all: ${res}");
  //
  //   setState(() {
  //     if (res.status == "Error") {
  //       print("getCustomerlist Response msg : ${res.data}");
  //       // customeralldeviceModel = res;
  //       for (int i = 0; i < res.data.groupList.length; i++) {
  //         // _customeralldevicelist.add(res.data.groupList[i]);
  //         // db.insertData(res.data);
  //       }
  //       // print("_customer list: $_customeralldevicelist");
  //
  //     } else {
  //       print("Error Response msg : ${res.toString()}");
  //     }
  //   });
  // }

}
