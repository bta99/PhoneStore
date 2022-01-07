import 'dart:convert';
import 'package:ecommerce_shop/api/slider/slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SliderApi extends ChangeNotifier {
  List<Slider> sliders = [];
  Future<void> getSlider(Function(String) onError) async {
    // List<Product> products = [];
    List<Slider> sli = [];
    String endpoint = 'http://192.168.1.6:8000/api/slider';
    http.Response response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      try {
        dynamic jsonRaw = json.decode(response.body);
        dynamic data = jsonRaw['results'];
        data.forEach((s) {
          sli.add(Slider.fromJson(s));
        });
      } catch (e) {
        print('get sliders faild');
      }
    } else {
      print('faild get slider');
    }
    // lstproduct = products;
    sliders = sli;
    notifyListeners();
    // print(sliders.length);
    // print(lstcolor.length);
  }
}
