import 'dart:convert';
import 'package:ecommerce_shop/api/order/comment.dart';
import 'package:ecommerce_shop/api/order/order_item_show.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OrderApi extends ChangeNotifier {
  int val = 0;
  changeVal(value) {
    val = value;
    print(val);
    notifyListeners();
  }

  Future<void> pay(
      String address, String phone, int total, int accountid) async {
    String endpoint = 'http://192.168.1.6:8000/api/cart/pay';
    http.Response response = await http.post(Uri.parse(endpoint), body: {
      'address': address,
      'phone': phone,
      'total': total.toString(),
      'status': 'chờ xử lý',
      'account_id': accountid.toString()
    });
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['results'];
      } catch (e) {
        print(e);
      }
    } else {
      print('pay faild');
    }
  }

  List<OrderItem> lstOrders = [];
  Future<void> getOrder(int accountid, String status) async {
    List<OrderItem> lstTmp = [];
    String endpoint = 'http://192.168.1.6:8000/api/cart/get-order';
    http.Response response = await http.post(Uri.parse(endpoint),
        body: {'account_id': accountid.toString(), 'status': status});
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['results'];
        data.forEach((item) {
          lstTmp.add(OrderItem.fromJson(item));
        });
        lstOrders = lstTmp;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      print('pay faild');
    }
  }

  bool? check;
  Future<void> checkComment(int accountid, int productid) async {
    String endpoint = 'http://192.168.1.6:8000/api/product/check-comment';
    http.Response response = await http.post(Uri.parse(endpoint), body: {
      'account_id': accountid.toString(),
      'product_id': productid.toString()
    });
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['check'];
        check = data;
        notifyListeners();
        // print(check);
        // print(productid);
        // print(accountid);
      } catch (e) {
        print(e);
      }
    } else {
      print('comment faild');
    }
  }

  List<Comment> lstComments = [];
  Future<void> getComment(int productid, int accountid) async {
    List<Comment> lstTmp = [];
    String endpoint = 'http://192.168.1.6:8000/api/product/comment';
    http.Response response = await http
        .post(Uri.parse(endpoint), body: {'product_id': productid.toString()});
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['results'];
        data.forEach((item) {
          lstTmp.add(Comment.fromJson(item));
        });
        lstComments = lstTmp;
        checkComment(accountid, productid);
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      print('faild get comment');
    }
  }

  Future<void> addComment(
      int accountid, int productid, int rating, String content) async {
    String endpoint = 'http://192.168.1.6:8000/api/product/add-comment';
    http.Response response = await http.post(Uri.parse(endpoint), body: {
      'account_id': accountid.toString(),
      'product_id': productid.toString(),
      'rating': rating.toString(),
      'content': content
    });
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['add'];
        getComment(productid, accountid);
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      print('faild get comment');
    }
  }
}
