import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/api/order/order_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController nameCTL = TextEditingController();
  TextEditingController phoneCTL = TextEditingController();
  TextEditingController addressCTL = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cartapi = Provider.of<CartApi>(context, listen: false);
    var accountapi = Provider.of<ApiAcc>(context, listen: false);
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
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                          title: const Text('Chỉnh sửa Thông Tin Tài Khoản',
                              style: TextStyle(fontSize: 15)),
                          content: SizedBox(
                              height: 400,
                              width: 300,
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Text('Họ Tên'),
                                    ],
                                  ),
                                  TextField(
                                    controller: nameCTL
                                      ..text = accountapi.info!.fullname,
                                    decoration: const InputDecoration(),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: const [
                                      Text('Số điện thoại'),
                                    ],
                                  ),
                                  TextField(
                                    controller: phoneCTL
                                      ..text = accountapi.info!.phone,
                                    decoration: const InputDecoration(),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: const [
                                      Text('Địa Chỉ'),
                                    ],
                                  ),
                                  TextField(
                                    controller: addressCTL
                                      ..text = accountapi.info!.address,
                                    decoration: const InputDecoration(),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: const [
                                      Text('Email'),
                                    ],
                                  ),
                                  TextFormField(
                                    readOnly: true,
                                    initialValue: accountapi.info!.email,
                                    decoration: const InputDecoration(),
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await accountapi.updateInfo(
                                              accountapi.info!.id,
                                              nameCTL.text,
                                              phoneCTL.text,
                                              addressCTL.text);
                                          // accountapi.getInfoAcc((msg) {
                                          //   print(msg);
                                          // }, accountapi.info!.id);
                                          Navigator.pop(context, 'cancel');
                                        },
                                        child: const Text('Lưu')),
                                  )
                                ],
                              )));
                    });
              },
              child: Container(
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
                    Consumer<ApiAcc>(builder: (_, acc, child) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(children: [
                              Text(accountapi.info!.fullname,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                accountapi.info!.phone,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.grey),
                              )
                            ]),
                            SizedBox(
                                width: 200,
                                child: Text(accountapi.info!.address,
                                    style: const TextStyle(fontSize: 12)))
                          ],
                        ),
                      );
                    }),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Icon(Icons.arrow_forward_ios, size: 15)],
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: cartapi.lstCartCheckout((msg) {
                print(msg);
              }, cartapi.acctemp!.id),
              builder: (_, AsyncSnapshot snapshot) {
                var length = cartapi.lstItemCheckout.length;
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
                              'http://192.168.1.4:8000${cartapi.lstItemCheckout[index].image}',
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
                                      cartapi.lstItemCheckout[index].name,
                                      style: const TextStyle(fontSize: 13),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                      'Màu:${cartapi.lstItemCheckout[index].color}'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      cartapi.lstItemCheckout[index]
                                                  .salesprice >
                                              0
                                          ? Text(
                                              'Giá:${NumberFormat.currency(locale: 'vi').format(cartapi.lstItemCheckout[index].salesprice)}',
                                              style:
                                                  const TextStyle(fontSize: 14))
                                          : Text(
                                              'Giá:${NumberFormat.currency(locale: 'vi').format(cartapi.lstItemCheckout[index].price)}',
                                              style: const TextStyle(
                                                  fontSize: 14)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Text(
                                            'số lượng:${cartapi.lstItemCheckout[index].quantity}',
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
                                          'Tổng tiền:',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        cartapi.lstItemCheckout[index]
                                                    .salesprice >
                                                0
                                            ? Text(NumberFormat.currency(
                                                    locale: 'vi')
                                                .format(cartapi
                                                        .lstItemCheckout[index]
                                                        .salesprice *
                                                    cartapi
                                                        .lstItemCheckout[index]
                                                        .quantity))
                                            : Text(NumberFormat.currency(
                                                    locale: 'vie')
                                                .format(cartapi
                                                        .lstItemCheckout[index]
                                                        .price *
                                                    cartapi
                                                        .lstItemCheckout[index]
                                                        .quantity)),
                                        const Text(
                                          ',số lượng:',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        Text(cartapi
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
                            '25.000 VND',
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
                              cartapi.selectPay('Thanh toán khi nhận hàng');
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
                              cartapi.selectPay('Thanh toán qua Momo');
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
              padding: const EdgeInsets.only(left: 5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Text('Tổng cộng:'),
                        Text(
                          NumberFormat.currency(locale: 'vi')
                              .format(cartapi.totalcheckout),
                          style:
                              const TextStyle(color: Colors.red, fontSize: 15),
                        ),
                      ],
                    ),
                    cartapi.pay != ""
                        ? Text(cartapi.pay,
                            style: const TextStyle(fontSize: 12))
                        : Container()
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    var content = const SnackBar(
                        content: Text('vui lòng chọn phưong thức thanh toán'));
                    if (cartapi.pay == "") {
                      ScaffoldMessenger.of(context).showSnackBar(content);
                    } else {
                      orderpay.pay(
                          accountapi.info!.address,
                          accountapi.info!.phone,
                          cartapi.totalcheckout,
                          accountapi.info!.id);
                      // cartapi.resetAllStatusCart((msg) {
                      //   print(msg);
                      // }, cartapi.acctemp!.id);
                      cartapi.resetTotal();
                      cartapi.resetbtnAll();
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
                                    children: const [
                                      CircularProgressIndicator()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                      Future.delayed(const Duration(milliseconds: 2000), () {
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
