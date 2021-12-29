import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Product {
  int id;
  String name;
  // String image;
  String info;
  int ram;
  int rom;
  // int categoryid;
  // int brandid;
  // String status;

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        info = json['info'],
        // image = json['image'],
        ram = json['ram'],
        rom = json['rom'];
  // categoryid = json['category_id'],
  // brandid = json['brand_id'],
  // status = json['status'];
}
