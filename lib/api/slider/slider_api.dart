import 'dart:convert';
import 'package:ecommerce_shop/api/category/category.dart';
import 'package:ecommerce_shop/api/product/color_prod.dart';
import 'package:ecommerce_shop/api/slider/slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

class SliderApi extends ChangeNotifier {
  List<Slider> sliders = [];
  List<Category> categories = [];
  List<Colorpro> lstcolor = [];
  List<Colorpro> lstsales = [];
  Future<void> getSlider(Function(String) onError) async {
    // List<Product> products = [];
    if (sliders.isEmpty) {
      List<Slider> sli = [];
      List<Category> cate = [];
      List<Colorpro> lstprodsales = [];
      List<Colorpro> lstproduct = [];
      String endpoint = 'http://192.168.1.6:8000/api/slider';
      http.Response response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        try {
          dynamic jsonRaw = json.decode(response.body);
          dynamic data1 = jsonRaw['lstSlider'];
          dynamic data2 = jsonRaw['lstCate'];
          dynamic data3 = jsonRaw['lstProduct'];
          dynamic data4 = jsonRaw['lstSales'];
          data1.forEach((s) {
            sli.add(Slider.fromJson(s));
          });
          data2.forEach((s) {
            cate.add(Category.fromJson(s));
          });
          data3.forEach((s) {
            lstproduct.add(Colorpro.fromJson(s));
          });
          data4.forEach((s) {
            lstprodsales.add(Colorpro.fromJson(s));
          });
          sliders = sli;
          categories = cate;
          lstcolor = lstproduct;
          lstsales = lstprodsales;
          notifyListeners();
        } catch (e) {
          print('get sliders faild');
        }
      } else {
        print('faild get slider');
      }
      // lstproduct = products;
      // print(lstcolor.length);
    }
  }
}
