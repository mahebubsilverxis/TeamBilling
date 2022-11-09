import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/model.dart';

class DB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "MYDb.db"),
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE AddActivity(

          addactivityid INTEGER PRIMARY KEY AUTOINCREMENT,    
          customer_name TEXT NULL,
          groupid TEXT NULL,
          userid TEXT NULL,
          billing_state TEXT NULL,
          start_date TEXT NULL,
          end_date TEXT NULL

          )
          """);

        await database.execute("""
          CREATE TABLE GetCustomer(
          customerid INTEGER PRIMARY KEY AUTOINCREMENT,
            id INTEGER NULL,
            groupid TEXT NULL,
            customer_name TEXT NULL,
            email TEXT NULL,
            address TEXT NULL,
            phone TEXT NULL,
            city TEXT NULL,
            country TEXT NULL,
            post_code TEXT NULL,
            comment TEXT NULL,
            website TEXT NULL,
            billing_addition TEXT NULL,
            billing_address TEXT NULL,
            billing_zip_code TEXT NULL,
            billing_city TEXT NULL,
            billing_country TEXT NULL,
            billing_iban TEXT NULL,
            billing_bic TEXT NULL,
            billing_email TEXT NULL,
            billing_payment TEXT NULL,
            billing_sepa INTEGER NULL,
            customer_permissions TEXT NULL,
            deleted_at DATETIME NULL,
            created_at DATETIME NULL,
            updated_at DATETIME NULL,
            planned_operating_time TEXT NULL,
            curr_month_actual_operate_time TEXT NULL,
            last_month_actual_operate_time TEXT NULL,
            last_quarter_actual_operate_time TEXT NULL,
            short_name TEXT NULL        
          )
          """);

        // await database.execute("""
        //   CREATE TABLE GetConnection(
        //
        //   connectionid INTEGER PRIMARY KEY AUTOINCREMENT,
        //     id TEXT NULL,
        //     groupid TEXT NULL,
        //     groupname TEXT NULL,
        //     userid TEXT NULL,
        //     username TEXT NULL,
        //     device_id TEXT NULL,
        //     devicename TEXT NULL,
        //     support_session_type INTEGER NULL,
        //     start_date DATETIME NULL,
        //     end_date DATETIME NULL,
        //     fee INTEGER NULL,
        //     currency TEXT NULL,
        //     billing_state TEXT NULL,
        //     activity_report TEXT NULL,
        //     notes TEXT NULL,
        //     contact_id TEXT NULL,
        //     cont_id TEXT NULL,
        //     overlaps_color TEXT NULL,
        //     overlaps_user INTEGER NULL,
        //     booked INTEGER NULL,
        //     deleted_at DATETIME NULL,
        //     created_at DATETIME NULL,
        //     updated_at DATETIME NULL,
        //     tariff_id INTEGER NULL,
        //     price TEXT NULL,
        //     topic TEXT NULL,
        //     isTV INTEGER NULL,
        //     contact_type TEXT NULL,
        //     is_tariff_overlap_confirmed INTEGER NULL,
        //     overlaps_tariff INTEGER NULL,
        //     printed INTEGER NULL
        //
        //   )
        //   """);
        await database.execute("""
          CREATE TABLE AddCustomerdevice(
       
          custdeviceid INTEGER PRIMARY KEY AUTOINCREMENT,
            id TEXT NULL,
            alias TEXT NULL,
            description TEXT NULL,
            groupid TEXT NULL,
            online_state TEXT NULL,
            created_at DATETIME NULL,
            updated_at DATETIME NULL
           
          )
          """);
      },
      version: 1,
    );
  }

  // Future<bool> insertActivity(Data1 dataModel) async {
  //   final Database db = await initDB();
  //   print("data model get customer sf s ");
  //   db.insert("AddActivity", dataModel.toJson());
  //   return true;
  // }

  // Future<List<Data>> AddCustomer(List<Data> dataModel) async {
  //   final Database db = await initDB();
  //   print("data model get customer ${dataModel}");
  //   db.insert("GetCustomer",);
  //   return dataModel;
  // }
  Future<Addactivity> addactivity(Addactivity todo) async {
    final Database db = await initDB();
    print("data model get AddActivity ${todo}");
    await db.insert("AddActivity", todo.toJson());
    getactivity();
    return todo;
  }

  Future<List<Addactivity>> getactivity() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> datas = await db.query(" ");
    print('fd AddActivity $datas');
    return datas.map((e) => Addactivity.fromJson(e)).toList();
  }

  Future<void> deleteactivity() async {
    final Database db = await initDB();
    print('AddActivity AddActivity :)');
    await db.delete("AddActivity");
  }

  Future<void> updateactivity(Addactivity dataModel) async {
    final Database db = await initDB();
    await db.update(
      "AddActivity",
      dataModel.toJson(),
      where: "addactivityid=?",
    );
  }

  Future<Datum> insertCustomerlist(Datum todo) async {
    final Database db = await initDB();
    print("data model get customer ${todo.id}");
    print("data model get customer ${todo}");
    await db.insert("GetCustomer", todo.toJson());
    getCustomerlist();
    return todo;
  }

  Future<List<Datum>> getCustomerlist() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> datas = await db.query("GetCustomer");
    print('fd ew $datas');
    return datas.map((e) => Datum.fromJson(e)).toList();
  }

  Future<void> deleteCustomerlist() async {
    final Database db = await initDB();
    print('Internet GeGetCustomerGetCustomer :)');
    await db.delete("GetCustomer");
  }

  Future<ConnectionDatum> insertConnections(ConnectionDatum todo) async {
    final Database db = await initDB();
    print("data model get Connection ${todo.id}");
    print("data model get Connection ${todo}");
    await db.insert("GetConnection", todo.toJson());
    getConnections();
    return todo;
  }

  Future<List<ConnectionDatum>> getConnections() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> datas = await db.query("GetConnection");
    print('fd Connection ${datas}');
    return datas.map((e) => ConnectionDatum.fromJson(e)).toList();
  }

  Future<void> deleteConnectionsData() async {
    final Database db = await initDB();
    print('Internet GetConnre ection dlt :)');
    await db.delete("GetConnection");
  }

  Future<Device> insertcustomerdevicelist(Device todo) async {
    final Database db = await initDB();

    print("data model get customerdevice ${todo.id}");
    print("data model get customer device${todo}");

    await db.insert("AddCustomerdevice", todo.toJson());

    getinsertcustomerdevicelist();

    return todo;
  }

  Future<List<Device>> getinsertcustomerdevicelist() async {
    final Database db = await initDB();

    final List<Map<String, Object?>> datas =
        await db.query("AddCustomerdevice");

    return datas.map((e) {
      print('data e is $e');

      return Device.fromJson(e);
    }).toList();
  }

  Future<void> deletecustomerdevicelist() async {
    final Database db = await initDB();
    print('Internet GetConnre ection dlt :)');
    await db.delete("AddCustomerdevice");
  }

  // Future<List<Data>> getData() async {
  //   final Database db = await initDB();
  //   final List<Map<String, Object?>> datas = await db.query("AddActivity");
  //   return datas.map((e) => Data.fromJson(e)).toList();
  // }

}
