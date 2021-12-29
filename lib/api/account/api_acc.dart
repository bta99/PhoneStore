// ignore_for_file: avoid_print, unused_import

import 'dart:convert';

import 'package:ecommerce_shop/api/account/account_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiAcc extends ChangeNotifier {
  String? ck;
  Account? account;
  Future<Account?> login(
    String email,
    String password,
  ) async {
    Account? acc;
    String endpoint = 'http://192.168.1.6:8000/api/loginapi';
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
    print(account?.fullname);
    return acc;
  }

  String? kq;
  // ignore: non_constant_identifier_names
  Future<dynamic> Register(String fullname, String email, String password,
      String phone, String address) async {
    String endpoint = 'http://192.168.1.6:8000/api/registerapi';
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
}
