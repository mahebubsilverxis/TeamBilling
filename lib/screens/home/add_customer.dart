import 'package:flutter/material.dart';
import 'package:teambill/res/colors.dart';
import '../../utils/translate.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Translate.of(context)!.translate('Add_customer'),
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
        content: SingleChildScrollView(
          child: Column(
            children: [
              Column(
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
                    ],
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.grayborder,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
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
                            .translate('PLANNED_OPERATING_TIME')
                            .toUpperCase(),
                        style: TextStyle(
                            color: AppColor.marengo, fontSize: height * 0.02),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.grayborder,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
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
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
            ],
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
                onPressed: () {
                  Navigator.pop(context);
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
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
