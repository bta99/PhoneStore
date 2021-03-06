import 'package:ecommerce_shop/screens/tabs/order_tab1.dart';
import 'package:ecommerce_shop/screens/tabs/order_tab2.dart';
import 'package:ecommerce_shop/screens/tabs/order_tab3.dart';
import 'package:ecommerce_shop/screens/tabs/order_tab4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({Key? key}) : super(key: key);
  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: const Text(
              'Tình trạng đơn hàng',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Colors.black,
                )),
            bottom: TabBar(
                onTap: (index) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          content: SizedBox(
                            height: 50,
                            width: 100,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [CircularProgressIndicator()],
                              ),
                            ),
                          ),
                        );
                      });

                  Future.delayed(const Duration(milliseconds: 1500), () {
                    Navigator.pop(context, 'cancel');
                  });
                },
                indicatorColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                physics: BouncingScrollPhysics(),
                tabs: const [
                  Tab(
                      child: Text(
                    'Chờ xử lí',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold),
                  )),
                  Tab(
                      child: Text(
                    'Đã đóng gói',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold),
                  )),
                  Tab(
                      child: Text(
                    'Đang giao',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold),
                  )),
                  Tab(
                      child: Text(
                    'Đã nhận',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold),
                  )),
                ]),
          ),
          body: const TabBarView(children: [
            OrderScreen1(),
            OrderScreen2(),
            OrderScreen3(),
            OrderScreen4()
          ]),
        ));
  }
}
