import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaySuccessScreen extends StatefulWidget {
  const PaySuccessScreen({Key? key}) : super(key: key);

  @override
  _PaySuccessScreenState createState() => _PaySuccessScreenState();
}

class _PaySuccessScreenState extends State<PaySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    var account = Provider.of<CartApi>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Thanh toán khi nhận hàng',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              account.resetTotalcheckout();
              Navigator.popAndPushNamed(context, 'cart');
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.black,
            )),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              'https://www.ignitebh.com/wp-content/uploads/2020/04/payment_success_icon.png',
              height: 100,
              width: 100,
            ),
            const Text('Đặt hàng thành công!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Thành tiền:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
                Text('${account.totalcheckout}\$',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Vui lòng chuẩn bị số tiền tương ứng khi nhận hàng!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  )),
            ),
            GestureDetector(
              onTap: () {
                account.resetTotalcheckout();
                Navigator.popAndPushNamed(context, 'home');
              },
              child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.red,
                      )),
                  child: const Center(
                    child: Text('Tiếp tục mua sắm',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
