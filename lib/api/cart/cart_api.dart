import 'package:ecommerce_shop/api/account/account_api.dart';
import 'package:ecommerce_shop/api/cart/cartitem.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartApi extends ChangeNotifier {
  Account? acctemp;
  String? kq;
  List<Cartitem> lstcart = [];
  int countCart = 0;
  Future<dynamic> addCart(
      Function(String) onError, int id, int quantity, int accountid) async {
    String endpoint = 'http://192.168.1.6:8000/api/cart/add-cart';
    http.Response response = await http.post(Uri.parse(endpoint),
        body: ({
          'quantity': quantity.toString(),
          'product_id': id.toString(),
          'account_id': accountid.toString()
        }));
    if (response.statusCode == 200) {
      try {
        // ignore: non_constant_identifier_names
        dynamic JsonRaw = json.decode(response.body);
        dynamic result = JsonRaw['results'];
        dynamic result2 = JsonRaw['count'];
        kq = result;
        countCart = result2;
        notifyListeners();
      } catch (e) {
        print('status {$e}');
      }
    } else {
      print('faild add cart');
    }
    return kq;
  }

  Future<void> getCart(Function(String) onError, int accid) async {
    List<Cartitem> carts = [];
    String endpoint = 'http://192.168.1.6:8000/api/cart/$accid';
    http.Response response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      try {
        // ignore: non_constant_identifier_names
        dynamic JsonRaw = json.decode(response.body);
        dynamic result = JsonRaw['results'];
        result.forEach((c) {
          carts.add(Cartitem.fromJson(c));
        });
      } catch (e) {
        print('status {$e}');
      }
    } else {
      print('faild add cart');
    }
    lstcart = carts;
    countCart = lstcart.length;
    notifyListeners();
  }

  saveAcc(Account acc) {
    acctemp = acc;
    notifyListeners();
    print(acctemp!.fullname.toString());
  }
}
