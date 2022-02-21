import 'package:ecommerce_shop/api/order/order_api.dart';
import 'package:ecommerce_shop/screens/wish_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckBoxScreen extends StatefulWidget {
  const CheckBoxScreen({Key? key}) : super(key: key);
  static String id = 'checkbox';
  @override
  _CheckBoxScreenState createState() => _CheckBoxScreenState();
}

class _CheckBoxScreenState extends State<CheckBoxScreen> {
  @override
  Widget build(BuildContext context) {
    var rating = Provider.of<OrderApi>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('rating demo'),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CheckBoxScreen.id);
                  },
                  child: Container(
                    width: 150,
                    height: 200,
                    color: Colors.red,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
