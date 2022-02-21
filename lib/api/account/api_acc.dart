// ignore_for_file: avoid_print, unused_import
import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_shop/api/account/account_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ApiAcc extends ChangeNotifier {
  String? ck;
  Account? account;
  Future<Account?> login(
    String email,
    String password,
  ) async {
    Account? acc;
    String endpoint = 'http://192.168.1.4:8000/api/loginapi';
    http.Response response = await http.post(Uri.parse(endpoint),
        body: ({'email': email, 'password': password}));
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        dynamic data = jsonRaw['result'];
        ck = jsonRaw['sucess'];
        acc = Account.fromJson(data);
      } catch (e) {
        print('faild login');
      }
    } else {
      print('login faild');
    }
    account = acc;
    notifyListeners();
    // print(account?.fullname);
    return acc;
  }

  String? kq;
  // ignore: non_constant_identifier_names
  Future<dynamic> Register(String fullname, String email, String password,
      String phone, String address) async {
    String endpoint = 'http://192.168.1.4:8000/api/registerapi';
    http.Response response = await http.post(Uri.parse(endpoint),
        body: ({
          'fullname': fullname,
          'email': email,
          'password': password,
          'address': address,
          'phone': phone
        }));
    if (response.statusCode == 200) {
      try {
        dynamic jsonData = json.decode(response.body);
        dynamic data = jsonData['sucess'];
        kq = data;
      } catch (e) {
        print(e);
      }
    } else {
      print('tạo tài khoản không thành công!');
    }
    return kq;
  }

  Account? info;
  Future<void> getInfoAcc(Function(String) onError, int accountid) async {
    Account? acc;
    String endpoint = 'http://192.168.1.4:8000/api/account/$accountid';
    http.Response response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      try {
        // ignore: non_constant_identifier_names
        dynamic JsonRaw = json.decode(response.body);
        dynamic result = JsonRaw['account'];
        acc = Account.fromJson(result);
      } catch (e) {
        print('status {$e}');
      }
    } else {
      print('faild get info acc');
    }
    info = acc;
    notifyListeners();
  }

  PickedFile? file;
  String imagePath = '';
  String tmpfile = "";
  // XFile? tmpfile;
  // String base64image = "";

  final picker = ImagePicker();
  chooseImage() async {
    // ignore: deprecated_member_use
    file = (await picker.getImage(source: ImageSource.gallery));

    notifyListeners();
    if (file != null) {
      imagePath = file!.path;
      tmpfile = imagePath;
      notifyListeners();
    } else {
      imagePath = imagePath;
      notifyListeners();
    }
  }

  Future<void> uploadFile(File image, int id) async {
    Account? acc;
    final bytes = image.readAsBytesSync();
    // print(base64Encode(bytes));
    String endpoint = "http://192.168.1.4:8000/api/upload";
    http.Response response = await http.post(Uri.parse(endpoint),
        body: ({'cc': base64Encode(bytes), 'id': id.toString()}));
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        dynamic data = jsonRaw['account'];
        acc = Account.fromJson(data);
      } catch (e) {
        print('faild 1');
      }
      info = acc;
      notifyListeners();
    } else {
      print('faild 2');
    }
    // getInfoAcc((msg) {
    //   print(msg);
    // }, id);
    // notifyListeners();
  }

  setImage(value) {
    imagePath = value;
    notifyListeners();
  }

  Future<dynamic> updateInfo(
      int id, String name, String phone, String address) async {
    String url = "http://192.168.1.4:8000/api/account/update-info";
    http.Response response = await http.post(Uri.parse(url), body: {
      'id': id.toString(),
      'fullname': name,
      'phone': phone,
      'address': address
    });
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['success'];
        dynamic data2 = object['user'];
        info = Account.fromJson(data2);
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      print('update info faild');
    }
  }

  Future<dynamic> changePass(
      int accountid, String oldpass, String newpass) async {
    bool results = false;
    String url = "http://192.168.1.4:8000/api/account/change-password";
    http.Response response = await http.post(Uri.parse(url), body: {
      'account_id': accountid.toString(),
      'oldpass': oldpass,
      'newpass': newpass,
    });
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['success'];
        results = data;
      } catch (e) {
        print(e);
      }
    } else {
      print('update info faild');
    }
    return results;
  }

  Future<dynamic> resetPassword(String email) async {
    String url = "http://192.168.1.4:8000/api/reset-password/$email";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
      } catch (e) {
        print(e);
      }
    } else {
      print('update info faild');
    }
  }
}
