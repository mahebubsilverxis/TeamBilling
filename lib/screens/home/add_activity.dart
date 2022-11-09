import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teambill/local_database/data.dart';
import 'package:teambill/model/model.dart';
import 'package:teambill/res/colors.dart';
import 'package:teambill/screens/home/add_contact.dart';
import 'package:teambill/screens/home/add_customer.dart';
import 'package:teambill/screens/home/add_device.dart';
import '../../utils/translate.dart';

class AddActivityDialog extends StatefulWidget {
  const AddActivityDialog({
    Key? key,
    required this.userName,
    required this.onClose,
  }) : super(key: key);

  final String userName;
  final Function() onClose;

  @override
  State<AddActivityDialog> createState() => _AddActivityDialogState();
}

class _AddActivityDialogState extends State<AddActivityDialog> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDayFormat time = TimeOfDayFormat.HH_colon_mm;

  bool? activitytap;
  bool fromtimer = false;
  late DB db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DB();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    String? customerValue = 'Select';
    List<String> _customerlist = [
      'Select',
    ];
    String custname = '';
    String gid = '';

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

    String? customeralldeviceValue = 'Select';
    List<String> _customeralldevicelist = [
      'Select',
    ];

    TextEditingController startdateController = TextEditingController();
    TextEditingController enddateController = TextEditingController();
    TextEditingController starttimeController = TextEditingController();
    TextEditingController endtimeController = TextEditingController();
    TextEditingController durationController = TextEditingController();
    TextEditingController jobdescController = TextEditingController();
    TextEditingController reportnotesController = TextEditingController();
    TextEditingController userController =
        TextEditingController(text: widget.userName);

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
              onTap: widget.onClose(),
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
                              color: AppColor.marengo, fontSize: height * 0.02),
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
                                  child: Text(item.split('/')[0]), value: item);
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
                                customerValue = value!;
                                print('custname $customerValue');
                                custname =
                                    customerValue.toString().split('/')[0];
                                gid = customerValue.toString().split('/')[1];
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
                              color: AppColor.marengo, fontSize: height * 0.02),
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
                              style: const TextStyle(color: AppColor.marengo),
                              underline: Container(
                                height: 0,
                                color: Colors.black,
                              ),
                              isExpanded: true,
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
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
                              color: AppColor.marengo, fontSize: height * 0.02),
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
                              color: AppColor.marengo, fontSize: height * 0.02),
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
                              style: const TextStyle(color: AppColor.marengo),
                              underline: Container(
                                height: 0,
                                color: Colors.black,
                              ),
                              isExpanded: true,
                              onChanged: (String? value) {
                                setState(() {
                                  contacttypeValue = value!;
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
                              color: AppColor.marengo, fontSize: height * 0.02),
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
                              style: const TextStyle(color: AppColor.marengo),
                              underline: Container(
                                height: 0,
                                color: Colors.black,
                              ),
                              isExpanded: true,
                              onChanged: (String? value) {
                                setState(() {
                                  customeralldeviceValue = value!;
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
                              color: AppColor.marengo, fontSize: height * 0.02),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectstartDate(
                          context,
                          onSelect: (date) {
                            startdateController.text = date;
                          },
                        );
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
                              color: AppColor.marengo, fontSize: height * 0.02),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectendDate(
                          context,
                          onSelect: (date) {
                            enddateController.text = date;
                          },
                        );
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
                              color: AppColor.marengo, fontSize: height * 0.02),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectstartTime(
                          context,
                          onSelect: (time) {
                            starttimeController.text = time;
                          },
                        );
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
                              color: AppColor.marengo, fontSize: height * 0.02),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectendTime(
                          context,
                          onSelect: (time) {
                            endtimeController.text = time;
                          },
                        );
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
                              color: AppColor.marengo, fontSize: height * 0.02),
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
                        color: AppColor.grayborder, style: BorderStyle.solid),
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
                  placeholder: Translate.of(context)!.translate('notes_report'),
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
                        color: AppColor.grayborder, style: BorderStyle.solid),
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
                    backgroundColor: MaterialStateProperty.all(AppColor.blue),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.015)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 30))),
                onPressed: () async {
                  if (custname.isEmpty) {
                    Fluttertoast.showToast(msg: "Please select customer name");
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
                          ? AddConnection(
                              customerName: custname,
                              groupid: gid,
                              startDate: startdateController.text +
                                  ' ${DateTime.now().hour < 10 ? '0${DateTime.now().hour.toString()}' : DateTime.now().hour.toString()}:${DateTime.now().minute < 10 ? '0${DateTime.now().minute.toString()}' : DateTime.now().minute.toString()}',
                              endDate: enddateController.text +
                                  ' ${DateTime.now().hour < 10 ? '0${DateTime.now().hour.toString()}' : DateTime.now().hour.toString()}:${DateTime.now().minute < 10 ? '0${DateTime.now().minute.toString()}' : DateTime.now().minute.toString()}')
                          : AddConnectionfromtimer(
                              customerName: custname,
                              groupid: gid,
                              startDate: startdateController.text +
                                  ' ${starttimeController.text}',
                              endDate: enddateController.text +
                                  ' ${endtimeController.text}',
                            );
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
                        horizontal: width * 0.02, vertical: height * 0.015)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 30))),
                onPressed: widget.onClose(),
              ),
            ],
          ),
        ],
      );
    });
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

  Future<void> selectstartDate(BuildContext context,
      {Function(String)? onSelect}) async {
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
        onSelect?.call(date);
      });
  }

  Future<void> selectendDate(BuildContext context,
      {Function(String)? onSelect}) async {
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
        //enddateController.text = date;
        onSelect?.call(date);
      });
  }

  Future<void> selectstartTime(BuildContext context,
      {Function(String)? onSelect}) async {
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
        onSelect?.call(time.toString());
      });
    }
  }

  Future<void> selectendTime(BuildContext context,
      {Function(String)? onSelect}) async {
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
        onSelect?.call(time.toString());
      });
    }
  }

  void AddConnectionfromtimer({
    required String customerName,
    required String groupid,
    required String startDate,
    required String endDate,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getInt('userid').toString();
    FocusScope.of(context).unfocus();
    Addactivity addactivity = Addactivity(
      customer_name: customerName,
      groupid: groupid,
      userid: userid,
      billing_state: 'Bill',
      startDate:
          startDate, //startdateController.text + ' ${starttimeController.text}',
      endDate: endDate, //enddateController.text + ' ${endtimeController.text}'
    );
    db.addactivity(addactivity);
    setState(() {
      activitytap = true;
    });
    // }
  }

  void AddConnection({
    required String customerName,
    required String groupid,
    required String startDate,
    required String endDate,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getInt('userid').toString();

    FocusScope.of(context).unfocus();
    Addactivity addactivity = Addactivity(
      customer_name: customerName,
      groupid: groupid,
      userid: userid,
      billing_state: 'Bill',
      startDate: startDate,
      endDate: endDate,
    );
    db.addactivity(addactivity);
    setState(() {
      activitytap = true;
    });
    // }
  }
}
