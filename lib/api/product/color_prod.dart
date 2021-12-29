import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Colorpro {
  int id;
  String color;
  String name;
  String info;
  int ram;
  int rom;
  int pin;
  int camera;
  String image;
  int price;
  int salesprice;
  int stock;
  int productid;

  Colorpro.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        color = json['color'],
        name = json['name'],
        info = json['info'],
        ram = json['ram'],
        rom = json['rom'],
        pin = json['pin'],
        camera = json['camera'],
        image = json['image'],
        price = json['price'],
        salesprice = json['sales_price'],
        stock = json['stock'],
        productid = json['product_id'];
}
