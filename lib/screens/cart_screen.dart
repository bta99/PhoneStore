import 'package:ecommerce_shop/api/account/account_api.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:ecommerce_shop/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var acc = Provider.of<CartApi>(context, listen: false);
    var apicart = Provider.of<CartApi>(context, listen: false);
    var pro = Provider.of<ProductApi>(context, listen: false);
    // var arg = ModalRoute.of(context)!.settings.arguments as Account;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text('Giỏ hàng của tôi!',
            style: TextStyle(color: Colors.black, fontSize: 15)),
        actions: [
          IconButton(
              onPressed: () {},
              icon:
                  const Icon(Icons.delete_sharp, color: Colors.black, size: 18))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: FutureBuilder(
          future: apicart.getCart((msg) {
            print(apicart.lstcart.length);
          }, acc.acctemp!.id),
          builder: (_, AsyncSnapshot snapshot) {
            return Column(
              children: List.generate(apicart.lstcart.length, (index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            'http://192.168.1.6:8000${apicart.lstcart[index].image}',
                            width: 120,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(
                                width: 130,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text('Iphone 13 pro max 6GB/64GB'),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text('Màu:đỏ'),
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.remove_shopping_cart,
                                color: Colors.red))
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5.0, left: 35, right: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                              '${apicart.lstcart[index].price * apicart.lstcart[index].quantity}\$',
                              style: const TextStyle(color: Colors.redAccent)),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add)),
                              Text('${apicart.lstcart[index].quantity}'),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.remove))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              }),
            );
          },
        ),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
                top: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey))),
        height: 55,
        child: Row(
          children: [
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                const Text('Tất cả')
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: const [
                    Text('Tổng cộng:'),
                    Text(
                      '500.000đ',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text('Phí ship:'),
                    Text(
                      '50.000đ',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: GestureDetector(
                onTap: () {
                  print('Thanh Toán');
                },
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                      child: Text('Thanh Toán',
                          style: TextStyle(color: Colors.white))),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.redAccent,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: 'Trang Chủ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: 'Yêu Thích'),
          BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts), label: 'Tài Khoản'),
        ],
      ),
    );
  }
}
