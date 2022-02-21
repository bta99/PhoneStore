import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/api/order/order_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderCancelScreen extends StatefulWidget {
  const OrderCancelScreen({Key? key}) : super(key: key);

  @override
  _OrderCancelScreenState createState() => _OrderCancelScreenState();
}

class _OrderCancelScreenState extends State<OrderCancelScreen> {
  @override
  Widget build(BuildContext context) {
    var orderapi = Provider.of<OrderApi>(context, listen: false);
    var account = Provider.of<CartApi>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          'Đơn hàng đã huỷ',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 16,
          ),
        ),
      ),
      body: FutureBuilder(
        future: orderapi.getOrder(account.acctemp!.id, 'đã huỷ'),
        builder: (_, AsyncSnapshot snapshot) {
          return Consumer<OrderApi>(
            builder: (_, order, child) {
              return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: List.generate(orderapi.lstOrders.length, (index) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 5.0, bottom: 5),
                            child: Divider(
                              height: 10,
                              thickness: 10,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.red)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Mã đơn hàng:',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(orderapi.lstOrders[index].id
                                            .toString())
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Người đặt:',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(orderapi.lstOrders[index].fullname)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Địa chỉ:',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(
                                          child: Text(
                                            orderapi.lstOrders[index].address,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Số điện thoại:',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          orderapi.lstOrders[index].phone
                                              .toString(),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Ngày đặt:',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          orderapi.lstOrders[index].datecreate
                                              .toString(),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Thành tiền:',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          NumberFormat.currency(locale: 'vi')
                                              .format(orderapi
                                                  .lstOrders[index].total),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Trạng thái:',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          orderapi.lstOrders[index].status,
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SizedBox(
                                          width: 200,
                                          height: 35,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, 'order_detail',
                                                    arguments: orderapi
                                                        .lstOrders[index]);
                                              },
                                              child: const Text(
                                                  'Xem chi tiết đơn hàng')),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SizedBox(
                                          width: 70,
                                          height: 35,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Colors
                                                                  .redAccent)),
                                              onPressed: () {
                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (_) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        elevation: 0.0,
                                                        content: SizedBox(
                                                          height: 50,
                                                          width: 100,
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: const [
                                                                CircularProgressIndicator()
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });

                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 1500),
                                                    () {
                                                  Navigator.pop(
                                                      context, 'cancel');
                                                });
                                                orderapi.deleteOrder(
                                                    orderapi
                                                        .lstOrders[index].id,
                                                    orderapi.lstOrders[index]
                                                        .accountid);
                                              },
                                              child: const Text('ẩn')),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ));
            },
          );
        },
      ),
    );
  }
}
