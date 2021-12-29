import 'dart:convert';
import 'package:ecommerce_shop/api/category/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CategoryApi extends ChangeNotifier {
  List<Category> categories = [];
  Future<void> getCategory(Function(String) onError) async {
    // List<Product> products = [];
    List<Category> cate = [];
    String endpoint = 'http://192.168.1.6:8000/api/category';
    http.Response response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        dynamic data = jsonRaw['results'];
        data.forEach((s) {
          cate.add(Category.fromJson(s));
        });
      } catch (e) {
        print('get sliders faild');
      }
    } else {
      print('faild get slider');
    }
    // lstproduct = products;
    print('success');
    categories = cate;
    notifyListeners();
    // print(categories.length);
    // print(lstcolor.length);
  }
}
