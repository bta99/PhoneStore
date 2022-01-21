import 'dart:async';
import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/api/product/color_prod.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cartapi = Provider.of<CartApi>(context, listen: false);
    var accountapi = Provider.of<ApiAcc>(context, listen: false);
    var pro = Provider.of<ProductApi>(context, listen: false);
    // var arg = ModalRoute.of(context)!.settings.arguments as Account;

    cartapi.getCart((msg) {
      print(msg);
    }, accountapi.info!.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Consumer<CartApi>(
          builder: (_, c, child) {
            return Text('Giỏ hàng của tôi (${cartapi.lstcart.length})',
                style: const TextStyle(color: Colors.black, fontSize: 15));
          },
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon:
                  const Icon(Icons.delete_sharp, color: Colors.black, size: 18))
        ],
        leading: IconButton(
            onPressed: () {
              cartapi.resetAllStatusCart((msg) {
                print(msg);
              }, cartapi.acctemp!.id);
              pro.changeIndex(0);
              cartapi.resetTotal();
              cartapi.resetbtnAll();
              Navigator.popAndPushNamed(context, 'home');
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Consumer<CartApi>(
          builder: (_, cart, child) {
            return cartapi.lstcart.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 400,
                            width: 400,
                            child: Image.network(
                                'https://cdn.dribbble.com/users/844846/screenshots/2981974/empty_cart_800x600_dribbble.png')),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'home');
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.transparent,
                                border: Border.all(color: Colors.red)),
                            child: const Center(
                              child: Text('Tiếp tục mua sắm!'),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Column(
                    children: List.generate(cartapi.lstcart.length, (index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  shape: const CircleBorder(),
                                  value: cartapi.lstcart[index].status == 0
                                      ? false
                                      : true,
                                  onChanged: (value) async {
                                    await cartapi.updateStatusCart((msg) {
                                      print(msg);
                                    }, cartapi.lstcart[index].accountid,
                                        cartapi.lstcart[index].productid);
                                    loadingDialog(context);
                                    Future.delayed(
                                        const Duration(milliseconds: 1500), () {
                                      Navigator.pop(context, 'cancel');
                                    });

                                    cartapi.updateTotal(cartapi.lstcart[index]);
                                    cartapi.resetbtnAll();
                                  }),
                              GestureDetector(
                                onTap: () async {
                                  Colorpro item = await pro.getOneProduct(
                                      cartapi.lstcart[index].productid);
                                  pro.changeItem(item);
                                  Navigator.pushNamed(
                                    context,
                                    'test',
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    'http://192.168.1.6:8000${cartapi.lstcart[index].image}',
                                    width: 120,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: 130,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child:
                                            Text(cartapi.lstcart[index].name),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                        'Màu:${cartapi.lstcart[index].color}'),
                                  )
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    CircularProgressIndicator()
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });

                                    Future.delayed(
                                        const Duration(milliseconds: 1500), () {
                                      Navigator.pop(context, 'cancel');
                                    });
                                    cartapi.removeTotalItem(
                                        cartapi.lstcart[index]);
                                    cartapi.deleteCart((msg) {
                                      print(msg);
                                    }, cartapi.lstcart[index].accountid,
                                        cartapi.lstcart[index].productid);

                                    cartapi.resetbtnAll();
                                  },
                                  icon: const Icon(Icons.remove_shopping_cart,
                                      color: Colors.red)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                cartapi.lstcart[index].salesprice == 0
                                    ? Text(
                                        NumberFormat.currency(locale: 'vi')
                                            .format(
                                                cartapi.lstcart[index].price),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Row(children: [
                                          Text(
                                            NumberFormat.currency(locale: 'vi')
                                                .format(cartapi
                                                    .lstcart[index].salesprice),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            NumberFormat.currency(locale: 'vi')
                                                .format(cartapi
                                                    .lstcart[index].price),
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ]),
                                      ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
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
                                                  milliseconds: 1500), () {
                                            Navigator.pop(context, 'cancel');
                                          });
                                          var kq = await cartapi.updateQuantity(
                                              cartapi.lstcart[index].accountid,
                                              cartapi.lstcart[index].productid,
                                              1);
                                          // ignore: unrelated_type_equality_checks
                                          if (kq == true &&
                                              cartapi.lstcart[index].status ==
                                                  1) {
                                            cartapi.add(cartapi.lstcart[index]);
                                          }
                                        },
                                        icon: const Icon(Icons.add)),
                                    Text('${cartapi.lstcart[index].quantity}'),
                                    IconButton(
                                        onPressed: () async {
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
                                                  milliseconds: 1500), () {
                                            Navigator.pop(context, 'cancel');
                                          });
                                          var kq = await cartapi.updateQuantity(
                                              cartapi.lstcart[index].accountid,
                                              cartapi.lstcart[index].productid,
                                              0);
                                          // print(kq);
                                          // print(cartapi.lstcart[index].status);
                                          if (kq == true &&
                                              cartapi.lstcart[index].status ==
                                                  1) {
                                            // print('deeleot');
                                            await cartapi
                                                .remove(cartapi.lstcart[index]);
                                          }
                                        },
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
        height: 65,
        child: Row(
          children: [
            Consumer<CartApi>(
              builder: (_, c, child) {
                return Row(
                  children: [
                    Checkbox(
                      value: cartapi.btnAll,
                      onChanged: (value) {
                        cartapi.selectAll((msg) {
                          print(msg);
                        }, cartapi.acctemp!.id);
                      },
                      shape: const CircleBorder(),
                    ),
                    const Text('Tất cả')
                  ],
                );
              },
            ),
            const SizedBox(
              width: 5,
            ),
            Consumer<CartApi>(
              builder: (_, cart, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text('Tổng cộng:'),
                        SizedBox(
                          width: 75,
                          child: Text(
                            NumberFormat.currency(locale: 'vi')
                                .format(cartapi.total),
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Text('Phí ship:'),
                        Text(
                          ' 25.000 VND',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            Consumer<CartApi>(builder: (_, c, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: GestureDetector(
                  onTap: () {
                    var content = const SnackBar(
                        content: Text('vui lòng chọn sản phẩm để thanh toán'));
                    cartapi.total <= 0
                        ? ScaffoldMessenger.of(context).showSnackBar(content)
                        : Navigator.pushNamed(context, 'checkout');
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
              );
            })
          ],
        ),
      ),
      // bottomNavigationBar: Consumer<ProductApi>(
      //   builder: (_, pro, child) {
      //     return SizedBox(
      //       height: 50,
      //       child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             GestureDetector(
      //               onTap: () {
      //                 apicart.resetAllStatusCart((msg) {
      //                   print(msg);
      //                 }, apicart.acctemp!.id);
      //                 apicart.resetTotal();
      //                 apicart.resetbtnAll();
      //                 pro.changeIndex(0);
      //                 Navigator.popAndPushNamed(context, 'home');
      //               },
      //               child: Column(children: [
      //                 pro.index == 0
      //                     ? const Icon(Icons.home_filled, color: Colors.red)
      //                     : const Icon(Icons.home_filled),
      //                 pro.index == 0
      //                     ? const Text('Trang Chủ',
      //                         style: TextStyle(color: Colors.red))
      //                     : const Text('Trang Chủ')
      //               ]),
      //             ),
      //             GestureDetector(
      //               onTap: () {
      //                 pro.changeIndex(1);
      //                 Navigator.pushNamed(context, 'wishlist');
      //               },
      //               child: Column(children: [
      //                 pro.index == 1
      //                     ? const Icon(Icons.favorite_border_outlined,
      //                         color: Colors.red)
      //                     : const Icon(Icons.favorite_border_outlined),
      //                 pro.index == 1
      //                     ? const Text('Yêu Thích',
      //                         style: TextStyle(color: Colors.red))
      //                     : const Text(
      //                         'Yêu Thích',
      //                       )
      //               ]),
      //             ),
      //             GestureDetector(
      //               onTap: () {
      //                 pro.changeIndex(2);
      //                 apicart.resetAllStatusCart((msg) {
      //                   print(msg);
      //                 }, apicart.acctemp!.id);
      //                 apicart.resetTotal();
      //                 apicart.resetbtnAll();
      //                 Navigator.popAndPushNamed(context, 'info');
      //               },
      //               child: Column(children: [
      //                 pro.index == 2
      //                     ? const Icon(Icons.manage_accounts_outlined,
      //                         color: Colors.red)
      //                     : const Icon(Icons.manage_accounts_outlined),
      //                 pro.index == 2
      //                     ? const Text('Tài Khoản',
      //                         style: TextStyle(color: Colors.red))
      //                     : const Text(
      //                         'Tài Khoản',
      //                       )
      //               ]),
      //             ),
      //           ]),
      //     );
      //   },
      // ),
    );
  }

  Future<dynamic> loadingDialog(BuildContext context) {
    return showDialog(
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
  }
}
