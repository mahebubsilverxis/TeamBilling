import 'package:meta/meta.dart';
import 'dart:convert';

// get an revoke token

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.token,
    required this.id,
    required this.user_id,
    required this.groupid,
    required this.customerName,
    required this.email,
    required this.address,
    required this.phone,
    required this.city,
    required this.country,
    required this.postCode,
    required this.comment,
    required this.website,
    required this.billingAddition,
    required this.billingAddress,
    required this.billingZipCode,
    required this.billingCity,
    required this.billingCountry,
    required this.billingIban,
    required this.billingBic,
    required this.billingEmail,
    required this.billingPayment,
    required this.billingSepa,
    required this.customerPermissions,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.plannedOperatingTime,
    required this.currMonthActualOperateTime,
    required this.lastMonthActualOperateTime,
    required this.lastQuarterActualOperateTime,
    required this.shortName,
    required this.groupname,
    required this.userid,
    required this.username,
    required this.deviceId,
    required this.devicename,
    required this.supportSessionType,
    required this.startDate,
    required this.endDate,
    required this.fee,
    required this.currency,
    required this.billingState,
    required this.activityReport,
    required this.notes,
    required this.contactId,
    required this.contId,
    required this.overlapsColor,
    required this.overlapsUser,
    required this.booked,
    required this.tariffId,
    required this.price,
    required this.topic,
    required this.isTv,
    required this.contactType,
    required this.isTariffOverlapConfirmed,
    required this.overlapsTariff,
    required this.printed,
    required this.customer,
    required this.devices,
    required this.alias,
    required this.description,
    required this.onlineState,
    required this.groupList,
  });

  String token;
  var id;
  int user_id;
  String groupid;
  String customerName;
  dynamic email;
  dynamic address;
  dynamic phone;
  dynamic city;
  dynamic country;
  dynamic postCode;
  dynamic comment;
  dynamic website;
  dynamic billingAddition;
  dynamic billingAddress;
  dynamic billingZipCode;
  dynamic billingCity;
  dynamic billingCountry;
  dynamic billingIban;
  dynamic billingBic;
  dynamic billingEmail;
  dynamic billingPayment;
  int billingSepa;
  String customerPermissions;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String plannedOperatingTime;
  String currMonthActualOperateTime;
  String lastMonthActualOperateTime;
  String lastQuarterActualOperateTime;
  String shortName;
  String groupname;
  String userid;
  String username;
  String deviceId;
  String devicename;
  int supportSessionType;
  DateTime startDate;
  DateTime endDate;
  int fee;
  String currency;
  String billingState;
  String activityReport;
  String notes;
  String contactId;
  int contId;
  String overlapsColor;
  int overlapsUser;
  int booked;
  int tariffId;
  String price;
  String topic;
  int isTv;
  String contactType;
  int isTariffOverlapConfirmed;
  int overlapsTariff;
  int printed;
  String customer;
  List<Data> devices;
  String alias;
  dynamic description;
  String onlineState;
  List<String> groupList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"] == null ? '' : json["token"],
        id: json["id"] == null ? '' : json["id"],
        user_id: json["user_id"] == null ? '' : json["user_id"],
        groupid: json["groupid"],
        customerName: json["customer_name"],
        email: json["email"],
        address: json["address"],
        phone: json["phone"],
        city: json["city"],
        country: json["country"],
        postCode: json["post_code"],
        comment: json["comment"],
        website: json["website"],
        billingAddition: json["billing_addition"],
        billingAddress: json["billing_address"],
        billingZipCode: json["billing_zip_code"],
        billingCity: json["billing_city"],
        billingCountry: json["billing_country"],
        billingIban: json["billing_iban"],
        billingBic: json["billing_bic"],
        billingEmail: json["billing_email"],
        billingPayment: json["billing_payment"],
        billingSepa: json["billing_sepa"],
        customerPermissions: json["customer_permissions"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        plannedOperatingTime: json["planned_operating_time"] == null
            ? null
            : json["planned_operating_time"],
        currMonthActualOperateTime:
            json["curr_month_actual_operate_time"] == null
                ? null
                : json["curr_month_actual_operate_time"],
        lastMonthActualOperateTime:
            json["last_month_actual_operate_time"] == null
                ? null
                : json["last_month_actual_operate_time"],
        lastQuarterActualOperateTime:
            json["last_quarter_actual_operate_time"] == null
                ? null
                : json["last_quarter_actual_operate_time"],
        shortName: json["short_name"],
        groupname: json["groupname"],
        userid: json["userid"],
        username: json["username"] == null ? null : json["username"],
        deviceId: json["device_id"] == null ? null : json["device_id"],
        devicename: json["devicename"] == null ? null : json["devicename"],
        supportSessionType: json["support_session_type"],
        startDate: json["start_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["end_date"]),
        fee: json["fee"] == null ? null : json["fee"],
        currency: json["currency"],
        billingState: json["billing_state"],
        activityReport:
            json["activity_report"] == null ? null : json["activity_report"],
        notes: json["notes"] == null ? null : json["notes"],
        contactId: json["contact_id"] == null ? null : json["contact_id"],
        contId: json["cont_id"] == null ? null : json["cont_id"],
        overlapsColor:
            json["overlaps_color"] == null ? null : json["overlaps_color"],
        overlapsUser: json["overlaps_user"],
        booked: json["booked"],
        tariffId: json["tariff_id"] == null ? null : json["tariff_id"],
        price: json["price"],
        topic: json["topic"] == null ? null : json["topic"],
        isTv: json["isTV"],
        contactType: json["contact_type"] == null ? null : json["contact_type"],
        isTariffOverlapConfirmed: json["is_tariff_overlap_confirmed"],
        overlapsTariff: json["overlaps_tariff"],
        printed: json["printed"],
        customer: json["customer"],
        devices: json["devices"] == null
            ? List.empty()
            : List<Data>.from(json["devices"].map((x) => Data.fromJson(x))),
        alias: json["alias"] == null ? null : json["alias"],
        description: json["description"] == null ? null : json["description"],
        onlineState: json["online_state"] == null ? null : json["online_state"],
        groupList: json["group_list"] == null
            ? List.empty()
            : List<String>.from(json["group_list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        if (token != null) "token": token,
        if (id != null) "id": id,
        if (user_id != null) "user_id": user_id,
        if (groupid != null) "groupid": groupid,
        if (customerName != null) "customer_name": customerName,
        if (email != null) "email": email,
        if (address != null) "address": address,
        if (phone != null) "phone": phone,
        if (city != null) "city": city,
        if (country != null) "country": country,
        if (postCode != null) "post_code": postCode,
        if (comment != null) "comment": comment,
        if (website != null) "website": website,
        if (billingAddition != null) "billing_addition": billingAddition,
        if (billingAddress != null) "billing_address": billingAddress,
        if (billingZipCode != null) "billing_zip_code": billingZipCode,
        if (billingCity != null) "billing_city": billingCity,
        if (billingCountry != null) "billing_country": billingCountry,
        if (billingIban != null) "billing_iban": billingIban,
        if (billingBic != null) "billing_bic": billingBic,
        if (billingEmail != null) "billing_email": billingEmail,
        if (billingPayment != null) "billing_payment": billingPayment,
        if (billingSepa != null) "billing_sepa": billingSepa,
        if (customerPermissions != null)
          "customer_permissions": customerPermissions,
        if (deletedAt != null) "deleted_at": deletedAt,
        if (createdAt != null) "created_at": createdAt.toIso8601String(),
        if (updatedAt != null) "updated_at": updatedAt.toIso8601String(),
        if (plannedOperatingTime != null)
          "planned_operating_time":
              plannedOperatingTime == null ? null : plannedOperatingTime,
        if (currMonthActualOperateTime != null)
          "curr_month_actual_operate_time": currMonthActualOperateTime == null
              ? null
              : currMonthActualOperateTime,
        if (lastMonthActualOperateTime != null)
          "last_month_actual_operate_time": lastMonthActualOperateTime == null
              ? null
              : lastMonthActualOperateTime,
        if (lastMonthActualOperateTime != null)
          "last_quarter_actual_operate_time":
              lastQuarterActualOperateTime == null
                  ? null
                  : lastQuarterActualOperateTime,
        if (shortName != null) "short_name": shortName,
        if (groupname != null) "groupname": groupname,
        if (userid != null) "userid": userid,
        if (username != null) "username": username == null ? null : username,
        if (deviceId != null) "device_id": deviceId == null ? null : deviceId,
        if (devicename != null)
          "devicename": devicename == null ? null : devicename,
        if (supportSessionType != null)
          "support_session_type": supportSessionType,
        if (startDate != null) "start_date": startDate.toIso8601String(),
        if (endDate != null) "end_date": endDate.toIso8601String(),
        if (fee != null) "fee": fee == null ? null : fee,
        if (currency != null) "currency": currency,
        if (billingState != null) "billing_state": billingState,
        if (activityReport != null)
          "activity_report": activityReport == null ? null : activityReport,
        if (notes != null) "notes": notes == null ? null : notes,
        if (contactId != null)
          "contact_id": contactId == null ? null : contactId,
        if (contId != null) "cont_id": contId == null ? null : contId,
        if (overlapsColor != null)
          "overlaps_color": overlapsColor == null ? null : overlapsColor,
        if (overlapsUser != null) "overlaps_user": overlapsUser,
        if (booked != null) "booked": booked,
        if (tariffId != null) "tariff_id": tariffId == null ? null : tariffId,
        if (price != null) "price": price,
        if (topic != null) "topic": topic == null ? null : topic,
        if (isTv != null) "isTV": isTv,
        if (contactType != null)
          "contact_type": contactType == null ? null : contactType,
        if (isTariffOverlapConfirmed != null)
          "is_tariff_overlap_confirmed": isTariffOverlapConfirmed,
        if (overlapsTariff != null) "overlaps_tariff": overlapsTariff,
        if (printed != null) "printed": printed,
        if (customer != null) "customer": customer,
        if (devices != null)
          "devices": List<dynamic>.from(devices.map((x) => x.toJson())),
        if (alias != null) "alias": alias,
        if (description != null) "description": description,
        if (onlineState != null) "online_state": onlineState,
        if (groupList != null)
          "group_list": List<dynamic>.from(groupList.map((x) => x)),
      };

// Map<String, dynamic> toMap() =>  {
//   if (token != null) "token": token,
//   if (id != null) "id": id,
//   if (groupid != null) "groupid": groupid,
//   if (customerName != null) "customer_name": customerName,
//   if (email != null) "email": email,
//   if (address != null) "address": address,
//   if (phone != null) "phone": phone,
//   if (city != null) "city": city,
//   if (country != null) "country": country,
//   if (postCode != null) "post_code": postCode,
//   if (comment != null) "comment": comment,
//   if (website != null) "website": website,
//   if (billingAddition != null) "billing_addition": billingAddition,
//   if (billingAddress != null) "billing_address": billingAddress,
//   if (billingZipCode != null) "billing_zip_code": billingZipCode,
//   if (billingCity != null) "billing_city": billingCity,
//   if (billingCountry != null) "billing_country": billingCountry,
//   if (billingIban != null) "billing_iban": billingIban,
//   if (billingBic != null) "billing_bic": billingBic,
//   if (billingEmail != null) "billing_email": billingEmail,
//   if (billingPayment != null) "billing_payment": billingPayment,
//   if (billingSepa != null) "billing_sepa": billingSepa,
//   if (customerPermissions !=
//       null) "customer_permissions": customerPermissions,
//   if (deletedAt != null) "deleted_at": deletedAt,
//   if (createdAt != null) "created_at": createdAt.toIso8601String(),
//   if (updatedAt != null) "updated_at": updatedAt.toIso8601String(),
//   if (plannedOperatingTime !=
//       null) "planned_operating_time": plannedOperatingTime == null
//       ? null
//       : plannedOperatingTime,
//   if (currMonthActualOperateTime !=
//       null) "curr_month_actual_operate_time": currMonthActualOperateTime ==
//       null ? null : currMonthActualOperateTime,
//   if (lastMonthActualOperateTime !=
//       null) "last_month_actual_operate_time": lastMonthActualOperateTime ==
//       null ? null : lastMonthActualOperateTime,
//   if (lastMonthActualOperateTime !=
//       null) "last_quarter_actual_operate_time": lastQuarterActualOperateTime ==
//       null ? null : lastQuarterActualOperateTime,
//   if (shortName != null) "short_name": shortName,
//   if (groupname != null) "groupname": groupname,
//   if (userid != null) "userid": userid,
//   if (username != null) "username": username == null ? null : username,
//   if (deviceId != null) "device_id": deviceId == null ? null : deviceId,
//   if (devicename != null) "devicename": devicename == null
//       ? null
//       : devicename,
//   if (supportSessionType !=
//       null) "support_session_type": supportSessionType,
//   if (startDate != null) "start_date": startDate.toIso8601String(),
//   if (endDate != null) "end_date": endDate.toIso8601String(),
//   if (fee != null) "fee": fee == null ? null : fee,
//   if (currency != null) "currency": currency,
//   if (billingState != null) "billing_state": billingState,
//   if (activityReport != null) "activity_report": activityReport == null
//       ? null
//       : activityReport,
//   if (notes != null) "notes": notes == null ? null : notes,
//   if (contactId != null) "contact_id": contactId == null
//       ? null
//       : contactId,
//   if (contId != null) "cont_id": contId == null ? null : contId,
//   if (overlapsColor != null) "overlaps_color": overlapsColor == null
//       ? null
//       : overlapsColor,
//   if (overlapsUser != null) "overlaps_user": overlapsUser,
//   if (booked != null) "booked": booked,
//   if (tariffId != null) "tariff_id": tariffId == null ? null : tariffId,
//   if (price != null) "price": price,
//   if (topic != null) "topic": topic == null ? null : topic,
//   if (isTv != null) "isTV": isTv,
//   if (contactType != null) "contact_type": contactType == null
//       ? null
//       : contactType,
//   if (isTariffOverlapConfirmed !=
//       null) "is_tariff_overlap_confirmed": isTariffOverlapConfirmed,
//   if (overlapsTariff != null) "overlaps_tariff": overlapsTariff,
//   if (printed != null) "printed": printed,
//   if (customer != null) "customer": customer,
//   if (devices != null) "devices": List<dynamic>.from(
//       devices.map((x) => x.toJson())),
//   if (alias != null) "alias": alias,
//   if (description != null) "description": description,
//   if (onlineState != null) "online_state": onlineState,
//   if (groupList != null) "group_list": List<dynamic>.from(
//       groupList.map((x) => x)),
//
// };
}

// Customer list model

CustomerModel customerModelFromJson(String str) =>
    CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  CustomerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.groupid,
    required this.customerName,
    required this.email,
    required this.address,
    required this.phone,
    required this.city,
    required this.country,
    required this.postCode,
    required this.comment,
    required this.website,
    required this.billingAddition,
    required this.billingAddress,
    required this.billingZipCode,
    required this.billingCity,
    required this.billingCountry,
    required this.billingIban,
    required this.billingBic,
    required this.billingEmail,
    required this.billingPayment,
    required this.billingSepa,
    required this.customerPermissions,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.plannedOperatingTime,
    required this.currMonthActualOperateTime,
    required this.lastMonthActualOperateTime,
    required this.lastQuarterActualOperateTime,
    required this.shortName,
  });

  int id;
  String groupid;
  String customerName;
  dynamic email;
  dynamic address;
  dynamic phone;
  dynamic city;
  dynamic country;
  dynamic postCode;
  dynamic comment;
  dynamic website;
  dynamic billingAddition;
  dynamic billingAddress;
  dynamic billingZipCode;
  dynamic billingCity;
  dynamic billingCountry;
  dynamic billingIban;
  dynamic billingBic;
  dynamic billingEmail;
  dynamic billingPayment;
  int billingSepa;
  String customerPermissions;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String plannedOperatingTime;
  String currMonthActualOperateTime;
  String lastMonthActualOperateTime;
  String lastQuarterActualOperateTime;
  String shortName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? 0 : json["id"],
        groupid: json["groupid"] == null ? '' : json["groupid"],
        customerName:
            json["customer_name"] == null ? '' : json["customer_name"],
        email: json["email"] == null ? '' : json["email"],
        address: json["address"] == null ? '' : json["address"],
        phone: json["phone"] == null ? '' : json["phone"],
        city: json["city"] == null ? '' : json["city"],
        country: json["country"] == null ? '' : json["country"],
        postCode: json["post_code"] == null ? '' : json["post_code"],
        comment: json["comment"] == null ? '' : json["comment"],
        website: json["website"] == null ? '' : json["website"],
        billingAddition:
            json["billing_addition"] == null ? '' : json["billing_addition"],
        billingAddress:
            json["billing_address"] == null ? '' : json["billing_address"],
        billingZipCode:
            json["billing_zip_code"] == null ? '' : json["billing_zip_code"],
        billingCity: json["billing_city"] == null ? '' : json["billing_city"],
        billingCountry:
            json["billing_country"] == null ? '' : json["billing_country"],
        billingIban: json["billing_iban"] == null ? '' : json["billing_iban"],
        billingBic: json["billing_bic"] == null ? '' : json["billing_bic"],
        billingEmail:
            json["billing_email"] == null ? '' : json["billing_email"],
        billingPayment:
            json["billing_payment"] == null ? '' : json["billing_payment"],
        billingSepa: json["billing_sepa"] == null ? 0 : json["billing_sepa"],
        customerPermissions: json["customer_permissions"] == null
            ? ''
            : json["customer_permissions"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        plannedOperatingTime: json["planned_operating_time"] == null
            ? ''
            : json["planned_operating_time"] == null
                ? null
                : json["planned_operating_time"],
        currMonthActualOperateTime:
            json["curr_month_actual_operate_time"] == null
                ? ''
                : json["curr_month_actual_operate_time"] == null
                    ? null
                    : json["curr_month_actual_operate_time"],
        lastMonthActualOperateTime:
            json["last_month_actual_operate_time"] == null
                ? ''
                : json["last_month_actual_operate_time"] == null
                    ? null
                    : json["last_month_actual_operate_time"],
        lastQuarterActualOperateTime:
            json["last_quarter_actual_operate_time"] == null
                ? ''
                : json["last_quarter_actual_operate_time"] == null
                    ? null
                    : json["last_quarter_actual_operate_time"],
        shortName: json["short_name"] == null ? '' : json["short_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupid": groupid,
        "customer_name": customerName,
        "email": email,
        "address": address,
        "phone": phone,
        "city": city,
        "country": country,
        "post_code": postCode,
        "comment": comment,
        "website": website,
        "billing_addition": billingAddition,
        "billing_address": billingAddress,
        "billing_zip_code": billingZipCode,
        "billing_city": billingCity,
        "billing_country": billingCountry,
        "billing_iban": billingIban,
        "billing_bic": billingBic,
        "billing_email": billingEmail,
        "billing_payment": billingPayment,
        "billing_sepa": billingSepa,
        "customer_permissions": customerPermissions,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "planned_operating_time":
            plannedOperatingTime == null ? null : plannedOperatingTime,
        "curr_month_actual_operate_time": currMonthActualOperateTime == null
            ? null
            : currMonthActualOperateTime,
        "last_month_actual_operate_time": lastMonthActualOperateTime == null
            ? null
            : lastMonthActualOperateTime,
        "last_quarter_actual_operate_time": lastQuarterActualOperateTime == null
            ? null
            : lastQuarterActualOperateTime,
        "short_name": shortName,
      };
}

// Connection list model

Connectionmodel connectionmodelFromJson(String str) =>
    Connectionmodel.fromJson(json.decode(str));

String connectionmodelToJson(Connectionmodel data) =>
    json.encode(data.toJson());

class Connectionmodel {
  Connectionmodel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<ConnectionDatum> data;

  factory Connectionmodel.fromJson(Map<String, dynamic> json) =>
      Connectionmodel(
        status: json["status"],
        message: json["message"],
        data: List<ConnectionDatum>.from(
            json["data"].map((x) => ConnectionDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ConnectionDatum {
  ConnectionDatum({
    required this.id,
    required this.groupid,
    required this.groupname,
    required this.userid,
    required this.username,
    required this.deviceId,
    required this.devicename,
    required this.supportSessionType,
    required this.startDate,
    required this.endDate,
    required this.fee,
    required this.currency,
    required this.billingState,
    required this.activityReport,
    required this.notes,
    required this.contactId,
    required this.contId,
    required this.overlapsColor,
    required this.overlapsUser,
    required this.booked,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.tariffId,
    required this.price,
    required this.topic,
    required this.isTv,
    required this.contactType,
    required this.isTariffOverlapConfirmed,
    required this.overlapsTariff,
    required this.printed,
  });

  String id;
  String groupid;
  String groupname;
  String userid;
  String username;
  String deviceId;
  String devicename;
  int supportSessionType;
  DateTime startDate;
  DateTime endDate;
  int fee;
  String currency;
  String billingState;
  String activityReport;
  String notes;
  String contactId;
  int contId;
  String overlapsColor;
  int overlapsUser;
  int booked;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int tariffId;
  String price;
  String topic;
  int isTv;
  String contactType;
  int isTariffOverlapConfirmed;
  int overlapsTariff;
  int printed;

  factory ConnectionDatum.fromJson(Map<String, dynamic> json) =>
      ConnectionDatum(
        id: json["id"] == null ? null : json["id"],
        groupid: json["groupid"] == null ? null : json["groupid"],
        groupname: json["groupname"] == null ? null : json["groupname"],
        userid: json["userid"] == null ? null : json["userid"],
        username: json["username"] == null ? null : json["username"],
        deviceId: json["device_id"] == null ? null : json["device_id"],
        devicename: json["devicename"] == null ? null : json["devicename"],
        supportSessionType: json["support_session_type"] == null
            ? null
            : json["support_session_type"],
        startDate: json["start_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["end_date"]),
        fee: json["fee"] == null ? null : json["fee"],
        currency: json["currency"] == null ? null : json["currency"],
        billingState:
            json["billing_state"] == null ? null : json["billing_state"],
        activityReport:
            json["activity_report"] == null ? null : json["activity_report"],
        notes: json["notes"] == null ? null : json["notes"],
        contactId: json["contact_id"] == null ? null : json["contact_id"],
        contId: json["cont_id"] == null ? null : json["cont_id"],
        overlapsColor:
            json["overlaps_color"] == null ? null : json["overlaps_color"],
        overlapsUser:
            json["overlaps_user"] == null ? null : json["overlaps_user"],
        booked: json["booked"] == null ? null : json["booked"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        tariffId: json["tariff_id"] == null ? null : json["tariff_id"],
        price: json["price"] == null ? null : json["price"],
        topic: json["topic"] == null ? null : json["topic"],
        isTv: json["isTV"] == null ? null : json["isTV"],
        contactType: json["contact_type"] == null ? null : json["contact_type"],
        isTariffOverlapConfirmed: json["is_tariff_overlap_confirmed"] == null
            ? null
            : json["is_tariff_overlap_confirmed"],
        overlapsTariff:
            json["overlaps_tariff"] == null ? null : json["overlaps_tariff"],
        printed: json["printed"] == null ? null : json["printed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupid": groupid,
        "groupname": groupname,
        "userid": userid,
        "username": username == null ? null : username,
        "device_id": deviceId == null ? null : deviceId,
        "devicename": devicename == null ? null : devicename,
        "support_session_type": supportSessionType,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "fee": fee == null ? null : fee,
        "currency": currency,
        "billing_state": billingState,
        "activity_report": activityReport == null ? null : activityReport,
        "notes": notes == null ? null : notes,
        "contact_id": contactId == null ? null : contactId,
        "cont_id": contId == null ? null : contId,
        "overlaps_color": overlapsColor == null ? null : overlapsColor,
        "overlaps_user": overlapsUser,
        "booked": booked,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "tariff_id": tariffId == null ? null : tariffId,
        "price": price,
        "topic": topic == null ? null : topic,
        "isTV": isTv,
        "contact_type": contactType == null ? null : contactType,
        "is_tariff_overlap_confirmed": isTariffOverlapConfirmed,
        "overlaps_tariff": overlapsTariff,
        "printed": printed,
      };
}

//get customer all device

Devicelistmodel devicelistmodelFromJson(String str) =>
    Devicelistmodel.fromJson(json.decode(str));

String devicelistmodelToJson(Devicelistmodel data) =>
    json.encode(data.toJson());

class Devicelistmodel {
  Devicelistmodel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  DevicelistData data;

  factory Devicelistmodel.fromJson(Map<String, dynamic> json) =>
      Devicelistmodel(
        status: json["status"],
        message: json["message"],
        data: DevicelistData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class DevicelistData {
  DevicelistData({
    required this.groupList,
  });

  List<String> groupList;

  factory DevicelistData.fromJson(Map<String, dynamic> json) => DevicelistData(
        groupList: List<String>.from(json["group_list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "group_list": List<dynamic>.from(groupList.map((x) => x)),
      };
}

//user device list

Userdevicelistmodel userdevicelistmodelFromJson(String str) =>
    Userdevicelistmodel.fromJson(json.decode(str));

String userdevicelistmodelToJson(Userdevicelistmodel data) =>
    json.encode(data.toJson());

class Userdevicelistmodel {
  Userdevicelistmodel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  UserdevicelistData data;

  factory Userdevicelistmodel.fromJson(Map<String, dynamic> json) =>
      Userdevicelistmodel(
        status: json["status"],
        message: json["message"],
        data: UserdevicelistData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class UserdevicelistData {
  UserdevicelistData({
    required this.customer,
    required this.devices,
  });

  String customer;
  List<Device> devices;

  factory UserdevicelistData.fromJson(Map<String, dynamic> json) =>
      UserdevicelistData(
        customer: json["customer"],
        devices:
            List<Device>.from(json["devices"].map((x) => Device.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customer": customer,
        "devices": List<dynamic>.from(devices.map((x) => x.toJson())),
      };
}

class Device {
  Device({
    required this.id,
    required this.alias,
    required this.description,
    required this.groupid,
    required this.onlineState,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String alias;
  dynamic description;
  String groupid;
  String onlineState;
  DateTime createdAt;
  DateTime updatedAt;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        groupid: json["groupid"],
        onlineState: json["online_state"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "groupid": groupid,
        "online_state": onlineState,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

//post connection add activity

Addconnectionmodel addconnectionmodelFromJson(String str) =>
    Addconnectionmodel.fromJson(json.decode(str));

String addconnectionmodelToJson(Addconnectionmodel data) =>
    json.encode(data.toJson());

class Addconnectionmodel {
  Addconnectionmodel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  AddconnectionData data;

  factory Addconnectionmodel.fromJson(Map<String, dynamic> json) =>
      Addconnectionmodel(
        status: json["status"],
        message: json["message"],
        data: AddconnectionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class AddconnectionData {
  AddconnectionData({
    required this.id,
    required this.groupid,
    required this.groupname,
    required this.userid,
    required this.contId,
    required this.username,
    required this.topic,
    required this.contactType,
    required this.deviceId,
    required this.devicename,
    required this.tariffId,
    required this.supportSessionType,
    required this.billingState,
    required this.startDate,
    required this.endDate,
    required this.activityReport,
    required this.notes,
    required this.updatedAt,
    required this.createdAt,
  });

  String id;
  String groupid;
  String groupname;
  String userid;
  dynamic contId;
  String username;
  dynamic topic;
  dynamic contactType;
  dynamic deviceId;
  dynamic devicename;
  dynamic tariffId;
  int supportSessionType;
  String billingState;
  DateTime startDate;
  DateTime endDate;
  dynamic activityReport;
  dynamic notes;
  DateTime updatedAt;
  DateTime createdAt;

  factory AddconnectionData.fromJson(Map<String, dynamic> json) =>
      AddconnectionData(
        id: json["id"] == null ? '' : json["id"],
        groupid: json["groupid"] == null ? '' : json["groupid"],
        groupname: json["groupname"] == null ? '' : json["groupname"],
        userid: json["userid"] == null ? '' : json["userid"],
        contId: json["cont_id"] == null ? '' : json["cont_id"],
        username: json["username"] == null ? '' : json["username"],
        topic: json["topic"] == null ? '' : json["topic"],
        contactType: json["contact_type"] == null ? '' : json["contact_type"],
        deviceId: json["device_id"] == null ? '' : json["device_id"],
        devicename: json["devicename"] == null ? '' : json["devicename"],
        tariffId: json["tariff_id"] == null ? '' : json["tariff_id"],
        supportSessionType: json["support_session_type"] == null
            ? 0
            : json["support_session_type"],
        billingState:
            json["billing_state"] == null ? '' : json["billing_state"],
        startDate: json["start_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["end_date"]),
        activityReport:
            json["activity_report"] == null ? '' : json["activity_report"],
        notes: json["notes"] == null ? '' : json["notes"],
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupid": groupid,
        "groupname": groupname,
        "userid": userid,
        "cont_id": contId,
        "username": username,
        "topic": topic,
        "contact_type": contactType,
        "device_id": deviceId,
        "devicename": devicename,
        "tariff_id": tariffId,
        "support_session_type": supportSessionType,
        "billing_state": billingState,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "activity_report": activityReport,
        "notes": notes,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
      };
}

// Edit connections

Editconnectionmodel editconnectionmodelFromJson(String str) =>
    Editconnectionmodel.fromJson(json.decode(str));

String editconnectionmodelToJson(Editconnectionmodel data) =>
    json.encode(data.toJson());

class Editconnectionmodel {
  Editconnectionmodel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  EditconnectionData data;

  factory Editconnectionmodel.fromJson(Map<String, dynamic> json) =>
      Editconnectionmodel(
        status: json["status"],
        message: json["message"],
        data: EditconnectionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class EditconnectionData {
  EditconnectionData({
    required this.id,
    required this.groupid,
    required this.groupname,
    required this.userid,
    required this.username,
    required this.deviceId,
    required this.devicename,
    required this.supportSessionType,
    required this.startDate,
    required this.endDate,
    required this.fee,
    required this.currency,
    required this.billingState,
    required this.activityReport,
    required this.notes,
    required this.contactId,
    required this.contId,
    required this.overlapsColor,
    required this.overlapsUser,
    required this.booked,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.tariffId,
    required this.price,
    required this.topic,
    required this.isTv,
    required this.contactType,
    required this.isTariffOverlapConfirmed,
    required this.overlapsTariff,
    required this.printed,
  });

  String id;
  String groupid;
  String groupname;
  String userid;
  String username;
  String deviceId;
  String devicename;
  int supportSessionType;
  DateTime startDate;
  DateTime endDate;
  int fee;
  String currency;
  String billingState;
  dynamic activityReport;
  String notes;
  String contactId;
  dynamic contId;
  dynamic overlapsColor;
  int overlapsUser;
  int booked;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int tariffId;
  String price;
  dynamic topic;
  int isTv;
  dynamic contactType;
  int isTariffOverlapConfirmed;
  int overlapsTariff;
  int printed;

  factory EditconnectionData.fromJson(Map<String, dynamic> json) =>
      EditconnectionData(
        id: json["id"],
        groupid: json["groupid"],
        groupname: json["groupname"],
        userid: json["userid"],
        username: json["username"],
        deviceId: json["device_id"],
        devicename: json["devicename"],
        supportSessionType: json["support_session_type"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        fee: json["fee"],
        currency: json["currency"],
        billingState: json["billing_state"],
        activityReport: json["activity_report"],
        notes: json["notes"],
        contactId: json["contact_id"],
        contId: json["cont_id"],
        overlapsColor: json["overlaps_color"],
        overlapsUser: json["overlaps_user"],
        booked: json["booked"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        tariffId: json["tariff_id"],
        price: json["price"],
        topic: json["topic"],
        isTv: json["isTV"],
        contactType: json["contact_type"],
        isTariffOverlapConfirmed: json["is_tariff_overlap_confirmed"],
        overlapsTariff: json["overlaps_tariff"],
        printed: json["printed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupid": groupid,
        "groupname": groupname,
        "userid": userid,
        "username": username,
        "device_id": deviceId,
        "devicename": devicename,
        "support_session_type": supportSessionType,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "fee": fee,
        "currency": currency,
        "billing_state": billingState,
        "activity_report": activityReport,
        "notes": notes,
        "contact_id": contactId,
        "cont_id": contId,
        "overlaps_color": overlapsColor,
        "overlaps_user": overlapsUser,
        "booked": booked,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "tariff_id": tariffId,
        "price": price,
        "topic": topic,
        "isTV": isTv,
        "contact_type": contactType,
        "is_tariff_overlap_confirmed": isTariffOverlapConfirmed,
        "overlaps_tariff": overlapsTariff,
        "printed": printed,
      };
}




class Addactivity {
  Addactivity({

    required this.customer_name,
    required this.groupid,
    required this.userid,
    required this.billing_state,
    required this.startDate,
    required this.endDate,
  });

  String customer_name;
  String groupid;
  String userid;
  String billing_state;
  String startDate;
  String endDate;


  factory Addactivity.fromJson(Map<String, dynamic> json) =>
      Addactivity(

        customer_name: json["customer_name"] == null ? '' : json["customer_name"],
        groupid: json["groupid"] == null ? '' : json["groupid"],
        userid: json["userid"] == null ? '' : json["userid"],
        billing_state: json["billing_state"] == null ? '' : json["billing_state"],

        startDate: json["start_date"] == null
            ? ""
            : json["start_date"],
        endDate: json["end_date"] == null
            ? ""
            : json["end_date"],
           );

  Map<String, dynamic> toJson() => {
    "customer_name": customer_name,
    "groupid": groupid,
    "userid": userid,
    "billing_state": billing_state,
    "start_date": startDate,
    "end_date": endDate,
  };
}
