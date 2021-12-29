import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Category {
  int id;
  String image;
  String productType;

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        productType = json['type_prod'];
}
