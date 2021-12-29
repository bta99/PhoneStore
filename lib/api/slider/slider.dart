import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slider {
  int id;
  String image;

  Slider.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'];
}
