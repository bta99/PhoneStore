import 'package:ecommerce_shop/api/order/order_item_show.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var productapi = Provider.of<ProductApi>(context, listen: false);
    var arg = ModalRoute.of(context)!.settings.arguments as OrderItem;
    productapi.getOrderDetails(arg.accountid, arg.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Chi tiết đơn hàng',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios,
                color: Colors.black, size: 15)),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text(
                    'Đơn hàng số: ${arg.id}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text(
                    'Ngày đặt: ${arg.datecreate}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text(
                    'Người đặt: ${arg.fullname}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text(
                    'Địa chỉ: ${arg.address}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text(
                    'Tình trạng: ${arg.status}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            Consumer<ProductApi>(
              builder: (_, value, child) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    // width: 350,
                    // height: 255,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 5,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: List.generate(productapi.lstOrderdetail.length,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'http://192.168.1.4:8000' +
                                      productapi.lstOrderdetail[index].image,
                                  // width: 120,
                                  height: 80,
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 5),
                                    child: SizedBox(
                                      width: 180,
                                      child: Text(
                                        productapi.lstOrderdetail[index].name,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 5),
                                    child: SizedBox(
                                      width: 180,
                                      child: Text(
                                        'Màu: ${productapi.lstOrderdetail[index].color}',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        productapi.lstOrderdetail[index]
                                                    .salesprice >
                                                0
                                            ? Column(
                                                children: [
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'vi')
                                                        .format(productapi
                                                            .lstOrderdetail[
                                                                index]
                                                            .salesprice),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'vi')
                                                        .format(productapi
                                                            .lstOrderdetail[
                                                                index]
                                                            .price),
                                                    style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                NumberFormat.currency(
                                                        locale: 'vi')
                                                    .format(productapi
                                                        .lstOrderdetail[index]
                                                        .price),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.red,
                                                ),
                                              ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Số lượng: ' +
                                              productapi.lstOrderdetail[index]
                                                  .quantity
                                                  .toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                );
              },
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Tổng cộng: ' +
                        NumberFormat.currency(locale: 'vi').format(arg.total),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
