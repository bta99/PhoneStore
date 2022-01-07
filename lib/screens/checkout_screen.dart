import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/api/order/order_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    var account = Provider.of<CartApi>(context, listen: false);
    var orderpay = Provider.of<OrderApi>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,
                  size: 16, color: Colors.black)),
          title: const Text(
            'Thanh Toán',
            style: TextStyle(fontSize: 16, color: Colors.black),
          )),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.blue[100],
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_active,
                        size: 15, color: Colors.blue[900]),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 305,
                      child: Text(
                        'Đơn hàng có khả năng được giao ngoài giờ làm việc hoặc vào cuối tuần để đến tay bạn sớm nhất có thể.Nếu được,hãy chọn giao hàng tại địa chỉ nhà riêng để đảm bảo giao hàng tốt nhất.',
                        style: TextStyle(fontSize: 11, color: Colors.blue[900]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 15, left: 10, right: 10, bottom: 10),
              // height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: const [
                        Icon(Icons.local_shipping_outlined,
                            color: Colors.blue, size: 25)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          Text(account.acctemp!.fullname,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            account.acctemp!.phone,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey),
                          )
                        ]),
                        SizedBox(
                            width: 200,
                            child: Text(account.acctemp!.address,
                                style: const TextStyle(fontSize: 12)))
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.arrow_forward_ios, size: 15)],
                  )
                ],
              ),
            ),
            FutureBuilder(
              future: account.lstCartCheckout((msg) {
                print(msg);
              }, account.acctemp!.id),
              builder: (_, AsyncSnapshot snapshot) {
                var length = account.lstItemCheckout.length;
                return Column(
                    //Danh sách sản phẩm thanh toán
                    children: List.generate(length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              'http://192.168.1.6:8000${account.lstItemCheckout[index].image}',
                              width: 70,
                              height: 70,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 280,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      account.lstItemCheckout[index].name,
                                      style: const TextStyle(fontSize: 13),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                      'Màu:${account.lstItemCheckout[index].color}'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      account.lstItemCheckout[index]
                                                  .salesprice >
                                              0
                                          ? Text(
                                              'Giá:${account.lstItemCheckout[index].salesprice}\$',
                                              style:
                                                  const TextStyle(fontSize: 14))
                                          : Text(
                                              'Giá:${account.lstItemCheckout[index].price}\$',
                                              style: const TextStyle(
                                                  fontSize: 14)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Text(
                                            'số lượng:${account.lstItemCheckout[index].quantity}',
                                            style:
                                                const TextStyle(fontSize: 14)),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Subtotal:',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        account.lstItemCheckout[index]
                                                    .salesprice >
                                                0
                                            ? Text(
                                                '${account.lstItemCheckout[index].salesprice * account.lstItemCheckout[index].quantity}\$')
                                            : Text(
                                                '${account.lstItemCheckout[index].price * account.lstItemCheckout[index].quantity}\$'),
                                        const Text(
                                          ',item:',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        Text(account
                                            .lstItemCheckout[index].quantity
                                            .toString())
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }));
              },
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 15, left: 10, right: 10, bottom: 5),
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: const [
                        Icon(Icons.payment, color: Colors.blue, size: 25)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: const [
                          Text('giao hàng tiêu chuẩn',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            '0.5\$',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          )
                        ]),
                        const SizedBox(
                            width: 200,
                            child: Text(
                                'hàng sẽ được giao sau 3 ngày kể từ ngày đặt',
                                style: TextStyle(fontSize: 12)))
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.arrow_downward, size: 15)],
                  )
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Chọn phương thức thanh toán',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                      Row(
                        children: const [
                          Text('xem thêm', style: TextStyle(fontSize: 13)),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 13,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Consumer<CartApi>(
                  builder: (_, cart, child) {
                    return SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          GestureDetector(
                            onTap: () {
                              account.selectPay('Thanh toán khi nhận hàng');
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, bottom: 10),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.blue),
                                      color: Colors.lightBlueAccent[50]),
                                  width: 200,
                                  height: 80,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.payments,
                                                color: Colors.blue),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('Thanh toán khi nhận hàng',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                        const Text('Thanh toán khi nhận hàng',
                                            style: TextStyle(fontSize: 12))
                                      ])),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              account.selectPay('Thanh toán qua Momo');
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, bottom: 10),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.pink),
                                      color: Colors.lightBlueAccent[50]),
                                  width: 200,
                                  height: 80,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.payment,
                                                color: Colors.pink),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('Thanh toán qua Momo',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                        const Text('kết nối ví momo',
                                            style: TextStyle(fontSize: 12))
                                      ])),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(width: 1, color: Colors.grey))),
        height: 50,
        child: Consumer<CartApi>(
          builder: (_, cart, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Text('Tổng cộng:'),
                        Text(
                          '${account.totalcheckout}\$',
                          style:
                              const TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ],
                    ),
                    account.pay != ""
                        ? Text(account.pay,
                            style: const TextStyle(fontSize: 12))
                        : Container()
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    var content = const SnackBar(
                        content: Text('vui lòng chọn phưong thức thanh toán'));
                    if (account.pay == "") {
                      ScaffoldMessenger.of(context).showSnackBar(content);
                    } else {
                      orderpay.pay(
                          account.acctemp!.address,
                          account.acctemp!.phone,
                          account.totalcheckout,
                          account.acctemp!.id);
                      account.resetAllStatusCart((msg) {
                        print(msg);
                      }, account.acctemp!.id);
                      account.resetTotal();
                      account.resetbtnAll();
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 50,
                                width: 100,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        Navigator.pushNamed(context, 'pay_success');
                      });
                    }
                  },
                  child: Container(
                    width: 130,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white, width: 1.5),
                        color: Colors.red),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.payment_outlined, color: Colors.white),
                          Text('Thanh toán',
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}