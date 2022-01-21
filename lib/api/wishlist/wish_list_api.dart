import 'dart:convert';

import 'package:ecommerce_shop/api/wishlist/wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WishListApi extends ChangeNotifier {
  // List<WishList> wishlist = [];
  // Future<void> getWishList(int accountid) async {
  //   List<WishList> list = [];
  //   String url = "http://192.168.1.6:8000/api/product/wishlist/$accountid";
  //   http.Response response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     try {
  //       dynamic object = json.decode(response.body);
  //       dynamic data = object['results'];
  //       data.forEach((item) {
  //         list.add(WishList.fromJson(item));
  //       });
  //       wishlist = list;
  //       notifyListeners();
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     // print("faild get wish list");
  //   }
}

  // bool check = false;
  // Future<void> checkWishList(int accountid, int productid) async {
  //   bool kq = false;
  //   String url = "http://192.168.1.6:8000/api/product/check-wishlist";
  //   http.Response response = await http.post(Uri.parse(url), body: {
  //     'account_id': accountid.toString(),
  //     'product_id': productid.toString()
  //   });
  //   if (response.statusCode == 200) {
  //     try {
  //       dynamic object = json.decode(response.body);
  //       dynamic data = object['check'];
  //       kq = data;
  //       check = kq;
  //       notifyListeners();
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     // print("faild check wish list");
  //   }
  // }

