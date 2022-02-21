import 'dart:convert';
import 'package:ecommerce_shop/api/order/comment.dart';
import 'package:ecommerce_shop/api/order/notification.dart';
import 'package:ecommerce_shop/api/order/order_item_show.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OrderApi extends ChangeNotifier {
  int val = 0;
  changeVal(value) {
    val = value;
    // print(val);
    notifyListeners();
  }

  Future<void> pay(
      String address, String phone, int total, int accountid) async {
    String endpoint = 'http://192.168.1.4:8000/api/cart/pay';
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
    String endpoint = 'http://192.168.1.4:8000/api/cart/get-order';
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

  // Future<void> checkComment(int accountid, int productid) async {
  //   String endpoint = 'http://192.168.1.4:8000/api/product/check-comment';
  //   http.Response response = await http.post(Uri.parse(endpoint), body: {
  //     'account_id': accountid.toString(),
  //     'product_id': productid.toString()
  //   });
  //   if (response.statusCode == 200) {
  //     try {
  //       dynamic object = json.decode(response.body);
  //       dynamic data = object['check'];
  //       check = data;
  //       notifyListeners();
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     print('comment faild');
  //   }
  // }
  // bool? check;
  // List<Comment> lstComments = [];
  // Future<void> getComment(int productid, int accountid) async {
  //   List<Comment> lstTmp = [];
  //   String endpoint = 'http://192.168.1.4:8000/api/product/comment';
  //   http.Response response = await http.post(Uri.parse(endpoint), body: {
  //     'product_id': productid.toString(),
  //     'account_id': accountid.toString()
  //   });
  //   if (response.statusCode == 200) {
  //     try {
  //       dynamic object = json.decode(response.body);
  //       dynamic data = object['results'];
  //       dynamic data2 = object['check'];
  //       data.forEach((item) {
  //         lstTmp.add(Comment.fromJson(item));
  //       });
  //       lstComments = lstTmp;
  //       check = data2;
  //       notifyListeners();
  //       // print(accountid);
  //       // print(check);
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     print('faild get comment');
  //   }
  //   // checkComment(accountid, productid);
  // }

  Future<void> cancelOrder(int orderId, int accountId) async {
    List<OrderItem> tmp = [];
    String url = "http://192.168.1.4:8000/api/cart/cancel-order";
    http.Response response = await http.post(Uri.parse(url),
        body: {'id': orderId.toString(), 'account_id': accountId.toString()});
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['results'];
        dynamic data2 = object['lstorder'];
        data2.forEach((item) {
          tmp.add(OrderItem.fromJson(item));
        });
        lstOrders = tmp;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      print('cancel order faild');
    }
  }

  List<NotificationModel> lstNotifi = [];
  Future<void> getNotifi(int accountid) async {
    List<NotificationModel> lstTmp = [];
    String endpoint = 'http://192.168.1.4:8000/api/get-notification';
    http.Response response = await http
        .post(Uri.parse(endpoint), body: {'account_id': accountid.toString()});
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['lstNotification'];
        data.forEach((item) {
          lstTmp.add(NotificationModel.fromJson(item));
        });
        lstNotifi = lstTmp;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      print('get notify faild');
    }
  }

  Future<void> deleteOrder(int orderId, int accountId) async {
    List<OrderItem> tmp = [];
    String url = "http://192.168.1.4:8000/api/cart/delete-order";
    http.Response response = await http.post(Uri.parse(url), body: {
      'order_id': orderId.toString(),
      'account_id': accountId.toString()
    });
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data2 = object['lstorder'];
        data2.forEach((item) {
          tmp.add(OrderItem.fromJson(item));
        });
        lstOrders = tmp;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      print('delete order faild');
    }
  }
}
