import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:teambill/model/model.dart';
import 'package:teambill/res/colors.dart';
import 'package:teambill/res/images.dart';
import 'package:teambill/screens/home/add_contact.dart';
import 'package:teambill/screens/home/add_customer.dart';
import 'package:teambill/screens/home/add_device.dart';
import '../../api/api.dart';
import '../../local_database/data.dart';
import '../../utils/translate.dart';

class HomeScreen extends StatefulWidget {
  bool? activitytap;
  HomeScreen({Key? key, this.activitytap}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DB db;
  List<Datum> datas = [];
  // List<ConnectionDatum> connectiondata = [];
  List<Device> Devicedata = [];

  bool istimerstart = true;
  bool fromtimer = false;
  TimeOfDay starttime = TimeOfDay(hour: 00, minute: 00);

  String starttimedisplay = '';
  String dropdownValue = 'Select';
  List<String> _dropdownValues = [
    'Select',
  ];

  String contacttypeValue = 'Select';
  List<String> _contacttypeValues = [
    'Select',
    'Email',
    'Call',
    'Video Call',
    'On-sire Appointment',
    'VPN'
  ];

  String? customerValue = 'Select';
  List<String> _customerlist = [
    'Select',
  ];
  String custname = '';
  String gid = '';
  CustomerModel? customerModel;

  String? customerdeviceValue = 'Select';
  List<String> _customerdevicelist = [
    'Select',
  ];
  Userdevicelistmodel? customerdeviceModel;

  String? customeralldeviceValue = 'Select';
  List<String> _customeralldevicelist = [
    'Select',
  ];

  Devicelistmodel? customeralldeviceModel;

  Connectionmodel? connectionsModel;
  List<ConnectionDatum> Connectiondata = [];
  List<Addactivity> Addactivitydata = [];
  String username = '';
  bool isChecked = false;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onStop: () {
      print('onStop');
    },
    onEnded: () {
      print('onEnded');
    },
  );

  TextEditingController startdateController = TextEditingController();
  TextEditingController enddateController = TextEditingController();
  TextEditingController starttimeController = TextEditingController();
  TextEditingController endtimeController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController jobdescController = TextEditingController();
  TextEditingController reportnotesController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController userController = TextEditingController();

  bool activitytap = false;
  bool decsorting = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDayFormat time = TimeOfDayFormat.HH_colon_mm;
  bool loading = false;
  @override
  void initState() {
    // _stopWatchTimer.rawTime.listen((value) =>
    //     print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    // _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    // _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    // _stopWatchTimer.records.listen((value) => print('records $value'));
    // _stopWatchTimer.fetchStop.listen((value) => print('stop from stream'));
    // _stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));

    db = DB();
    //
    if (widget.activitytap != null) {
      activitytap = widget.activitytap!;
    }
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    startdateController = new TextEditingController();
    enddateController = new TextEditingController();
    starttimeController = new TextEditingController();
    endtimeController = new TextEditingController();
    durationController = new TextEditingController();
    starttimeController.text =
        '${TimeOfDay(hour: 00, minute: 00).hour < 10 ? '0${TimeOfDay(hour: 00, minute: 00).hour.toString()}' : TimeOfDay(hour: 00, minute: 00).hour.toString()}:${TimeOfDay(hour: 00, minute: 00).minute < 10 ? '0${TimeOfDay(hour: 00, minute: 00).minute}' : TimeOfDay(hour: 00, minute: 00).minute.toString()}';
    endtimeController.text =
        '${TimeOfDay(hour: 23, minute: 59).hour.toString()}:${TimeOfDay(hour: 23, minute: 59).minute.toString()}';

    // starttimeController.text =
    //     '0${TimeOfDay(hour: 00, minute: 00).hour.toString()}:0${TimeOfDay(hour: 00, minute: 00).minute.toString()}';
    // endtimeController.text =
    //     '${TimeOfDay(hour: 23, minute: 59).hour.toString()}:${TimeOfDay(hour: 23, minute: 59).minute.toString()}';
    // DateTime.now().day < 10 ? '0${DateTime.now().day.toString()}' :  DateTime.now().day.toString()
    starttimedisplay = starttimeController.text;
    startdateController.text =
        '${DateTime.now().day < 10 ? '0${DateTime.now().day.toString()}' : DateTime.now().day.toString()}'
        '.${DateTime.now().month < 10 ? '0${DateTime.now().month.toString()}' : DateTime.now().month.toString()}'
        '.${DateTime.now().year.toString()}';
    enddateController.text =
        '${DateTime.now().day < 10 ? '0${DateTime.now().day.toString()}' : DateTime.now().day.toString()}'
        '.${DateTime.now().month < 10 ? '0${DateTime.now().month.toString()}' : DateTime.now().month.toString()}'
        '.${DateTime.now().year.toString()}';

    print(startdateController.text);
    checkinternet();

    super.initState();
  }

  Future<void> checkinternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('Internet :)');
      // connections();
      getConnectionsfromdb();
      customerlist();
    } else {
      print('Internet GetConnesr wection dlt :)');

      getConnectionsfromdb();
      getcustomerlistfromdb();
      // getinsertcustomerdevicelistfromdb();

      print('No internet :( ');
    }
  }

  void getcustomerlistfromdb() async {
    datas = await db.getCustomerlist();
    print('datas :( ${datas.elementAt(0).customerName}');
  }

  void getConnectionsfromdb() async {
    setState(() {
      loading = true;
    });
    Addactivitydata = await db.getactivity();
    Addactivitydata.sort((a, b) => b.startDate.compareTo(a.startDate));
    print('datas1 :( ${Addactivitydata.elementAt(0).customer_name}');
    setState(() {
      loading = false;
    });
  }
  // void getinsertcustomerdevicelistfromdb() async {
  //   Devicedata = await db.getinsertcustomerdevicelist();
  //   print('datas2 :( ${Devicedata.elementAt(0).alias}');
  // }

  void logout() async {
    FocusScope.of(context).unfocus();
    UserModel res = await Api().revokeToken(context);
    print("Response: ${res}");

    setState(() {
      if (res.status == "Success") {
        print("Success Response msg : ${res.message}");
      } else {
        Fluttertoast.showToast(msg: res.message);

        print("Error Response msg : ${res.toString()}");
      }
    });
  }

  void getCustomerdevicelist(String gid, String connectionid) async {
    // _customerdevicelist.clear();
    final List<String> list = [];
    print("gid: $gid");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FocusScope.of(context).unfocus();
    Userdevicelistmodel res = await Api().getCustomerdevicelist(gid);

    print("Response: ${res}");
    _customerdevicelist.clear();
    db.deletecustomerdevicelist();
    _customerdevicelist.add('Select');
    setState(() {
      if (res.status == "Success") {
        print("getCustomerlist Response msg5 : ${res.data}");
        customerdeviceModel = res;
        for (int i = 0; i < res.data.devices.length; i++) {
          list.add(res.data.devices[i].alias);

          db.insertcustomerdevicelist(res.data.devices[i]);
        }
        print("_customer device list: $list");
        list.sort((a, b) {
          //sorting in ascending order
          return a.toLowerCase().compareTo(b.toLowerCase());
        });
        print('Sorted _customerdevicelist: $list');
        _customerdevicelist.addAll(list);
        customerValue = 'Select';
        contacttypeValue = 'Select';
        customerdeviceValue = 'Select';
        _displayeditDialog(
          context,
        );
      } else {
        print("Error Response msg : ${res.toString()}");
      }
    });
  }

  void AddConnectionfromtimer() async {
    // _customerdevicelist.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken').toString();
    String userid = prefs.getInt('userid').toString();
    print('from timer1 $fromtimer');
    FocusScope.of(context).unfocus();
    print(custname);
    print(gid);
    print('Bill');
    print(startdateController.text + ' ${starttimeController.text}');
    print(enddateController.text + ' ${endtimeController.text}');
    Addactivity addactivity = Addactivity(
        customer_name: custname,
        groupid: gid,
        userid: userid,
        billing_state: 'Bill',
        startDate: startdateController.text + ' ${starttimeController.text}',
        endDate: enddateController.text + ' ${endtimeController.text}');
    db.addactivity(addactivity);
    // Addconnectionmodel? res = await Api().AddConnectionslist(
    //     custname,
    //     gid,
    //     'Bill',
    //     startdateController.text + ' ${starttimeController.text}',
    //     enddateController.text + ' ${endtimeController.text}',
    //     context);
    // if (res != null) {
    setState(() {
      activitytap = true;
    });
    // }
  }

  void AddConnection() async {
    print('from timer $fromtimer');
    // _customerdevicelist.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken').toString();
    String userid = prefs.getInt('userid').toString();

    FocusScope.of(context).unfocus();
    print(custname);
    print(gid);
    print('Bill');
    print(startdateController.text +
        ' ${DateTime.now().hour < 10 ? '0${DateTime.now().hour.toString()}' : DateTime.now().hour.toString()}:${DateTime.now().minute < 10 ? '0${DateTime.now().minute.toString()}' : DateTime.now().minute.toString()}');
    print(enddateController.text +
        ' ${DateTime.now().hour < 10 ? '0${DateTime.now().hour.toString()}' : DateTime.now().hour.toString()}:${DateTime.now().minute < 10 ? '0${DateTime.now().minute.toString()}' : DateTime.now().minute.toString()}');
    Addactivity addactivity = Addactivity(
        customer_name: custname,
        groupid: gid,
        userid: userid,
        billing_state: 'Bill',
        startDate: startdateController.text +
            ' ${DateTime.now().hour < 10 ? '0${DateTime.now().hour.toString()}' : DateTime.now().hour.toString()}:${DateTime.now().minute < 10 ? '0${DateTime.now().minute.toString()}' : DateTime.now().minute.toString()}',
        endDate: enddateController.text +
            ' ${DateTime.now().hour < 10 ? '0${DateTime.now().hour.toString()}' : DateTime.now().hour.toString()}:${DateTime.now().minute < 10 ? '0${DateTime.now().minute.toString()}' : DateTime.now().minute.toString()}');
    db.addactivity(addactivity);

    // Addconnectionmodel? res = await Api().AddConnectionslist(
    //     custname,
    //     gid,
    //     'Bill',
    //     startdateController.text +
    //         ' ${DateTime.now().hour < 10 ? '0${DateTime.now().hour.toString()}' : DateTime.now().hour.toString()}:${DateTime.now().minute < 10 ? '0${DateTime.now().minute.toString()}' : DateTime.now().minute.toString()}',
    //     enddateController.text +
    //         ' ${DateTime.now().hour < 10 ? '0${DateTime.now().hour.toString()}' : DateTime.now().hour.toString()}:${DateTime.now().minute < 10 ? '0${DateTime.now().minute.toString()}' : DateTime.now().minute.toString()}',
    //     context);
    // if (res != null) {
    setState(() {
      activitytap = true;
    });
    // }
  }

  void EditConnection(String connectionid) async {
    // _customerdevicelist.clear();

    FocusScope.of(context).unfocus();
    Addconnectionmodel? res = await Api().EditConnectionslist(
        connectionid,
        custname,
        gid,
        'Bill',
        DateTime.now().toString(),
        DateTime.now().toString(),
        jobdescController.text,
        contacttypeValue,
        reportnotesController.text,
        context);

    print("Response: ${res}");
  }

  void getCustomeralldevicelist() async {
    final List<String> list = [];
    _customeralldevicelist.clear();
    _customeralldevicelist.add('Select');
    FocusScope.of(context).unfocus();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Devicelistmodel res = await Api().getCustomeralldevicelist();

    print("Response all: ${res}");

    setState(() {
      if (res.status == "Error") {
        print("getCustomerlist Response msg4 : ${res.data}");
        customeralldeviceModel = res;
        for (int i = 0; i < res.data.groupList.length; i++) {
          list.add(res.data.groupList[i]);
        }
        print("_customer all device list: $_customeralldevicelist");

        list.sort((a, b) {
          //sorting in ascending order
          return a.toLowerCase().compareTo(b.toLowerCase());
        });

        _customeralldevicelist.addAll(list);
        print('Sorted _customerdevicelist: $_customeralldevicelist');
        customerValue = 'Select';
        contacttypeValue = 'Select';
        customeralldeviceValue = 'Select';
        _displayDialog(context);
      } else {
        print("Error Response msg : ${res.toString()}");
      }
    });
  }

  void customerlist() async {
    // _customerlist.clear();
    final List<String> list = [];
    CustomerModel res = await Api().getCustomerlist();

    print("Response getCustomerlist: ${res}");
    db.deleteCustomerlist();
    setState(() {
      if (res.status == "Success") {
        print("getCustomerlist Response msg2 : ${res.data}");
        customerModel = res;

        for (int i = 0; i < res.data.length; i++) {
          list.add(res.data[i].customerName + ' / ' + res.data[i].groupid);

          db.insertCustomerlist(res.data[i]);
        }
        print("_customer list: $list");
        list.sort((a, b) {
          //sorting in ascending order
          return a.toLowerCase().compareTo(b.toLowerCase());
        });
        _customerlist.addAll(list);
        print('Sorted list: $_customerlist');
      } else {
        print("Error Response msg : ${res.toString()}");
      }
    });
  }

  void connections() async {
    setState(() {
      loading = true;
    });

    Connectionmodel res = await Api().getConnectionslist();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getInt('userid').toString();
    print("Response getconnectionslist: ${res}");
    db.deleteConnectionsData();
    setState(() {
      if (res.status == "Success") {
        print("getCustomerlist Response msg1 : ${res.data}");
        connectionsModel = res;

        Connectiondata.clear();
        for (int i = 0; i < res.data.length; i++) {
          if (userid == res.data[i].userid) {
            print('uid $userid');
            print('res uid ${res.data[i].userid}');

            Connectiondata.add(res.data[i]);

            db.insertConnections(res.data[i]);

            print('Connectiondata ${Connectiondata.elementAt(0).username}');
            username = Connectiondata.elementAt(0).username;
            // for(int j=0; i <res.data[i].userid.length;j++){
            //
            //
            // }
            if (decsorting == false) {
              setState(() {
                decsorting = true;
                Connectiondata.sort(
                    (a, b) => a.startDate.compareTo(b.startDate));
              });
            } else {
              setState(() {
                decsorting = false;
                Connectiondata.sort(
                    (a, b) => b.startDate.compareTo(a.startDate));
              });
            }
            // Connectiondata.sort((a,b) {
            //   var adate = a['start_date']; //before -> var adate = a.expiry;
            //   var bdate = b['start_date'];//var bdate = b.expiry;
            //   return -adate.compareTo(bdate);
            // });
            for (int i = 0; i < Connectiondata.length; i++) {
              print(
                  'sorted list Connectiondata ${Connectiondata.elementAt(i).endDate}');
            }
          }

          userController.text = username;
          // db.insertData(res.data[i]);
        }
        print("length ${username}");

        print("getconnections list: $Connectiondata");
      } else {
        print("Error Response msg : ${res.toString()}");
      }
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        exitapp(context);
        return new Future(() => true);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          AppImage.appLogosvg,
                          height: height * 0.05,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                logoutapp(context);
                              },
                              child: SvgPicture.asset(
                                AppImage.person,
                                height: height * 0.05,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                bool result = await InternetConnectionChecker()
                                    .hasConnection;
                                setState(() {
                                  fromtimer = false;
                                });

                                _displayDialog(context);
                              },
                              child: Icon(
                                Icons.add,
                                size: height * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 3,
                    color: AppColor.silver,
                  ),
                ],
              ),
              Card(
                color: AppColor.appiconcolor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: height * 0.25,
                  width: width * 0.95,
                  child: Stack(
                    children: [
                      Container(
                        height: height * 0.17,
                        width: width,
                        decoration: BoxDecoration(
                          color: AppColor.ink,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.02, top: height * 0.01),
                                  child: Text(
                                    Translate.of(context)!.translate('Timer'),
                                    style: TextStyle(
                                        color: AppColor.graymed,
                                        fontSize: height * 0.025),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: width * 0.02, top: height * 0.01),
                                  child: Text(
                                    Translate.of(context)!.translate('Start') +
                                        ' ' +
                                        Translate.of(context)!
                                            .translate('TIME') +
                                        ' : ' +
                                        starttimedisplay,
                                    style: TextStyle(
                                        color: AppColor.graymed,
                                        fontSize: height * 0.02),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              indent: width * 0.02,
                              endIndent: width * 0.02,
                              color: AppColor.graymed,
                            ),
                            StreamBuilder<int>(
                              stream: _stopWatchTimer.rawTime,
                              initialData: _stopWatchTimer.rawTime.value,
                              builder: (context, snap) {
                                final value = snap.data!;
                                final displayTime =
                                    StopWatchTimer.getDisplayTime(value,
                                        hours: false, milliSecond: false);
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        displayTime,
                                        style: TextStyle(
                                            fontFamily: 'NotoSansSC-Bold.otf',
                                            fontWeight: FontWeight.normal,
                                            color: AppColor.grayborder,
                                            fontSize: height * 0.05),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            // CountdownTimer(
                            //   controller: controller,
                            //   onEnd: onEnd,
                            //   endTime: endTime,
                            // ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: AppColor.transparent,
                          height: height * 0.08,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              istimerstart == true
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          istimerstart = false;
                                          starttimeController.text =
                                              '${TimeOfDay.now().hour < 10 ? '0${TimeOfDay.now().hour.toString()}' : TimeOfDay.now().hour.toString()}:${TimeOfDay.now().minute < 10 ? '0${TimeOfDay.now().minute.toString()}' : TimeOfDay.now().minute.toString()}';
                                          starttimedisplay =
                                              starttimeController.text;
                                          print(
                                              "st ${starttimeController.text}");
                                        });
                                        _stopWatchTimer.onExecute
                                            .add(StopWatchExecute.start);
                                      },
                                      child: Text(
                                        Translate.of(context)!
                                            .translate('Start'),
                                        style: TextStyle(
                                            fontFamily: 'NotoSansSC-Bold.otf',
                                            fontWeight: FontWeight.normal,
                                            color: AppColor.white,
                                            fontSize: height * 0.05),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          endtimeController.text =
                                              '${TimeOfDay.now().hour < 10 ? '0${TimeOfDay.now().hour.toString()}' : TimeOfDay.now().hour.toString()}:${TimeOfDay.now().minute < 10 ? '0${TimeOfDay.now().minute.toString()}' : TimeOfDay.now().minute.toString()}';

                                          print(
                                              "ettrf ${endtimeController.text}");

                                          var format = DateFormat("HH:mm");
                                          var one = format
                                              .parse(starttimeController.text);
                                          var two = format
                                              .parse(endtimeController.text);
                                          print(
                                              "${two.difference(one).inMinutes}");

                                          durationController.text = two
                                              .difference(one)
                                              .inMinutes
                                              .toString();

                                          print(
                                              "dttr ${durationController.text}");
                                        });
                                        setState(() {
                                          fromtimer = true;
                                        });
                                        _stopWatchTimer.onExecute
                                            .add(StopWatchExecute.stop);
                                        customerValue = 'Select';
                                        contacttypeValue = 'Select';
                                        customeralldeviceValue = 'Select';
                                        _displayDialog(context);
                                      },
                                      child: Text(
                                        Translate.of(context)!
                                            .translate('Stop'),
                                        style: TextStyle(
                                            fontFamily: 'NotoSansSC-Bold.otf',
                                            fontWeight: FontWeight.normal,
                                            color: AppColor.white,
                                            fontSize: height * 0.05),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Divider(
                    thickness: 3,
                    color: AppColor.silver,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        activitytap == false
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    activitytap = true;
                                  });
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: height * 0.05,
                                  color: AppColor.ink,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    activitytap = false;
                                  });
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up_sharp,
                                  size: height * 0.05,
                                  color: AppColor.ink,
                                ),
                              ),
                        Text(
                          Translate.of(context)!.translate('Activity_overview'),
                          style: TextStyle(
                              fontFamily: 'NotoSansSC-Bold.otf',
                              fontWeight: FontWeight.bold,
                              color: AppColor.ink,
                              fontSize: height * 0.03),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (activitytap == true)
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: height * 0.01),
                      child: Table(
                        children: [
                          TableRow(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                decsorting == false
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            decsorting = true;
                                            Addactivitydata.sort((a, b) => a
                                                .startDate
                                                .compareTo(b.startDate));
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          AppImage.downarrow,
                                          color: AppColor.marengo,
                                          height: height * 0.02,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            decsorting = false;
                                            Addactivitydata.sort((a, b) => b
                                                .startDate
                                                .compareTo(a.startDate));
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          AppImage.uparrow,
                                          color: AppColor.marengo,
                                          height: height * 0.02,
                                        ),
                                      ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Translate.of(context)!
                                          .translate('Start')
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontFamily: 'NotoSansSC-Bold.otf',
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.marengo,
                                          fontSize: height * 0.013),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Translate.of(context)!
                                      .translate('End')
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: 'NotoSansSC-Bold.otf',
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.marengo,
                                      fontSize: height * 0.013),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Translate.of(context)!
                                      .translate('customer')
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: 'NotoSansSC-Bold.otf',
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.marengo,
                                      fontSize: height * 0.013),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Translate.of(context)!
                                      .translate('Synchronizationstatus')
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: 'NotoSansSC-Bold.otf',
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.marengo,
                                      fontSize: height * 0.013),
                                ),
                              ],
                            ),
                          ]),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: height * 0.515,
                    //   child: loading
                    //       ? Center(child: CircularProgressIndicator())
                    //       : ListView.builder(
                    //           itemCount: Connectiondata.length,
                    //           itemBuilder: (BuildContext context, int index) {
                    //             return Table(
                    //               children: [
                    //                 TableRow(children: [
                    //                   GestureDetector(
                    //                     onTap: () async {
                    //                       bool result =
                    //                           await InternetConnectionChecker()
                    //                               .hasConnection;
                    //                       if (result == true) {
                    //                         print('Internet :)');
                    //                         getCustomerdevicelist(
                    //                             Connectiondata.elementAt(index)
                    //                                 .groupid,
                    //                             Connectiondata.elementAt(index)
                    //                                 .id);
                    //                       } else {
                    //                         db.getinsertcustomerdevicelist();
                    //                         // getinsertcustomerdevicelistfromdb();
                    //
                    //                         print('No internet :( ');
                    //                       }
                    //                     },
                    //                     child: Padding(
                    //                       padding: EdgeInsets.symmetric(
                    //                           vertical: height * 0.007),
                    //                       child: Row(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.center,
                    //                         children: [
                    //                           Flexible(
                    //                             child: Text(
                    //                               Translate.of(context)!
                    //                                   .translate(DateFormat(
                    //                                           "dd.MM.yyyy HH:mm")
                    //                                       .format(DateTime.parse(
                    //                                           Connectiondata
                    //                                                   .elementAt(
                    //                                                       index)
                    //                                               .startDate
                    //                                               .toString())))
                    //                                   .toUpperCase(),
                    //                               style: TextStyle(
                    //                                   color: AppColor.ink,
                    //                                   fontSize: height * 0.01),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   GestureDetector(
                    //                     onTap: () async {
                    //                       bool result =
                    //                           await InternetConnectionChecker()
                    //                               .hasConnection;
                    //                       if (result == true) {
                    //                         print('Internet :)');
                    //                         getCustomerdevicelist(
                    //                             Connectiondata.elementAt(index)
                    //                                 .groupid,
                    //                             Connectiondata.elementAt(index)
                    //                                 .id);
                    //                       } else {
                    //                         db.getinsertcustomerdevicelist();
                    //                         // getinsertcustomerdevicelistfromdb();
                    //
                    //                         print('No internet :( ');
                    //                       }
                    //                     },
                    //                     child: Padding(
                    //                       padding: EdgeInsets.symmetric(
                    //                           vertical: height * 0.007),
                    //                       child: Row(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.center,
                    //                         children: [
                    //                           Flexible(
                    //                             child: Text(
                    //                               Translate.of(context)!
                    //                                   .translate(DateFormat(
                    //                                           "dd.MM.yyyy HH:mm")
                    //                                       .format(DateTime.parse(
                    //                                           Connectiondata
                    //                                                   .elementAt(
                    //                                                       index)
                    //                                               .endDate
                    //                                               .toString())))
                    //                                   .toUpperCase(),
                    //                               style: TextStyle(
                    //                                   color: AppColor.ink,
                    //                                   fontSize: height * 0.01),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   GestureDetector(
                    //                     onTap: () async {
                    //                       bool result =
                    //                           await InternetConnectionChecker()
                    //                               .hasConnection;
                    //                       if (result == true) {
                    //                         print('Internet :)');
                    //                         getCustomerdevicelist(
                    //                             Connectiondata.elementAt(index)
                    //                                 .groupid,
                    //                             Connectiondata.elementAt(index)
                    //                                 .id);
                    //                       } else {
                    //                         db.getinsertcustomerdevicelist();
                    //                         // getinsertcustomerdevicelistfromdb();
                    //
                    //                         print('No internet :( ');
                    //                       }
                    //                     },
                    //                     child: Padding(
                    //                       padding: EdgeInsets.symmetric(
                    //                           vertical: height * 0.007),
                    //                       child: Row(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.start,
                    //                         children: [
                    //                           Flexible(
                    //                             child: Text(
                    //                               Translate.of(context)!
                    //                                   .translate(Connectiondata
                    //                                           .elementAt(index)
                    //                                       .groupname)
                    //                                   .toUpperCase(),
                    //                               textAlign: TextAlign.left,
                    //                               style: TextStyle(
                    //
                    //                                   color: AppColor.ink,
                    //                                   fontSize: height * 0.01),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   GestureDetector(
                    //                     onTap: () async {
                    //                       bool result =
                    //                           await InternetConnectionChecker()
                    //                               .hasConnection;
                    //                       if (result == true) {
                    //                         print('Internet :)');
                    //                         getCustomerdevicelist(
                    //                             Connectiondata.elementAt(index)
                    //                                 .groupid,
                    //                             Connectiondata.elementAt(index)
                    //                                 .id);
                    //                       } else {
                    //                         db.getinsertcustomerdevicelist();
                    //                         // getinsertcustomerdevicelistfromdb();
                    //
                    //                         print('No internet :( ');
                    //                       }
                    //                     },
                    //                     child: Padding(
                    //                       padding: EdgeInsets.symmetric(
                    //                           vertical: height * 0.007),
                    //                       child: Row(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.center,
                    //                         children: [
                    //                           Text(
                    //                             Translate.of(context)!
                    //                                 .translate('Tag')
                    //                                 .toUpperCase(),
                    //                             style: TextStyle(
                    //                                 color: AppColor.ink,
                    //                                 fontSize: height * 0.01),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ]),
                    //               ],
                    //             );
                    //           }),
                    // ),
                    Container(
                      height: height * 0.515,
                      child: loading
                          ? Center(child: CircularProgressIndicator())
                          : Addactivitydata.length == 0
                              ? Container()
                              : ListView.builder(
                                  itemCount: Addactivitydata.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Table(
                                      children: [
                                        TableRow(children: [
                                          GestureDetector(
                                            onTap: () async {
                                              bool result =
                                                  await InternetConnectionChecker()
                                                      .hasConnection;
                                              if (result == true) {
                                                print('Internet :)');
                                                _displayeditDialog(
                                                  context,
                                                );
                                                // getCustomerdevicelist(
                                                //     Connectiondata.elementAt(index)
                                                //         .groupid,
                                                //     Connectiondata.elementAt(index)
                                                //         .id);
                                              } else {
                                                db.getinsertcustomerdevicelist();
                                                // getinsertcustomerdevicelistfromdb();

                                                print('No internet :( ');
                                              }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: height * 0.007),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      Translate.of(context)!
                                                          .translate(
                                                        // DateFormat(
                                                        // "dd.MM.yyyy HH:mm")
                                                        // .format(
                                                        // DateTime.parse(
                                                        Addactivitydata
                                                                .elementAt(
                                                                    index)
                                                            .startDate
                                                            .toString(),
                                                        // )))
                                                        // .toUpperCase()
                                                      ),
                                                      style: TextStyle(
                                                          color: AppColor.ink,
                                                          fontSize:
                                                              height * 0.01),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              bool result =
                                                  await InternetConnectionChecker()
                                                      .hasConnection;
                                              if (result == true) {
                                                print('Internet :)');
                                                _displayeditDialog(
                                                  context,
                                                );
                                                // getCustomerdevicelist(
                                                //     Connectiondata.elementAt(index)
                                                //         .groupid,
                                                //     Connectiondata.elementAt(index)
                                                //         .id);
                                              } else {
                                                db.getinsertcustomerdevicelist();
                                                // getinsertcustomerdevicelistfromdb();

                                                print('No internet :( ');
                                              }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: height * 0.007),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      Translate.of(context)!
                                                          .translate(
                                                              // DateFormat(
                                                              // "dd.MM.yyyy HH:mm")
                                                              // .format(DateTime.parse(
                                                              Addactivitydata
                                                                      .elementAt(
                                                                          index)
                                                                  .endDate
                                                                  .toString()
                                                              // )))
                                                              //                       .toUpperCase()
                                                              ),
                                                      style: TextStyle(
                                                          color: AppColor.ink,
                                                          fontSize:
                                                              height * 0.01),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              bool result =
                                                  await InternetConnectionChecker()
                                                      .hasConnection;
                                              if (result == true) {
                                                print('Internet :)');
                                                _displayeditDialog(
                                                  context,
                                                );
                                                // getCustomerdevicelist(
                                                //     Connectiondata.elementAt(index)
                                                //         .groupid,
                                                //     Connectiondata.elementAt(index)
                                                //         .id);
                                              } else {
                                                db.getinsertcustomerdevicelist();
                                                // getinsertcustomerdevicelistfromdb();

                                                print('No internet :( ');
                                              }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: height * 0.007),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      Translate.of(context)!
                                                          .translate(
                                                              Addactivitydata
                                                                      .elementAt(
                                                                          index)
                                                                  .customer_name)
                                                          .toUpperCase(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: AppColor.ink,
                                                          fontSize:
                                                              height * 0.01),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              bool result =
                                                  await InternetConnectionChecker()
                                                      .hasConnection;
                                              if (result == true) {
                                                print('Internet :)');
                                                _displayeditDialog(
                                                  context,
                                                );
                                                // getCustomerdevicelist(
                                                //     Connectiondata.elementAt(index)
                                                //         .groupid,
                                                //     Connectiondata.elementAt(index)
                                                //         .id);
                                              } else {
                                                db.getinsertcustomerdevicelist();
                                                // getinsertcustomerdevicelistfromdb();

                                                print('No internet :( ');
                                              }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: height * 0.007),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    Translate.of(context)!
                                                        .translate('Tag')
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: AppColor.ink,
                                                        fontSize:
                                                            height * 0.01),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    );
                                  }),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> exitapp(BuildContext context) async {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return (await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(Translate.of(context)!.translate('Confirm_Exit')),
            content: Text(Translate.of(context)!
                .translate('Are_you_sure_you_want_to_exit')),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Translate.of(context)!.translate('Yes'),
                          style: TextStyle(
                            fontSize: height * 0.022,
                            color: AppColor.white,
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.blue),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.015)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 30))),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Translate.of(context)!.translate('No'),
                          style: TextStyle(
                            fontSize: height * 0.022,
                            color: AppColor.white,
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.marengo),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.015)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 30))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        }));
  }

  Future<void> trackerstop(BuildContext context) async {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return (await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(Translate.of(context)!.translate('Confirm_discard')),
              content: Text(Translate.of(context)!
                  .translate('Do_you_want_to_discard_the_tracked_time')),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Translate.of(context)!.translate('Yes'),
                            style: TextStyle(
                              fontSize: height * 0.022,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.blue),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: height * 0.015)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 30))),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(activitytap: true)));

                          activitytap = true;

                          // starttimeController.text =
                          //     '${TimeOfDay(hour: 00, minute: 00).hour < 10 ? '0${TimeOfDay(hour: 00, minute: 00).hour.toString()}' : TimeOfDay(hour: 00, minute: 00).hour.toString()}:${TimeOfDay(hour: 00, minute: 00).minute < 10 ? '0${TimeOfDay(hour: 00, minute: 00).minute}' : TimeOfDay(hour: 00, minute: 00).minute.toString()}';
                          // endtimeController.text =
                          //     '${TimeOfDay(hour: 00, minute: 00).hour < 10 ? '0${TimeOfDay(hour: 23, minute: 59).hour.toString()}' : TimeOfDay(hour: 23, minute: 59).hour.toString()}:${TimeOfDay(hour: 23, minute: 59).minute < 10 ? '0${TimeOfDay(hour: 23, minute: 59).minute}' : TimeOfDay(hour: 23, minute: 59).minute.toString()}';
                          // _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                          // starttimedisplay = starttimeController.text;
                          // Navigator.pop(context);
                          // Navigator.pop(context);
                        });
                      },
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Translate.of(context)!.translate('No'),
                            style: TextStyle(
                              fontSize: height * 0.022,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.marengo),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: height * 0.015)),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 30))),
                      onPressed: () {
                        if (fromtimer == true) {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                          setState(() {
                            istimerstart = false;
                          });
                        }
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            );
          });
        }));
  }

  Future<void> logoutapp(BuildContext context) async {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return (await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Padding(
                  padding: EdgeInsets.only(left: width * 0.03),
                  child: Text(Translate.of(context)!.translate('log_out'))),
              content: Container(
                height: height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.03),
                      child: Text(Translate.of(context)!
                          .translate('Are_you_sure_you_want_to_logout')),
                    ),
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
                            });

                            print(isChecked);
                          },
                        ),
                        Text(
                          Translate.of(context)!.translate('sync data'),
                          style: TextStyle(
                            color: AppColor.marengo,
                            fontSize: height * 0.015,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Translate.of(context)!.translate('Yes'),
                            style: TextStyle(
                              fontSize: height * 0.022,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.blue),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: height * 0.015)),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 30))),
                      onPressed: () {
                        logout();
                      },
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Translate.of(context)!.translate('No'),
                            style: TextStyle(
                              fontSize: height * 0.022,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.marengo),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: height * 0.015)),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 30))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          });
        }));
  }

  Future<void> selectstartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(4000));
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
        print("selected date is  $selectedDate");
        var date =
            "${pickedDate.toLocal().day < 10 ? '0${pickedDate.toLocal().day}' : pickedDate.toLocal().day}"
            ".${pickedDate.toLocal().month < 10 ? '0${pickedDate.toLocal().month}' : pickedDate.toLocal().month}"
            ".${pickedDate.toLocal().year}";

        startdateController.text = date;
      });
  }

  Future<void> selectendDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(4000));
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
        print("selected date is  $selectedDate");
        var date =
            "${pickedDate.toLocal().day < 10 ? '0${pickedDate.toLocal().day}' : pickedDate.toLocal().day}"
            ".${pickedDate.toLocal().month < 10 ? '0${pickedDate.toLocal().month}' : pickedDate.toLocal().month}"
            ".${pickedDate.toLocal().year}";
        enddateController.text = date;
      });
  }

  selectstartTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        print("selected date is  $selectedTime");
        var time =
            '${selectedTime.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}';
        starttimeController.text = time.toString();
      });
    }
  }

  selectendTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        print("selected date is  $selectedTime");
        var time =
            '${selectedTime.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour}:${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}';
        endtimeController.text = time.toString();
      });
    }
  }

  _displayDialog(BuildContext context) async {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('username');
    userController.text = userName ?? '';

    //print(customerModel?.data.length);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Translate.of(context)!.translate('Add_activity'),
                  style: TextStyle(
                      fontFamily: 'NotoSansSC-Bold.otf',
                      fontWeight: FontWeight.bold,
                      color: AppColor.marengo,
                      fontSize: height * 0.03),
                ),
                GestureDetector(
                  onTap: () {
                    trackerstop(context);
                  },
                  child: Icon(Icons.cancel,
                      color: AppColor.grayborder, size: height * 0.04),
                ),
              ],
            ),
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                  .translate('Customer_name')
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                            GestureDetector(
                              onTap: () {
                                _addcustomerDialog(context);
                              },
                              child: Icon(
                                Icons.add_circle_outline,
                                size: height * 0.03,
                                color: AppColor.marengo,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Container(
                            width: width,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1, color: AppColor.grayborder)),
                            child: Padding(
                              padding: EdgeInsets.all(width * 0.02),
                              child: DropdownButton<String>(
                                value: customerValue,
                                items: _customerlist.map((String item) {
                                  return DropdownMenuItem<String>(
                                      child: Text(item.split('/')[0]),
                                      value: item);
                                }).toList(),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: AppColor.marengo,
                                ),
                                iconSize: height * 0.02,
                                elevation: 10,
                                style: const TextStyle(color: AppColor.marengo),
                                underline: Container(
                                  height: 0,
                                  color: Colors.black,
                                ),
                                isExpanded: true,
                                onChanged: (String? value) {
                                  setState(() {
                                    this.customerValue = value!;
                                    print('custname $customerValue');
                                    custname =
                                        customerValue.toString().split('/')[0];
                                    gid =
                                        customerValue.toString().split('/')[1];
                                  });
                                },
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                  .translate('CONTACT_PERSON')
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                            GestureDetector(
                              onTap: () {
                                _addcontactDialog(context);
                              },
                              child: Icon(
                                Icons.add_circle_outline,
                                size: height * 0.03,
                                color: AppColor.marengo,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: width,
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: AppColor.grayborder)),
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: DropdownButton<String>(
                                  items: _dropdownValues
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                              child: Text(item), value: item))
                                      .toList(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: AppColor.marengo,
                                  ),
                                  iconSize: height * 0.02,
                                  elevation: 10,
                                  style:
                                      const TextStyle(color: AppColor.marengo),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.black,
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? value) {
                                    setState(() {
                                      this.dropdownValue = value!;
                                      print(dropdownValue);
                                    });
                                  },
                                  value: dropdownValue,
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                  .translate('USER')
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     _createnewDialog(context);
                            //   },
                            //   child: Icon(
                            //     Icons.add_circle_outline,
                            //     size: height * 0.03,
                            //     color: AppColor.marengo,
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        AbsorbPointer(
                          child: TextField(
                            controller: userController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                                color: AppColor.marengo,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    // Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           Translate.of(context)!
                    //               .translate('Topic')
                    //               .toUpperCase(),
                    //           style: TextStyle(
                    //               color: AppColor.marengo,
                    //               fontSize: height * 0.02),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(
                    //       height: height * 0.005,
                    //     ),
                    //     TextField(
                    //       controller: topicController,
                    //       decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColor.grayborder,
                    //           ),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColor.blue,
                    //           ),
                    //         ),
                    //         hintStyle: TextStyle(
                    //           fontSize: height * 0.022,
                    //           color: AppColor.gray,
                    //         ),
                    //         labelStyle: TextStyle(
                    //           fontSize: height * 0.022,
                    //           color: AppColor.marengo,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: height * 0.01,
                    // ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                  .translate('CONTACT_TYPE')
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: width,
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: AppColor.grayborder)),
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: DropdownButton<String>(
                                  items: _contacttypeValues
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                              child: Text(item), value: item))
                                      .toList(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: AppColor.marengo,
                                  ),
                                  iconSize: height * 0.02,
                                  elevation: 10,
                                  style:
                                      const TextStyle(color: AppColor.marengo),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.black,
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? value) {
                                    setState(() {
                                      this.contacttypeValue = value!;
                                      print(contacttypeValue);
                                    });
                                  },
                                  value: contacttypeValue,
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                  .translate('Device')
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                            GestureDetector(
                              onTap: () {
                                _adddeviceDialog(context);
                              },
                              child: Icon(
                                Icons.add_circle_outline,
                                size: height * 0.03,
                                color: AppColor.marengo,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: width,
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: AppColor.grayborder)),
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: DropdownButton<String>(
                                  items: _customeralldevicelist
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                              child: Text(item), value: item))
                                      .toList(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: AppColor.marengo,
                                  ),
                                  iconSize: height * 0.02,
                                  elevation: 10,
                                  style:
                                      const TextStyle(color: AppColor.marengo),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.black,
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? value) {
                                    setState(() {
                                      this.customeralldeviceValue = value!;
                                    });
                                  },
                                  value: customeralldeviceValue,
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    // Column(
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Text(
                    //           Translate.of(context)!
                    //               .translate('TARIFF_NAME')
                    //               .toUpperCase(),
                    //           style: TextStyle(
                    //               color: AppColor.marengo,
                    //               fontSize: height * 0.02),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(
                    //       height: height * 0.005,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {},
                    //       child: Container(
                    //           width: width,
                    //           height: height * 0.06,
                    //           decoration: BoxDecoration(
                    //               color: AppColor.white,
                    //               borderRadius: BorderRadius.circular(5),
                    //               border: Border.all(
                    //                   width: 1, color: AppColor.grayborder)),
                    //           child: Padding(
                    //             padding: EdgeInsets.all(width * 0.02),
                    //             child: DropdownButton<String>(
                    //               items: _dropdownValues
                    //                   .map((String item) =>
                    //                       DropdownMenuItem<String>(
                    //                           child: Text(item), value: item))
                    //                   .toList(),
                    //               icon: Icon(
                    //                 Icons.keyboard_arrow_down_sharp,
                    //                 color: AppColor.marengo,
                    //               ),
                    //               iconSize: height * 0.02,
                    //               elevation: 10,
                    //               style: const TextStyle(color: AppColor.marengo),
                    //               underline: Container(
                    //                 height: 0,
                    //                 color: Colors.black,
                    //               ),
                    //               isExpanded: true,
                    //               onChanged: (String? value) {
                    //                 setState(() {
                    //                   this.dropdownValue = value!;
                    //                   print(dropdownValue);
                    //                 });
                    //               },
                    //               value: dropdownValue,
                    //             ),
                    //           )),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: height * 0.01,
                    // ),
                    // Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           Translate.of(context)!
                    //               .translate('Invoice')
                    //               .toUpperCase(),
                    //           style: TextStyle(
                    //               color: AppColor.marengo,
                    //               fontSize: height * 0.02),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(
                    //       height: height * 0.005,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {},
                    //       child: Container(
                    //           width: width,
                    //           height: height * 0.06,
                    //           decoration: BoxDecoration(
                    //               color: AppColor.white,
                    //               borderRadius: BorderRadius.circular(5),
                    //               border: Border.all(
                    //                   width: 1, color: AppColor.grayborder)),
                    //           child: Padding(
                    //             padding: EdgeInsets.all(width * 0.02),
                    //             child: DropdownButton<String>(
                    //               items: _dropdownValues
                    //                   .map((String item) =>
                    //                       DropdownMenuItem<String>(
                    //                           child: Text(item), value: item))
                    //                   .toList(),
                    //               icon: Icon(
                    //                 Icons.keyboard_arrow_down_sharp,
                    //                 color: AppColor.marengo,
                    //               ),
                    //               iconSize: height * 0.02,
                    //               elevation: 10,
                    //               style: const TextStyle(color: AppColor.marengo),
                    //               underline: Container(
                    //                 height: 0,
                    //                 color: Colors.black,
                    //               ),
                    //               isExpanded: true,
                    //               onChanged: (String? value) {
                    //                 setState(() {
                    //                   this.dropdownValue = value!;
                    //                   print(dropdownValue);
                    //                 });
                    //               },
                    //               value: dropdownValue,
                    //             ),
                    //           )),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: height * 0.01,
                    // ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                      .translate('Start')
                                      .toUpperCase() +
                                  " " +
                                  Translate.of(context)!
                                      .translate('DATE')
                                      .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectstartDate(context);
                          },
                          child: AbsorbPointer(
                            child: TextField(
                              controller: startdateController,
                              decoration: new InputDecoration(
                                  hintText: startdateController.text,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
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
                                    color: AppColor.marengo,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppColor.marengo,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                      .translate('End')
                                      .toUpperCase() +
                                  " " +
                                  Translate.of(context)!
                                      .translate('DATE')
                                      .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectendDate(context);
                          },
                          child: AbsorbPointer(
                            child: TextField(
                              controller: enddateController,
                              decoration: new InputDecoration(
                                  hintText: enddateController.text,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
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
                                    color: AppColor.marengo,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppColor.marengo,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                      .translate('Start')
                                      .toUpperCase() +
                                  " " +
                                  Translate.of(context)!
                                      .translate('TIME')
                                      .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectstartTime(context);
                          },
                          child: AbsorbPointer(
                            child: TextField(
                              controller: starttimeController,
                              decoration: new InputDecoration(
                                hintText: starttimeController.text,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
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
                                  color: AppColor.marengo,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                      .translate('End')
                                      .toUpperCase() +
                                  " " +
                                  Translate.of(context)!
                                      .translate('TIME')
                                      .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectendTime(context);
                          },
                          child: AbsorbPointer(
                            child: TextField(
                              controller: endtimeController,
                              decoration: new InputDecoration(
                                hintText: endtimeController.text,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
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
                                  color: AppColor.marengo,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                  .translate('Duration')
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        AbsorbPointer(
                          child: TextField(
                            decoration: new InputDecoration(
                              labelText: '${durationController.text} m',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: height * 0.022,
                                color: AppColor.gray,
                              ),
                              labelStyle: TextStyle(
                                fontSize: height * 0.022,
                                color: AppColor.marengo,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    CupertinoTextField(
                      controller: jobdescController,
                      placeholder:
                          Translate.of(context)!.translate('job_description'),
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.start,
                      enabled: true,
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                      placeholderStyle: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                      autofocus: false,
                      cursorColor: AppColor.marengo,
                      enableInteractiveSelection: true,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(
                            color: AppColor.grayborder,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      expands: false,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    CupertinoTextField(
                      controller: reportnotesController,
                      placeholder:
                          Translate.of(context)!.translate('notes_report'),
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.start,
                      enabled: true,
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 5,
                      placeholderStyle: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                      style: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                      autofocus: false,
                      cursorColor: AppColor.marengo,
                      enableInteractiveSelection: true,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(
                            color: AppColor.grayborder,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      expands: false,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Translate.of(context)!.translate('Save'),
                          style: TextStyle(
                            fontSize: height * 0.022,
                            color: AppColor.white,
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.blue),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.015)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 30))),
                    onPressed: () async {
                      if (custname.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select customer name");
                      } else if (startdateController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Please select start date");
                      } else if (enddateController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Please select end date");
                      } else if (starttimeController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Please select start time");
                      } else if (endtimeController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Please select end time");
                      } else {
                        bool result =
                            await InternetConnectionChecker().hasConnection;
                        if (result == true) {
                          print('Internet :)');
                          fromtimer == false
                              ? AddConnection()
                              : AddConnectionfromtimer();
                        } else {
                          print('Internet GetConnesr wection dlt :)');

                          print('No internet :( ');
                        }
                      }

                      // db.insertActivity(dataLocal);
                    },
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  ElevatedButton(
                    child: Row(
                      children: [
                        Text(
                          Translate.of(context)!.translate('cancel'),
                          style: TextStyle(
                            fontSize: height * 0.022,
                            color: AppColor.white,
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.marengo),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.015)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 30))),
                    onPressed: () {
                      trackerstop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
      },
    );
  }

  _displayeditDialog(BuildContext context
      // String? connectionid
      ) async {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Translate.of(context)!.translate('Edit_activity'),
                  style: TextStyle(
                      fontFamily: 'NotoSansSC-Bold.otf',
                      fontWeight: FontWeight.bold,
                      color: AppColor.marengo,
                      fontSize: height * 0.03),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.cancel,
                      color: AppColor.grayborder, size: height * 0.04),
                ),
              ],
            ),
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                  .translate('Customer_name')
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                            GestureDetector(
                              onTap: () {
                                _addcustomerDialog(context);
                              },
                              child: Icon(
                                Icons.add_circle_outline,
                                size: height * 0.03,
                                color: AppColor.marengo,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: width,
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: AppColor.grayborder)),
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: DropdownButton<String>(
                                  items: _customerlist.map((String item) {
                                    return DropdownMenuItem<String>(
                                        child: Text(item.split('/')[0]),
                                        value: item);
                                  }).toList(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: AppColor.marengo,
                                  ),
                                  iconSize: height * 0.02,
                                  elevation: 10,
                                  style:
                                      const TextStyle(color: AppColor.marengo),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.black,
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? value) {
                                    setState(() {
                                      this.customerValue = value!;
                                      print('custname $customerValue');
                                      custname = customerValue
                                          .toString()
                                          .split('/')[0];
                                      gid = customerValue
                                          .toString()
                                          .split('/')[1];
                                    });
                                  },
                                  value: customerValue,
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                  .translate('CONTACT_PERSON')
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                            GestureDetector(
                              onTap: () {
                                _addcontactDialog(context);
                              },
                              child: Icon(
                                Icons.add_circle_outline,
                                size: height * 0.03,
                                color: AppColor.marengo,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: width,
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: AppColor.grayborder)),
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: DropdownButton<String>(
                                  items: _dropdownValues
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                              child: Text(item), value: item))
                                      .toList(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: AppColor.marengo,
                                  ),
                                  iconSize: height * 0.02,
                                  elevation: 10,
                                  style:
                                      const TextStyle(color: AppColor.marengo),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.black,
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? value) {
                                    setState(() {
                                      this.dropdownValue = value!;
                                      print(dropdownValue);
                                    });
                                  },
                                  value: dropdownValue,
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                  .translate('USER')
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     _createnewDialog(context);
                            //   },
                            //   child: Icon(
                            //     Icons.add_circle_outline,
                            //     size: height * 0.03,
                            //     color: AppColor.marengo,
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Container(
                        //       width: width,
                        //       height: height * 0.06,
                        //       decoration: BoxDecoration(
                        //           color: AppColor.white,
                        //           borderRadius: BorderRadius.circular(5),
                        //           border: Border.all(
                        //               width: 1, color: AppColor.grayborder)),
                        //       child: Padding(
                        //         padding: EdgeInsets.all(width * 0.02),
                        //         child: DropdownButton<String>(
                        //           items: _dropdownValues
                        //               .map((String item) =>
                        //                   DropdownMenuItem<String>(
                        //                       child: Text(item), value: item))
                        //               .toList(),
                        //           icon: Icon(
                        //             Icons.keyboard_arrow_down_sharp,
                        //             color: AppColor.marengo,
                        //           ),
                        //           iconSize: height * 0.02,
                        //           elevation: 10,
                        //           style:
                        //               const TextStyle(color: AppColor.marengo),
                        //           underline: Container(
                        //             height: 0,
                        //             color: Colors.black,
                        //           ),
                        //           isExpanded: true,
                        //           onChanged: (String? value) {
                        //             setState(() {
                        //               this.dropdownValue = value!;
                        //               print(dropdownValue);
                        //             });
                        //           },
                        //           value: dropdownValue,
                        //         ),
                        //       )),
                        // ),
                        AbsorbPointer(
                          child: TextField(
                            controller: userController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                                color: AppColor.marengo,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    // Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           Translate.of(context)!
                    //               .translate('Topic')
                    //               .toUpperCase(),
                    //           style: TextStyle(
                    //               color: AppColor.marengo,
                    //               fontSize: height * 0.02),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(
                    //       height: height * 0.005,
                    //     ),
                    //     TextField(
                    //       decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColor.grayborder,
                    //           ),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: AppColor.blue,
                    //           ),
                    //         ),
                    //         hintStyle: TextStyle(
                    //           fontSize: height * 0.022,
                    //           color: AppColor.gray,
                    //         ),
                    //         labelStyle: TextStyle(
                    //           fontSize: height * 0.022,
                    //           color: AppColor.marengo,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: height * 0.01,
                    // ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                  .translate('CONTACT_TYPE')
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: width,
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: AppColor.grayborder)),
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: DropdownButton<String>(
                                  items: _contacttypeValues
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                              child: Text(item), value: item))
                                      .toList(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: AppColor.marengo,
                                  ),
                                  iconSize: height * 0.02,
                                  elevation: 10,
                                  style:
                                      const TextStyle(color: AppColor.marengo),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.black,
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? value) {
                                    setState(() {
                                      this.contacttypeValue = value!;
                                      print(contacttypeValue);
                                    });
                                  },
                                  value: contacttypeValue,
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                  .translate('Device')
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                            GestureDetector(
                              onTap: () {
                                _adddeviceDialog(context);
                              },
                              child: Icon(
                                Icons.add_circle_outline,
                                size: height * 0.03,
                                color: AppColor.marengo,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: width,
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: AppColor.grayborder)),
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: DropdownButton<String>(
                                  items: _customerdevicelist
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                              child: Text(item), value: item))
                                      .toList(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: AppColor.marengo,
                                  ),
                                  iconSize: height * 0.02,
                                  elevation: 10,
                                  style:
                                      const TextStyle(color: AppColor.marengo),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.black,
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? value) {
                                    setState(() {
                                      this.customerdeviceValue = value!;
                                      print(customerdeviceValue);
                                    });
                                  },
                                  value: customerdeviceValue,
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    // Column(
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Text(
                    //           Translate.of(context)!
                    //               .translate('TARIFF_NAME')
                    //               .toUpperCase(),
                    //           style: TextStyle(
                    //               color: AppColor.marengo,
                    //               fontSize: height * 0.02),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(
                    //       height: height * 0.005,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {},
                    //       child: Container(
                    //           width: width,
                    //           height: height * 0.06,
                    //           decoration: BoxDecoration(
                    //               color: AppColor.white,
                    //               borderRadius: BorderRadius.circular(5),
                    //               border: Border.all(
                    //                   width: 1, color: AppColor.grayborder)),
                    //           child: Padding(
                    //             padding: EdgeInsets.all(width * 0.02),
                    //             child: DropdownButton<String>(
                    //               items: _dropdownValues
                    //                   .map((String item) =>
                    //                       DropdownMenuItem<String>(
                    //                           child: Text(item), value: item))
                    //                   .toList(),
                    //               icon: Icon(
                    //                 Icons.keyboard_arrow_down_sharp,
                    //                 color: AppColor.marengo,
                    //               ),
                    //               iconSize: height * 0.02,
                    //               elevation: 10,
                    //               style: const TextStyle(color: AppColor.marengo),
                    //               underline: Container(
                    //                 height: 0,
                    //                 color: Colors.black,
                    //               ),
                    //               isExpanded: true,
                    //               onChanged: (String? value) {
                    //                 setState(() {
                    //                   this.dropdownValue = value!;
                    //                   print(dropdownValue);
                    //                 });
                    //               },
                    //               value: dropdownValue,
                    //             ),
                    //           )),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: height * 0.01,
                    // ),
                    // Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           Translate.of(context)!
                    //               .translate('Invoice')
                    //               .toUpperCase(),
                    //           style: TextStyle(
                    //               color: AppColor.marengo,
                    //               fontSize: height * 0.02),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(
                    //       height: height * 0.005,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {},
                    //       child: Container(
                    //           width: width,
                    //           height: height * 0.06,
                    //           decoration: BoxDecoration(
                    //               color: AppColor.white,
                    //               borderRadius: BorderRadius.circular(5),
                    //               border: Border.all(
                    //                   width: 1, color: AppColor.grayborder)),
                    //           child: Padding(
                    //             padding: EdgeInsets.all(width * 0.02),
                    //             child: DropdownButton<String>(
                    //               items: _dropdownValues
                    //                   .map((String item) =>
                    //                       DropdownMenuItem<String>(
                    //                           child: Text(item), value: item))
                    //                   .toList(),
                    //               icon: Icon(
                    //                 Icons.keyboard_arrow_down_sharp,
                    //                 color: AppColor.marengo,
                    //               ),
                    //               iconSize: height * 0.02,
                    //               elevation: 10,
                    //               style: const TextStyle(color: AppColor.marengo),
                    //               underline: Container(
                    //                 height: 0,
                    //                 color: Colors.black,
                    //               ),
                    //               isExpanded: true,
                    //               onChanged: (String? value) {
                    //                 setState(() {
                    //                   this.dropdownValue = value!;
                    //                   print(dropdownValue);
                    //                 });
                    //               },
                    //               value: dropdownValue,
                    //             ),
                    //           )),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: height * 0.01,
                    // ),
                    // Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           Translate.of(context)!
                    //                   .translate('Start')
                    //                   .toUpperCase() +
                    //               " " +
                    //               Translate.of(context)!
                    //                   .translate('DATE')
                    //                   .toUpperCase(),
                    //           style: TextStyle(
                    //               color: AppColor.marengo,
                    //               fontSize: height * 0.02),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(
                    //       height: height * 0.005,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         selectstartDate(context);
                    //       },
                    //       child: AbsorbPointer(
                    //         child: TextField(
                    //           controller: startdateController,
                    //           decoration: new InputDecoration(
                    //               hintText: startdateController.text,
                    //               border: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                   color: AppColor.grayborder,
                    //                 ),
                    //               ),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                   color: AppColor.blue,
                    //                 ),
                    //               ),
                    //               hintStyle: TextStyle(
                    //                 fontSize: height * 0.022,
                    //                 color: AppColor.gray,
                    //               ),
                    //               labelStyle: TextStyle(
                    //                 fontSize: height * 0.022,
                    //                 color: AppColor.marengo,
                    //               ),
                    //               prefixIcon: Icon(
                    //                 Icons.calendar_month_outlined,
                    //                 color: AppColor.marengo,
                    //               )),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: height * 0.01,
                    // ),
                    // Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           Translate.of(context)!
                    //                   .translate('End')
                    //                   .toUpperCase() +
                    //               " " +
                    //               Translate.of(context)!
                    //                   .translate('DATE')
                    //                   .toUpperCase(),
                    //           style: TextStyle(
                    //               color: AppColor.marengo,
                    //               fontSize: height * 0.02),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(
                    //       height: height * 0.005,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         selectendDate(context);
                    //       },
                    //       child: AbsorbPointer(
                    //         child: TextField(
                    //           controller: enddateController,
                    //           decoration: new InputDecoration(
                    //               hintText: enddateController.text,
                    //               border: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                   color: AppColor.grayborder,
                    //                 ),
                    //               ),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                   color: AppColor.blue,
                    //                 ),
                    //               ),
                    //               hintStyle: TextStyle(
                    //                 fontSize: height * 0.022,
                    //                 color: AppColor.gray,
                    //               ),
                    //               labelStyle: TextStyle(
                    //                 fontSize: height * 0.022,
                    //                 color: AppColor.marengo,
                    //               ),
                    //               prefixIcon: Icon(
                    //                 Icons.calendar_month_outlined,
                    //                 color: AppColor.marengo,
                    //               )),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: height * 0.01,
                    // ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                      .translate('Start')
                                      .toUpperCase() +
                                  " " +
                                  Translate.of(context)!
                                      .translate('TIME')
                                      .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectstartTime(context);
                          },
                          child: AbsorbPointer(
                            child: TextField(
                              controller: starttimeController,
                              decoration: new InputDecoration(
                                hintText: starttimeController.text,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
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
                                  color: AppColor.marengo,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                      .translate('End')
                                      .toUpperCase() +
                                  " " +
                                  Translate.of(context)!
                                      .translate('TIME')
                                      .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectendTime(context);
                          },
                          child: AbsorbPointer(
                            child: TextField(
                              controller: endtimeController,
                              decoration: new InputDecoration(
                                hintText: endtimeController.text,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
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
                                  color: AppColor.marengo,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context)!
                                  .translate('Duration')
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: AppColor.marengo,
                                  fontSize: height * 0.02),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        AbsorbPointer(
                          child: TextField(
                            decoration: new InputDecoration(
                              labelText: '${durationController.text} m',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: height * 0.022,
                                color: AppColor.gray,
                              ),
                              labelStyle: TextStyle(
                                fontSize: height * 0.022,
                                color: AppColor.marengo,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    CupertinoTextField(
                      controller: jobdescController,
                      placeholder:
                          Translate.of(context)!.translate('job_description'),
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.start,
                      enabled: true,
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                      placeholderStyle: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                      autofocus: false,
                      cursorColor: AppColor.marengo,
                      enableInteractiveSelection: true,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(
                            color: AppColor.grayborder,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      expands: false,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    CupertinoTextField(
                      controller: reportnotesController,
                      placeholder:
                          Translate.of(context)!.translate('notes_report'),
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.start,
                      enabled: true,
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 5,
                      placeholderStyle: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                      style: TextStyle(
                        fontSize: height * 0.022,
                        color: AppColor.gray,
                      ),
                      autofocus: false,
                      cursorColor: AppColor.marengo,
                      enableInteractiveSelection: true,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(
                            color: AppColor.grayborder,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      expands: false,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Translate.of(context)!.translate('Save'),
                          style: TextStyle(
                            fontSize: height * 0.022,
                            color: AppColor.white,
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.blue),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.015)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 30))),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String userToken =
                          prefs.getString('userToken').toString();
                      String userid = prefs.getInt('userid').toString();
                      Addactivity addactivity = Addactivity(
                          customer_name: custname,
                          groupid: gid,
                          userid: userid,
                          billing_state: 'Bill',
                          startDate: startdateController.text +
                              ' ${starttimeController.text}',
                          endDate: enddateController.text +
                              ' ${endtimeController.text}');

                      // db.updateactivity(addactivity);
                      // EditConnection(connectionid!);
                    },
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  ElevatedButton(
                    child: Row(
                      children: [
                        Text(
                          Translate.of(context)!.translate('cancel'),
                          style: TextStyle(
                            fontSize: height * 0.022,
                            color: AppColor.white,
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.marengo),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.015)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 30))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
      },
    );
  }

  _addcustomerDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddCustomer();
      },
    );
  }

  _adddeviceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddDevice();
      },
    );
  }

  _addcontactDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddContact();
      },
    );
  }
}
