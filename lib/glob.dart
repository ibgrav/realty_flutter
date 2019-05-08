library muddle.glob;

import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStore = new FlutterSecureStorage();

String userData = '';
String loginEmail = '';
String loginPass = '';
String uid = '';

width(context, double per) {
  return (MediaQuery.of(context).size.width * per);
}

height(context, double per) {
  return (MediaQuery.of(context).size.height * per);
}

pushMember(context, page) {
  Navigator.of(context).push(new MaterialPageRoute(builder: (context) => page));
}

read(filename, old) async {
  print('READ');
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/' + filename + '.txt');

    var lastModified = await file.lastModified();
    var age = DateTime.now().difference(lastModified).inDays;

    if (age > old) return 'old';

    String text = await file.readAsString();
    return text;
  } catch (e) {
    print("Couldn't read file");
    return 'err';
  }
}

save(filename, data) async {
  print('SAVE');
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/' + filename + '.txt');
  final text = data;
  await file.writeAsString(text);
  return true;
}

readCredentials() async {
  Map<String, String> allValues = await secureStore.readAll();
  print(allValues);

  loginEmail = allValues['loginEmail'];
  loginPass = allValues['loginPass'];
}

saveCredentials(email, pass) async {
  Map<String, String> allValues = await secureStore.readAll();
  print(allValues);

  await secureStore.write(key: 'loginEmail', value: email);
  await secureStore.write(key: 'loginPass', value: pass);
}

userDataCloudSave(uid) async {
  final directory = await getApplicationDocumentsDirectory();
  // final file = File('${directory.path}/' + '12345678' + '.txt');

  final File file = File('${directory.path}/' + uid + '.txt');

  print(file);

  final StorageReference ref =
      FirebaseStorage.instance.ref().child('userData').child(uid + '.txt');
  final StorageUploadTask task = ref.putFile(file);

  task.events.listen((event) {
    if (event.type == StorageTaskEventType.success) {
      print('UPLOAD FINISHED');
    }
  }).onError((error) {
    print(error);
  });
}

userDataFileCheck(uid) async {
  var checkUserData = await read(uid, -1);
  if (checkUserData == 'old' || checkUserData == 'err') {
    final StorageReference ref =
        FirebaseStorage.instance.ref().child('userData').child(uid + '.txt');
    String getURL = await ref.getDownloadURL();
    print(getURL);

    String getData = await getHttp(getURL);
    if (getData != 'err') {
      userData = getData;
      bool localSave = await save(uid, getData);
      if (localSave) await userDataCloudSave(uid);
    }
  } else {
    userData = checkUserData;
  }
}

getHttp(url) async {
  print('GET - ' + url);
  try {
    Response response = await Dio().get(url);

    print('GET success');
    String data = response.data;

    return data;
  } catch (e) {
    print(e);
    return 'err';
  }
}

final Map emptyYear = {
  "0": {"val": 0, "rec": false, "note": false},
  "1": {"val": 0, "rec": false, "note": false},
  "2": {"val": 0, "rec": false, "note": false},
  "3": {"val": 0, "rec": false, "note": false},
  "4": {"val": 0, "rec": false, "note": false},
  "5": {"val": 0, "rec": false, "note": false},
  "6": {"val": 0, "rec": false, "note": false},
  "7": {"val": 0, "rec": false, "note": false},
  "8": {"val": 0, "rec": false, "note": false},
  "9": {"val": 0, "rec": false, "note": false},
  "10": {"val": 0, "rec": false, "note": false},
  "11": {"val": 0, "rec": false, "note": false}
};

String createNewData() {
  int thisYear = new DateTime.now().year;

  String data =
      '{"income":[{"name":"RE Commissions"},{"name":"Other 1"},{"name":"Other 2"}],"expenses":[{"name":"Automobile Expenses","data":[{"name":"Auto Repair"},{"name":"Insurance"},{"name":"Wash and Detail"},{"name":"Gas"},{"name":"Parking - Tolls"},{"name":"DMV and Smog"},{"name":"Auto Lease or Payment"},{"name":"Maintenance"},{"name":"Licensing (annual renewal)"}]},{"name":"Home Office Expense and Deduction","data":[{"name":"Electricity portion of total"},{"name":"Mortgage portion of total"},{"name":"Depreciation on Office Equip"}]},{"name":"Insurance Expenses","data":[{"name":"Disability"},{"name":"Life"},{"name":"Dental"},{"name":"Medical and Health"},{"name":"Vision"}]},{"name":"Office Expenses","data":[{"name":"Assistant and secretarial"},{"name":"Education and Coaching"},{"name":"Entertainment - Meals"},{"name":"Office Supplies"},{"name":"Dues and Subscriptions"},{"name":"Misc"},{"name":"Desk Rental or Office Space"},{"name":"Signs and Materials"},{"name":"MLS Dues"},{"name":"Online Expenses and Marketing"},{"name":"Phone"},{"name":"Internet Charge"},{"name":"Computer"},{"name":"Postage and Freight"},{"name":"Professional Fees"},{"name":"Gifts"},{"name":"Cell Phone"}]},{"name":"Savings Contributions","data":[{"name":"Amount to Reitrement Account"},{"name":"Amount to Savings Account"},{"name":"Amount towards Tax Payments"}]},{"name":"Travel Expenses","data":[{"name":"Meals and Entertainment"},{"name":"Misc Expenses"},{"name":"Air Fare"},{"name":"Car Rental"},{"name":"Hotel Charges"}]}]}';

  var json = jsonDecode(data);

  for (var type in json['income']) {
    type['data'] = {thisYear.toString(): emptyYear};
  }
  for (var type in json['expenses']) {
    for (var item in type['data']) {
      item['data'] = {thisYear.toString(): emptyYear};
    }
  }

  return jsonEncode(json);
}

TextStyle headStyle(int color) {
  return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      color: Color(color),
      fontSize: 30.0);
}

TextStyle subHeadStyle(String color) {
  var returnColor = 0xFF425464;
  if(color == 'light') returnColor = 0xFFEFEFEF;

  return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      color: Color(returnColor),
      fontSize: 24.0);
}

BoxDecoration boxDec(color) {
  return BoxDecoration(
    boxShadow: [
      new BoxShadow(
        color: Color(0x88000000),
        offset: new Offset(1, 1),
        blurRadius: 3,
      )
    ],
    borderRadius: BorderRadius.circular(6),
    color: Color(color),
  );
}
