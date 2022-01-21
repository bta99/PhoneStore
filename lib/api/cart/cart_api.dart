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
  int total = 0;
  bool btnAll = false;
  String pay = '';

  selectPay(String value) {
    pay = value;
    notifyListeners();
  }

  Future<dynamic> addCart(
      Function(String) onError, int id, int quantity, int accountid) async {
    String endpoint = 'http://192.168.1.6:8000/api/cart/add-cart';
    http.Response response = await http.post(Uri.parse(endpoint),
        body: ({
          'quantity': quantity.toString(),
          'product_id': id.toString(),
          'account_id': accountid.toString(),
          'status': 0.toString()
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
    notifyListeners();
    countCart = lstcart.length;
    notifyListeners();
  }

  saveAcc(Account? acc) {
    acctemp = acc;
    notifyListeners();
    // print(acctemp?.fullname.toString());
  }

  Future<void> updateStatusCart(
      Function(String) onError, int accountid, int productid) async {
    List<Cartitem> cartTmp = [];
    String endpoint = 'http://192.168.1.6:8000/api/cart/update-status-cart';
    http.Response response = await http.post(Uri.parse(endpoint),
        body: ({
          'account_id': accountid.toString(),
          'product_id': productid.toString()
        }));
    if (response.statusCode == 200) {
      try {
        // ignore: non_constant_identifier_names
        dynamic JsonRaw = json.decode(response.body);
        dynamic result = JsonRaw['results'];
        dynamic result2 = JsonRaw['lstCart'];
        result2.forEach((item) {
          cartTmp.add(Cartitem.fromJson(item));
        });
        lstcart = cartTmp;
        kq = result;
        // getCart((msg) {
        //   print(msg);
        // }, accountid);
        notifyListeners();
      } catch (e) {
        print('status {$e}');
      }
    } else {
      print('faild add cart');
    }
  }

  updateTotal(Cartitem c) {
    if (c.status == 1) {
      if (c.salesprice > 0) {
        total += c.salesprice * c.quantity;
      } else {
        total += c.price * c.quantity;
      }
    } else {
      if (c.salesprice > 0) {
        total -= c.salesprice * c.quantity;
      } else {
        total -= c.price * c.quantity;
      }
    }
    notifyListeners();
  }

  removeTotalItem(Cartitem c) {
    if (c.status == 1) {
      if (c.salesprice > 0) {
        total -= c.salesprice * c.quantity;
      } else {
        total -= c.price * c.quantity;
      }
    }
    notifyListeners();
  }

  resetTotal() {
    total = 0;
    notifyListeners();
  }

  Future<void> deleteCart(
      Function(String) onError, int accountid, int productid) async {
    List<Cartitem> cartTmp = [];
    String endpoint = 'http://192.168.1.6:8000/api/cart/delete-cart';
    http.Response response = await http.post(Uri.parse(endpoint),
        body: ({
          'account_id': accountid.toString(),
          'product_id': productid.toString()
        }));
    if (response.statusCode == 200) {
      try {
        // ignore: non_constant_identifier_names
        dynamic JsonRaw = json.decode(response.body);
        dynamic result = JsonRaw['results'];
        dynamic result2 = JsonRaw['lstCart'];
        result2.forEach((item) {
          cartTmp.add(Cartitem.fromJson(item));
        });
        lstcart = cartTmp;
        kq = result;
        // getCart((msg) {
        //   print(msg);
        // }, accountid);
        notifyListeners();
      } catch (e) {
        print('status {$e}');
      }
    } else {
      print('faild add cart');
    }
  }

  Future<void> resetAllStatusCart(
      Function(String) onError, int accountid) async {
    String endpoint = 'http://192.168.1.6:8000/api/cart/reset-all-status-cart';
    http.Response response = await http.post(Uri.parse(endpoint),
        body: ({'account_id': accountid.toString()}));
    if (response.statusCode == 200) {
      try {
        // ignore: non_constant_identifier_names
        dynamic JsonRaw = json.decode(response.body);
        dynamic result = JsonRaw['results'];
      } catch (e) {
        print('status {$e}');
      }
    } else {
      print('faild get info acc');
    }
    notifyListeners();
  }

  bool? check;
  Future<bool?> updateQuantity(int accountid, int productid, int cal) async {
    List<Cartitem> cartTmp = [];
    String endpoint = 'http://192.168.1.6:8000/api/cart/up-quantity';
    http.Response response = await http.post(Uri.parse(endpoint),
        body: ({
          'account_id': accountid.toString(),
          'product_id': productid.toString(),
          'cal': cal.toString()
        }));
    if (response.statusCode == 200) {
      try {
        // ignore: non_constant_identifier_names
        dynamic JsonRaw = json.decode(response.body);
        dynamic result = JsonRaw['success'];
        dynamic result2 = JsonRaw['lstCart'];
        result2.forEach((item) {
          cartTmp.add(Cartitem.fromJson(item));
        });
        lstcart = cartTmp;
        check = result;
        // getCart((msg) {
        //   print(msg);
        // }, accountid);
        notifyListeners();
      } catch (e) {
        print('status {$e}');
      }
    } else {
      print('faild update quantity');
    }
    notifyListeners();
    print(check);
    return check;
  }

  add(Cartitem c) {
    if (c.salesprice > 0) {
      total += c.salesprice;
      notifyListeners();
    } else {
      total += c.price;
      notifyListeners();
    }
  }

  remove(Cartitem c) {
    // print(c.quantity);
    if (c.quantity > 0 && c.status == 1) {
      if (c.salesprice > 0) {
        total -= c.salesprice;
        notifyListeners();
      } else {
        total -= c.price;
        notifyListeners();
      }
      // print('cc');
    }
  }

  Future<void> selectAll(Function(String) onError, int accountid) async {
    List<Cartitem> cartTmp = [];
    String endpoint = 'http://192.168.1.6:8000/api/cart/select-allcart';
    http.Response response = await http.post(Uri.parse(endpoint),
        body: ({
          'account_id': accountid.toString(),
          'check': btnAll.toString()
        }));
    if (response.statusCode == 200) {
      try {
        // ignore: non_constant_identifier_names
        dynamic JsonRaw = json.decode(response.body);
        dynamic result = JsonRaw['results'];
        notifyListeners();
        btnAll = !btnAll;
        if (btnAll == true) {
          total = 0;
        }
        for (int i = 0; i < lstcart.length; i++) {
          if (btnAll == false && total > 0) {
            if (lstcart[i].salesprice > 0) {
              total -= lstcart[i].salesprice * lstcart[i].quantity;
              notifyListeners();
            } else {
              total -= lstcart[i].price * lstcart[i].quantity;
              notifyListeners();
            }
          } else {
            if (lstcart[i].salesprice > 0) {
              total += lstcart[i].salesprice * lstcart[i].quantity;
              notifyListeners();
            } else {
              total += lstcart[i].price * lstcart[i].quantity;
              notifyListeners();
            }
          }
        }
        dynamic result2 = JsonRaw['lstCart'];
        result2.forEach((item) {
          cartTmp.add(Cartitem.fromJson(item));
        });
        lstcart = cartTmp;
        notifyListeners();
      } catch (e) {
        print('status {$e}');
      }
    } else {
      print('faild get info acc');
    }
    notifyListeners();
  }

  resetbtnAll() {
    btnAll = false;
    notifyListeners();
  }

  List<Cartitem> lstItemCheckout = [];
  int totalcheckout = 0;
  Future<List<Cartitem>> lstCartCheckout(
      Function(String) onError, int accountid) async {
    List<Cartitem> lstItem = [];
    String endpoint =
        'http://192.168.1.6:8000/api/cart/cart-checkout/$accountid';
    http.Response response = await http.get(
      Uri.parse(endpoint),
    );
    if (response.statusCode == 200) {
      try {
        // ignore: non_constant_identifier_names
        dynamic JsonRaw = json.decode(response.body);
        dynamic result = JsonRaw['results'];
        var price = JsonRaw['total_checkout'];
        totalcheckout = price;
        notifyListeners();
        result.forEach((item) {
          lstItem.add(Cartitem.fromJson(item));
        });
      } catch (e) {
        print('status {$e}');
      }
    } else {
      print('faild get info acc');
    }
    lstItemCheckout = lstItem;
    notifyListeners();
    return lstItem;
  }

  resetTotalcheckout() {
    totalcheckout = 0;
    notifyListeners();
  }
}
