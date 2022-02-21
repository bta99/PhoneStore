import 'dart:convert';
import 'package:ecommerce_shop/api/order/comment.dart';
import 'package:ecommerce_shop/api/order_detail/order_detail_model.dart';
import 'package:ecommerce_shop/api/product/color_prod.dart';
import 'package:ecommerce_shop/api/product/product.dart';
import 'package:ecommerce_shop/api/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductApi extends ChangeNotifier {
  List<Colorpro> products2 = [];
  List<Product> lstproduct = [];
  List<Colorpro> lstcolor = [];
  List<Colorpro> lstsales = [];
  List<Colorpro> prod = [];
  List<WishList> wishlist = [];
  int currentIndex = 0;
  int price = 0;
  late Colorpro itemtemp;
  int index = 0; // index bottom nav in home
  changeIndex(int value) {
    index = value;
    notifyListeners();
  }

  Future<void> searchProduct(
      Function(String) onError, int? id, String? cal) async {
    //get product detail
    List<Colorpro> products = [];
    String endpoint = 'http://192.168.1.4:8000/api/search';
    http.Response response = await http.post(Uri.parse(endpoint),
        body: {'categoryid': id.toString(), 'cal': cal});
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        dynamic data = jsonRaw['lstpro'];
        data.forEach((p) {
          products.add(Colorpro.fromJson(p));
        });
      } catch (e) {
        print('không lấy đc sản phẩm rồi');
      }
    } else {
      print('thua');
    }
    products2 = products;
    notifyListeners();
  }

  Future<void> searchProduct2(Function(String) onError, String name) async {
    //get product by product type
    List<Colorpro> products = [];
    String endpoint = 'http://192.168.1.4:8000/api/search-name?name=$name';
    http.Response response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        dynamic data = jsonRaw['lstpro'];
        data.forEach((p) {
          products.add(Colorpro.fromJson(p));
        });
      } catch (e) {
        print('không lấy đc sản phẩm rồi');
      }
    } else {
      print('thua');
    }
    products2 = products;
    notifyListeners();
  }

  // Future<void> getProduct(Function(String) onError) async {
  //   List<Colorpro> lstcolor2 = [];
  //   String endpoint = 'http://192.168.1.4:8000/api/product';
  //   http.Response response = await http.get(Uri.parse(endpoint));
  //   if (response.statusCode == 200) {
  //     try {
  //       dynamic jsonRaw = json.decode(response.body);
  //       dynamic data2 = jsonRaw['lstColor'];
  //       data2.forEach((c) {
  //         lstcolor2.add(Colorpro.fromJson(c));
  //       });
  //     } catch (e) {
  //       print('faild login product cc');
  //     }
  //   } else {
  //     print('get product faild');
  //   }
  //   lstcolor = lstcolor2;
  //   // notifyListeners();
  // }

  bool? check;
  List<Comment> lstComments = [];
  bool check2 = false;
  Future<void> getProductId(
      Function(String) onError, int id, int accountid, int productid) async {
    //get product like product type
    List<Colorpro> products = [];
    List<Comment> lstTmp = [];
    String endpoint = 'http://192.168.1.4:8000/api/product2';
    http.Response response = await http.post(Uri.parse(endpoint), body: {
      'id': id.toString(),
      'account_id': accountid.toString(),
      'product_id': productid.toString()
    });
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        dynamic data = jsonRaw['lstColor'];
        data.forEach((p) {
          products.add(Colorpro.fromJson(p));
        });
        dynamic lstCm = jsonRaw['lstCM'];
        dynamic kq = jsonRaw['check'];
        dynamic kq2 = jsonRaw['check2'];
        lstCm.forEach((item) {
          lstTmp.add(Comment.fromJson(item));
        });
        lstComments = lstTmp;
        check = kq;
        prod = products;
        check2 = kq2;
        notifyListeners();
      } catch (e) {
        print('faild login product cc');
      }
    } else {
      print('faild lay san pham theo id ');
    }
    // print(id);
  }

  void change(int value) {
    currentIndex = value;
    notifyListeners();
  }

  void changePrice(int? value) {
    price = value!;
    notifyListeners();
  }

  changeItem(Colorpro value) {
    itemtemp = value;
    notifyListeners();
  }

  resetItemtemp() {
    prod = [];
    notifyListeners();
  }

  /*get product sales*/
  Future<void> getProductSales(Function(String) onError) async {
    List<Colorpro> lstprodsales = [];
    String endpoint = 'http://192.168.1.4:8000/api/product-sales';
    http.Response response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        dynamic data2 = jsonRaw['lstColor'];
        data2.forEach((c) {
          lstprodsales.add(Colorpro.fromJson(c));
        });
      } catch (e) {
        print('faild login product cc');
      }
    } else {
      print('login faild product');
    }
    lstsales = lstprodsales;
    // notifyListeners();
  }

  late Colorpro itemProduct;
  Future<Colorpro> getOneProduct(int id) async {
    //get product like product type

    String endpoint = 'http://192.168.1.4:8000/api/product/get-one/$id';
    http.Response response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        dynamic data = jsonRaw['results'];
        itemProduct = Colorpro.fromJson(data[0]);
      } catch (e) {
        print('faild get item');
      }
    } else {
      print('get item product faild');
    }
    return itemProduct;
  }

  Future<void> addComment(
      int accountid, int productid, int rating, String content) async {
    List<Comment> lsttmp = [];
    String endpoint = 'http://192.168.1.4:8000/api/product/add-comment';
    http.Response response = await http.post(Uri.parse(endpoint), body: {
      'account_id': accountid.toString(),
      'product_id': productid.toString(),
      'rating': rating.toString(),
      'content': content
    });
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['lstCM'];
        data.forEach((item) {
          lsttmp.add(Comment.fromJson(item));
        });
        lstComments = lsttmp;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      print('faild add comment');
    }
    // getComment(productid, accountid);
  }

  Future<dynamic> addWishList(int accountid, int productid) async {
    List<WishList> tmp = [];
    String url = "http://192.168.1.4:8000/api/product/add-wishlist";
    http.Response response = await http.post(Uri.parse(url), body: {
      'account_id': accountid.toString(),
      'product_id': productid.toString(),
    });
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['check'];
        dynamic data2 = object['lstWL'];
        check2 = data;
        data2.forEach((item) {
          tmp.add(WishList.fromJson(item));
        });
        wishlist = tmp;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      print("faild add wish list");
    }
  }

  Future<void> getWishList(int accountid) async {
    List<WishList> list = [];
    String url = "http://192.168.1.4:8000/api/product/wishlist/$accountid";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['results'];
        data.forEach((item) {
          list.add(WishList.fromJson(item));
        });
        wishlist = list;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      // print("faild get wish list");
    }
  }

  changeSearchProduct(List<Colorpro> lst) {
    products2 = lst;
    notifyListeners();
  }

  bool tmpResult = false;
  Future<bool> deleteWishListItem(int accountid, int productid, int cal) async {
    List<WishList> tmpList = [];
    String url = "http://192.168.1.4:8000/api/product/delete-wishlist";
    http.Response response = await http.post(Uri.parse(url), body: {
      'account_id': accountid.toString(),
      'product_id': productid.toString(),
      'cal': cal.toString()
    });
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['wishlist'];
        dynamic result = object['success'];
        data.forEach((item) {
          tmpList.add(WishList.fromJson(item));
        });
        wishlist = tmpList;
        tmpResult = result;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      print('delete faild');
    }
    return tmpResult;
  }

  List<OrderDetail> lstOrderdetail = [];
  Future<void> getOrderDetails(int accountid, int id) async {
    List<OrderDetail> list = [];
    String url = "http://192.168.1.4:8000/api/order/get-order-detail";
    http.Response response = await http.post(Uri.parse(url),
        body: {'account_id': accountid.toString(), 'id': id.toString()});
    if (response.statusCode == 200) {
      try {
        dynamic object = json.decode(response.body);
        dynamic data = object['lstOrderDetail'];
        data.forEach((item) {
          list.add(OrderDetail.fromJson(item));
        });
        lstOrderdetail = list;
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      print("faild get list order details");
    }
  }
}
