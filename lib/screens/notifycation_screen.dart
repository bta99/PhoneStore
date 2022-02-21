import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/api/order/order_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotifycationScreen extends StatefulWidget {
  const NotifycationScreen({Key? key}) : super(key: key);
  static String id = 'notification';
  @override
  _NotifycationScreenState createState() => _NotifycationScreenState();
}

class _NotifycationScreenState extends State<NotifycationScreen> {
  @override
  Widget build(BuildContext context) {
    var orderapi = Provider.of<OrderApi>(context, listen: false);
    var accountapi = Provider.of<ApiAcc>(context, listen: false);
    orderapi.getNotifi(accountapi.info!.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 16,
            )),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Consumer<OrderApi>(
          builder: (_, value, child) {
            return Column(
              children: List.generate(orderapi.lstNotifi.length, (index) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                    right: 15,
                    left: 15,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 5,
                      )
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications_active),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: 295,
                          child: Text(orderapi.lstNotifi[index].content)),
                    ],
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
