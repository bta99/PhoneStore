import 'dart:convert';

import 'package:ecommerce_shop/api/product/color_prod.dart';
import 'package:ecommerce_shop/api/product/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductApi extends ChangeNotifier {
  List<Colorpro> products2 = [];
  List<Product> lstproduct = [];
  List<Colorpro> lstcolor = [];
  List<Colorpro> lstsales = [];
  List<Colorpro> prod = [];
  int currentIndex = 0;
  int price = 0;
  Colorpro? itemtemp;
  int index = 0; // index bottom nav in home
  changeIndex(int value) {
    index = value;
    notifyListeners();
  }

  Future<void> searchProduct(Function(String) onError, int? id) async {
    //get product detail
    List<Colorpro> products = [];
    String endpoint = 'http://192.168.1.6:8000/api/search?categoryid=$id';
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

  Future<void> searchProduct2(Function(String) onError, String name) async {
    //get product by product type
    List<Colorpro> products = [];
    String endpoint = 'http://192.168.1.6:8000/api/search-name?name=$name';
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

  Future<void> getProduct(Function(String) onError) async {
    //get all product
    // List<Product> products = [];
    List<Colorpro> lstcolor2 = [];
    String endpoint = 'http://192.168.1.6:8000/api/product';
    http.Response response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        // dynamic data = jsonRaw['lstPro'];
        dynamic data2 = jsonRaw['lstColor'];
        // data.forEach((p) {
        //   products.add(Product.fromJson(p));
        // });
        data2.forEach((c) {
          lstcolor2.add(Colorpro.fromJson(c));
        });
      } catch (e) {
        print('faild login product cc');
      }
    } else {
      print('login faild product');
    }
    // lstproduct = products;
    lstcolor = lstcolor2;
    notifyListeners();
    // print(lstcolor.length);
  }

  Future<void> getProductId(Function(String) onError, String id) async {
    //get product like product type
    List<Colorpro> products = [];
    String endpoint = 'http://192.168.1.6:8000/api/product2';
    http.Response response =
        await http.post(Uri.parse(endpoint), body: {'id': id});
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        dynamic data = jsonRaw['lstColor'];
        data.forEach((p) {
          products.add(Colorpro.fromJson(p));
        });
        // print(products.length);
      } catch (e) {
        print('faild login product cc');
      }
    } else {
      print('login faild product');
    }
    prod = products;
    notifyListeners();
    // print(prod.length);
  }

  void change(int value) {
    currentIndex = value;
    notifyListeners();
  }

  void changePrice(int? value) {
    price = value!;
    notifyListeners();
  }

  void changeItem(Colorpro value) {
    itemtemp = value;
    notifyListeners();
  }

  /*get product sales*/
  Future<void> getProductSales(Function(String) onError) async {
    //get all product
    // List<Product> products = [];
    List<Colorpro> lstprodsales = [];
    String endpoint = 'http://192.168.1.6:8000/api/product-sales';
    http.Response response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        // dynamic data = jsonRaw['lstPro'];
        dynamic data2 = jsonRaw['lstColor'];
        // data.forEach((p) {
        //   products.add(Product.fromJson(p));
        // });
        data2.forEach((c) {
          lstprodsales.add(Colorpro.fromJson(c));
        });
      } catch (e) {
        print('faild login product cc');
      }
    } else {
      print('login faild product');
    }
    // lstproduct = products;
    lstsales = lstprodsales;
    notifyListeners();
    // print(lstcolor.length);
  }

  Future<dynamic> getOneProduct(int id) async {
    //get product like product type
    Colorpro? itemProduct;
    String endpoint = 'http://192.168.1.6:8000/api/product/get-one/$id';
    http.Response response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        dynamic data = jsonRaw['results'];
        itemProduct = Colorpro.fromJson(data[0]);
        // print(itemProduct.name);
      } catch (e) {
        print('faild get item');
      }
    } else {
      print('get item product faild');
    }
    return itemProduct;
  }
}
