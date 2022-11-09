import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teambill/model/model.dart';
import '../screens/home/home_screen.dart';
import '../screens/signin/signin_screen.dart';
import 'common_Api.dart';

class Api {
  // Login
  Future<UserModel?> getToken(String t_subdomain, String t_url, String email,
      String password, bool keepsignin, BuildContext context) async {
    // New :
    final String api_get_token = t_url + gettoken;
    // OLD :
    // final String api_get_token = mainurl_api_https +t_subdomain + '.' +t_url + gettoken;
    print("URL =-=-=- $api_get_token");
    try {
      final response = await http.post(Uri.parse(api_get_token), headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      }, body: {
        "email": email,
        "password": password,
      });

      print("respose get token : ${response.body}");
      Map<String, dynamic> map = jsonDecode(response.body.toString());

      if (response.statusCode == 201 || response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(map);
        if (map["status"] == "Success") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userToken', userModel.data.token);
          prefs.setInt('userid', userModel.data.user_id);
          prefs.setString('tenantUrl', t_url);

          final userName =
              await Api().getUserName(userModel.data.user_id.toString());
          prefs.setString('username', userName);

          //prefs.setString('tenantsubdomain', t_subdomain);
          if (keepsignin == true) {
            prefs.setBool('isLogin', true);
          } else {
            prefs.setBool('isLogin', false);
          }
          print(
              "current userToken is ${prefs.getString('userToken').toString()}");

          print("user is logged in ${prefs.getBool('isLogin').toString()}");
          print("user is logged in ${prefs.getInt('userid').toString()}");
          Fluttertoast.showToast(msg: userModel.message);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          return userModelFromJson(response.body);
        } else {
          Fluttertoast.showToast(msg: userModel.message);
          print("Error Response msg : ${userModel.toString()}");
          return null;
        }
      } else {
        UserModel userModel = UserModel.fromJson(map);
        Fluttertoast.showToast(msg: userModel.message);
        print("Error Response msg : ${userModel.toString()}");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // get customer list

  Future<CustomerModel> getCustomerlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken').toString();
    String t_url = prefs.getString('tenantUrl').toString();
    // String t_subdomain = prefs.getString('tenantsubdomain').toString();
    final String api_customers = t_url + getcustomers;
    print("URL =-=-=- $api_customers");
    final response = await http.get(
      Uri.parse(api_customers),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Bearer $userToken"
      },
    );
    Map<String, dynamic> map = jsonDecode(response.body.toString());
    CustomerModel customerModel = CustomerModel.fromJson(map);
    print("respose get customer list : ${response.body}");
    return customerModelFromJson(response.body);
  }

  Future<String> getUserName(String userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken').toString();
    String t_url = prefs.getString('tenantUrl').toString();
    // String t_subdomain = prefs.getString('tenantsubdomain').toString();
    final String api_customers = t_url + getusers;
    print("URL =-=-=- $api_customers");
    final response = await http.get(
      Uri.parse(api_customers),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Bearer $userToken"
      },
    );
    final userList =
        jsonDecode(response.body.toString())['data'] as List<dynamic>;
    final user = userList.firstWhere((element) => element['id'] == userid);
    return user['api_user_name'];
  }

  // get customer device list

  Future<Userdevicelistmodel> getCustomerdevicelist(String? groupid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken').toString();
    String t_url = prefs.getString('tenantUrl').toString();
    // String t_subdomain = prefs.getString('tenantsubdomain').toString();
    final String api_customersdevice = t_url + getcustomersdevices;
    print("URL =-=-=- $api_customersdevice");
    final response = await http.post(Uri.parse(api_customersdevice), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer $userToken"
    }, body: {
      "groupid": groupid,
    });

    print("respose get customer device list : ${response.body}");

    return userdevicelistmodelFromJson(response.body);
  }

  // get customer all device list

  Future<Devicelistmodel> getCustomeralldevicelist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken').toString();
    String t_url = prefs.getString('tenantUrl').toString();
    // String t_subdomain = prefs.getString('tenantsubdomain').toString();
    final String api_customersdevice = t_url + getcustomersdevices;
    print("URL =-=-=- $api_customersdevice");
    final response = await http.post(
      Uri.parse(api_customersdevice),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Bearer $userToken"
      },
    );

    print("response get customer device list : ${response.body}");

    return devicelistmodelFromJson(response.body);
  }

  // get connections

  Future<Connectionmodel> getConnectionslist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken').toString();
    print(userToken);
    String t_url = prefs.getString('tenantUrl').toString();
    // String t_subdomain = prefs.getString('tenantsubdomain').toString();
    final String api_getconnections = t_url + getconnections;
    print("URL =-=-=- $api_getconnections");
    final response = await http.get(
      Uri.parse(api_getconnections),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Bearer $userToken"
      },
    );

    print("respose get connections list : ${response.body}");

    return connectionmodelFromJson(response.body);
  }

  // post connections

  Future<Addconnectionmodel?> AddConnectionslist(
      String customer_name,
      String groupid,
      String billing_state,
      String start_date,
      String end_date,
      BuildContext context
      // String? cont_id,
      // String? topic,
      // String? contact_type,
      // String? tariff_id,
      // String? activity_report,
      // String? notes,
      // String? deviceid,

      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken').toString();
    String userid = prefs.getInt('userid').toString();
    print(start_date);
    String t_url = prefs.getString('tenantUrl').toString();
    // String t_subdomain = prefs.getString('tenantsubdomain').toString();
    final String api_getconnections = t_url + getconnections;
    print("URL =-=-=- $api_getconnections");
    print("userid =-=-=- $userid");
    final response = await http.post(Uri.parse(api_getconnections), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer $userToken"
    }, body: {
      "customer_name": customer_name,
      "groupid": groupid,
      "userid": userid,
      "billing_state": billing_state,
      "start_date": start_date,
      "end_date": end_date,
      // "cont_id": cont_id,
      // "topic": topic,
      // "contact_type": contact_type,
      // "tariff_id": tariff_id,
      // "activity_report": activity_report,
      // "notes": notes,
      // "deviceid": deviceid,
    });
    print("respose get customer device list : ${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body.toString());
    Addconnectionmodel addconnectionmodel = Addconnectionmodel.fromJson(map);
    print("respose get customer device list : ${response.body}");

    if (response.statusCode == 200) {
      if (map["status"] == "Success") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(
                  activitytap: true,
                )));
        Fluttertoast.showToast(msg: addconnectionmodel.message);
        return addconnectionmodelFromJson(response.body);
      } else {
        Fluttertoast.showToast(msg: addconnectionmodel.message);
        return null;
      }
    } else {
      Fluttertoast.showToast(msg: addconnectionmodel.message);
      return null;
    }
  }

  // put connections

  Future<Addconnectionmodel?> EditConnectionslist(
      String connectionid,
      String customer_name,
      String groupid,
      String billing_state,
      String start_date,
      String end_date,
      // String? cont_id,
      String? topic,
      String? contact_type,
      // String? tariff_id,
      // String? activity_report,
      String? notes,
      // String? deviceid,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken').toString();
    String userid = prefs.getInt('userid').toString();
    String t_url = prefs.getString('tenantUrl').toString();
    // String t_subdomain = prefs.getString('tenantsubdomain').toString();
    final String api_getconnections =
        t_url + getconnections + '/' + connectionid;
    print("URL =-=-=- $api_getconnections");
    print("userid =-=-=- $userid");
    final response = await http.post(Uri.parse(api_getconnections), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer $userToken"
    }, body: {
      "customer_name": customer_name,
      "groupid": groupid,
      "userid": userid,
      "billing_state": billing_state,
      "start_date": start_date,
      "end_date": end_date,
      // "cont_id": cont_id,
      "topic": topic,
      "contact_type": contact_type,
      // "tariff_id": tariff_id,
      // "activity_report": activity_report,
      "notes": notes,
      // "deviceid": deviceid,
    });
    Map<String, dynamic> map = jsonDecode(response.body.toString());
    Addconnectionmodel addconnectionmodel = Addconnectionmodel.fromJson(map);
    print("respose get customer device list : ${response.body}");

    if (response.statusCode == 200) {
      if (map["status"] == "Success") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(
                  activitytap: true,
                )));
        Fluttertoast.showToast(msg: addconnectionmodel.message);
        return addconnectionmodelFromJson(response.body);
      } else {
        Fluttertoast.showToast(msg: addconnectionmodel.message);
        return null;
      }
    } else {
      Fluttertoast.showToast(msg: addconnectionmodel.message);
      return null;
    }
  }

  // Logout

  Future<UserModel> revokeToken(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken').toString();
    String t_url = prefs.getString('tenantUrl').toString();
    // String t_subdomain = prefs.getString('tenantsubdomain').toString();
    final String api_get_token = t_url + gettoken;
    print("URL =-=-=- $api_get_token");
    final response = await http.delete(
      Uri.parse(api_get_token),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Bearer $userToken"
      },
    );

    print("respose revoke token : ${response.body}");
    if (response.statusCode == 201) {
      Map<String, dynamic> map = jsonDecode(response.body.toString());
      UserModel userModel = UserModel.fromJson(map);
      prefs.clear();
      print("current userToken is ${prefs.getString('userToken').toString()}");
      print("user is logged in ${prefs.getBool('isLogin').toString()}");
      print("User Token====== ${userModel.data.token}");

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SignInScreen()));

      Fluttertoast.showToast(msg: userModel.message);
    } else {
      prefs.clear();
      print("current userToken is ${prefs.getString('userToken').toString()}");
      print("user is logged in ${prefs.getBool('isLogin').toString()}");
      Fluttertoast.showToast(msg: "You have successfully logged out!");

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SignInScreen()));
    }
    return userModelFromJson(response.body);
  }
}
