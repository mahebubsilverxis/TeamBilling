import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teambill/res/colors.dart';
import 'package:teambill/res/images.dart';
import '../../utils/translate.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    String dropdownValue = 'Select';
    List<String> _dropdownValues = [
      'Select',
    ];

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Translate.of(context)!.translate('Add_Contact'),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Translate.of(context)!
                              .translate('MR/MRS')
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
                          width: width * 0.3,
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
                              .translate('FIRST_NAME')
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
                              .translate('LAST_NAME')
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
                              .translate('DEPARTMENT')
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
                              .translate('FUNCTION')
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
                              .translate('BUSINESS')
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
                      decoration: new InputDecoration(
                          hintText: '',
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
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImage.call,
                                height: height * 0.03,
                                width: width * 0.03,
                                color: AppColor.marengo,
                              ),
                            ],
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
                              .translate('MOBILE')
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
                      decoration: new InputDecoration(
                          hintText: '',
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
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImage.call,
                                height: height * 0.03,
                                width: width * 0.03,
                                color: AppColor.marengo,
                              ),
                            ],
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
                              .translate('HOME')
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
                      decoration: new InputDecoration(
                          hintText: '',
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
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImage.call,
                                height: height * 0.03,
                                width: width * 0.03,
                                color: AppColor.marengo,
                              ),
                            ],
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
                              .translate('SERVICE_EMAIL')
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
                      decoration: new InputDecoration(
                          hintText: '',
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
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImage.email,
                                height: height * 0.03,
                                width: width * 0.03,
                                color: AppColor.marengo,
                              ),
                            ],
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
                              .translate('PRIVATE_EMAIL')
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
                      decoration: new InputDecoration(
                          hintText: '',
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
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImage.email,
                                height: height * 0.03,
                                width: width * 0.03,
                                color: AppColor.marengo,
                              ),
                            ],
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
                              .translate('SELECT_DEVICE')
                              .toUpperCase(),
                          style: TextStyle(
                              color: AppColor.marengo, fontSize: height * 0.02),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    CupertinoTextField(
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.start,
                      enabled: true,
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 5,
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
