import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/api/order/order_api.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:ecommerce_shop/api/wishlist/wish_list_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);
  static String id = 'test';
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    var cartapi = Provider.of<CartApi>(context, listen: false);
    // final productid = ModalRoute.of(context)?.settings.arguments as int;
    var account = Provider.of<ApiAcc>(context, listen: false);
    var apicart = Provider.of<CartApi>(context, listen: false);
    var productapi = Provider.of<ProductApi>(context, listen: false);
    var order = Provider.of<OrderApi>(context, listen: false);
    var rating = Provider.of<OrderApi>(context, listen: false);
    var wishlistapi = Provider.of<WishListApi>(context, listen: false);
    productapi.getProductId((msg) {
      print(msg);
    }, productapi.itemtemp.productid, account.info!.id, productapi.itemtemp.id);
    // order.getComment(productapi.itemtemp.productid, );
    // Future<void> callproduct() async {
    //   wishlistapi.checkWishList(account.info!.id, productapi.itemtemp!.productid);
    // }
    return Scaffold(
      appBar: appbarDetailPage(context, productapi, wishlistapi, account),
      body: productapi.itemtemp.name == ""
          ? null
          : SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Center(
                child: Column(
                  children: [
                    Column(children: [
                      Consumer<ProductApi>(
                        builder: (_, pro, child) {
                          return productapi.prod.isEmpty
                              ? const CircularProgressIndicator()
                              : CarouselSlider.builder(
                                  itemCount: productapi.prod.length,
                                  itemBuilder: (context, index, index2) {
                                    return Container(
                                      // width: 250,
                                      color: Colors.transparent,
                                      child: Image.network(
                                          'http://192.168.1.4:8000${productapi.prod[index].image}'),
                                    );
                                  },
                                  options: CarouselOptions(
                                      // initialPage: productapi.currentIndex,
                                      aspectRatio: 16 / 9,
                                      autoPlay: true,
                                      enableInfiniteScroll: true,
                                      viewportFraction: 0.9));
                        },
                      ),
                      Consumer<ProductApi>(builder: (_, pro, child) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Divider(
                            height: 5,
                            color: Colors.black,
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<ProductApi>(builder: (_, pro, child) {
                              return productapi.itemtemp.salesprice == 0
                                  ? Text(
                                      NumberFormat.currency(locale: 'vi')
                                          .format(productapi.itemtemp.price),
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          NumberFormat.currency(locale: 'vi')
                                              .format(productapi
                                                  .itemtemp.salesprice),
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          NumberFormat.currency(locale: 'vi')
                                              .format(
                                                  productapi.itemtemp.price),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            // fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 15,
                                          ),
                                        )
                                      ],
                                    );
                            }),
                            Consumer<ProductApi>(
                              builder: (_, value, child) {
                                return IconButton(
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
                                          const Duration(milliseconds: 1500),
                                          () {
                                        Navigator.pop(context, 'cancel');
                                      });
                                      await productapi.addWishList(
                                          account.info!.id,
                                          productapi.itemtemp.id);
                                    },
                                    icon: productapi.check2 == false
                                        ? const Icon(
                                            Icons.favorite_border_outlined)
                                        : const Icon(Icons.favorite,
                                            color: Colors.pink));
                              },
                            )
                          ],
                        ),
                      ),
                      Consumer<ProductApi>(
                        builder: (_, pro, child) {
                          return productapi.itemtemp.stock == 0
                              ? Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Container(
                                        height: 30,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border:
                                                Border.all(color: Colors.red)),
                                        child: const Center(
                                            child: Text(
                                          'Tạm hết hàng!',
                                          style: TextStyle(color: Colors.red),
                                        )),
                                      ),
                                    ),
                                  ],
                                )
                              : Container();
                        },
                      ),
                      Consumer<ProductApi>(
                        builder: (_, pro, child) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${productapi.itemtemp.name} ${productapi.itemtemp.color}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Đánh Giá',
                                style: TextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                )),
                            Row(
                              children: [
                                const Text('4.5/5'),
                                Row(
                                    children: List.generate(5, (index) {
                                  return const Icon(Icons.star,
                                      color: Colors.orangeAccent, size: 12);
                                })),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: const [
                            Text('Cấu Hình',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Consumer<ProductApi>(
                        builder: (_, pro, child) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20, bottom: 10),
                            child: Table(
                              border: TableBorder.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1),
                              children: [
                                TableRow(children: [
                                  Column(children: const [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('RAM',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ]),
                                  Column(children: const [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('ROM',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ]),
                                  Column(children: const [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('camera',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ]),
                                  Column(children: const [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('PIN',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ]),
                                ]),
                                TableRow(children: [
                                  Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                          productapi.itemtemp.ram.toString() +
                                              'GB'),
                                    )
                                  ]),
                                  Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                          productapi.itemtemp.rom.toString() +
                                              'GB'),
                                    )
                                  ]),
                                  Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(productapi.itemtemp.camera
                                              .toString() +
                                          'MP'),
                                    )
                                  ]),
                                  Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                          productapi.itemtemp.pin.toString() +
                                              'MAH'),
                                    )
                                  ]),
                                ]),
                              ],
                            ),
                          );
                        },
                      ),
                    ]),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text('Lựa Chọn',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                        Icon(Icons.keyboard_arrow_down_sharp),
                      ],
                    ),
                    Consumer<ProductApi>(
                      builder: (_, pro, child) {
                        return SizedBox(
                            child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              List.generate(productapi.prod.length, (index) {
                            return GestureDetector(
                              onTap: () {
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
                                productapi.change(index);
                                productapi.changeItem(productapi.prod[index]);
                                productapi.getProductId((msg) {
                                  print(msg);
                                }, productapi.itemtemp.productid,
                                    account.info!.id, productapi.itemtemp.id);
                                // print(productapi.prod[index].color);
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10.0, bottom: 10),
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            border: Border.all(
                                                style: BorderStyle.solid,
                                                color: productapi.itemtemp.id ==
                                                        productapi
                                                            .prod[index].id
                                                    ? Colors.orange
                                                    : Colors.blue,
                                                width: 1)),
                                        child: ClipRRect(
                                            child: Image.network(
                                                'http://192.168.1.4:8000${productapi.prod[index].image}',
                                                fit: BoxFit.cover))),
                                  ),
                                  Text(
                                    productapi.prod[index].color,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            );
                          }),
                        ));
                      },
                    ),
                    Consumer<ProductApi>(
                      builder: (_, pro, child) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 20, right: 20),
                              child: Row(
                                children: const [
                                  Text('Mô Tả',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 20,
                                      right: 20,
                                      bottom: 20),
                                  child: Text(productapi.itemtemp.info),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                    const Divider(height: 10, color: Colors.grey),
                    lstComment(
                      order: order,
                      productapi: productapi,
                      acc: cartapi,
                      account: account,
                      rating: rating,
                      productid: productapi.itemtemp.productid,
                    )
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        color: Colors.amber[100],
        height: 50,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 20, right: 20, top: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            // SizedBox(
            //     width: 150,
            //     child: ElevatedButton(
            //         onPressed: () {
            //           print(productapi.prod);
            //         },
            //         child: const Text('Buy Now'))),
            Consumer<CartApi>(
              builder: (_, cart, child) {
                return SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () async {
                        await apicart.addCart((msg) {
                          print(msg);
                        }, productapi.itemtemp.id, 1, cartapi.acctemp!.id);
                        // apicart.getCart((msg) {
                        //   print(msg);
                        // }, account.info!.id);
                        var content =
                            SnackBar(content: Text(apicart.kq.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(content);
                      },
                      child: const Text('Thêm vào giỏ hàng'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blueAccent)),
                    ));
              },
            ),
          ]),
        ),
      ),
    );
  }

  AppBar appbarDetailPage(BuildContext context, ProductApi productapi,
      WishListApi wishListApi, ApiAcc accountapi) {
    return AppBar(
      title: Container(
        width: 200,
        height: 35,
        // margin: EdgeInsets.only(top: 20, bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: const Border(
              top: BorderSide(color: Colors.red),
              right: BorderSide(color: Colors.red),
              bottom: BorderSide(color: Colors.red),
              left: BorderSide(color: Colors.red),
            )),
        child: TextField(
          readOnly: true,
          onTap: () {
            Navigator.pushNamed(context, 'search');
          },
          decoration: InputDecoration(
              hintText: 'search here',
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 2, right: 2, bottom: 2),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.red),
                  width: 20,
                  child:
                      GestureDetector(child: Image.asset('images/search.png')),
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(bottom: 12, left: 5)),
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      actions: [
        Consumer<CartApi>(
          builder: (_, pro, child) {
            return Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'cart');
                    },
                    icon: const Icon(Icons.shopping_bag, color: Colors.black)),
                Consumer<CartApi>(
                  builder: (_, c, child) {
                    return Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.green),
                          child: Center(
                              child: Text(pro.lstcart.length.toString())),
                        ));
                  },
                )
              ],
            );
          },
        )
      ],
      leading: IconButton(
          onPressed: () {
            productapi.changePrice(0);
            productapi.changeIndex(0);
            // productapi.resetItemtemp();
            // productapi.getWishList(accountapi.info!.id);
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      backgroundColor: Colors.transparent,
    );
  }
}

class lstComment extends StatelessWidget {
  const lstComment({
    Key? key,
    required this.order,
    required this.productapi,
    required this.acc,
    required this.account,
    required this.rating,
    required this.productid,
  }) : super(key: key);

  final OrderApi order;
  final ProductApi productapi;
  final CartApi acc;
  final ApiAcc account;
  final OrderApi rating;
  final int productid;

  @override
  Widget build(BuildContext context) {
    TextEditingController contentComment = TextEditingController();
    return Consumer<ProductApi>(
      builder: (_, pro, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              productapi.check == false
                  ? const Text('không được phép đánh giá sẩn phẩm này')
                  : Container(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          account.info!.image == ""
                              ? const Icon(Icons.account_circle,
                                  size: 45, color: Colors.blue)
                              : account.tmpfile == ''
                                  ? Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.lightBlue),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.network(
                                                'http://192.168.1.4:8000/${acc.acctemp!.image}',
                                                fit: BoxFit.fill),
                                          )),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.lightBlue)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.file(
                                              File(account.tmpfile),
                                              fit: BoxFit.fill,
                                            ),
                                          )),
                                    ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              readOnly: true,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return Consumer<OrderApi>(
                                        builder: (_, value, child) {
                                          return AlertDialog(
                                            title: const Center(
                                              child: Text(
                                                'Đánh giá và nhận xét',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            ),
                                            content: SizedBox(
                                              height: 330,
                                              child: ListView(
                                                children: [
                                                  RadioListTile(
                                                    value: 5,
                                                    onChanged: (value) {
                                                      order.changeVal(value);
                                                    },
                                                    title: Row(
                                                      children: List.generate(5,
                                                          (index) {
                                                        return const Icon(
                                                          Icons.star,
                                                          color: Colors
                                                              .orangeAccent,
                                                          size: 20,
                                                        );
                                                      }),
                                                    ),
                                                    groupValue: order.val,
                                                  ),
                                                  RadioListTile(
                                                    value: 4,
                                                    onChanged: (value) {
                                                      order.changeVal(value);
                                                    },
                                                    title: Row(
                                                      children: List.generate(4,
                                                          (index) {
                                                        return const Icon(
                                                          Icons.star,
                                                          color: Colors
                                                              .orangeAccent,
                                                          size: 20,
                                                        );
                                                      }),
                                                    ),
                                                    groupValue: order.val,
                                                  ),
                                                  RadioListTile(
                                                    value: 3,
                                                    onChanged: (value) {
                                                      order.changeVal(value);
                                                    },
                                                    title: Row(
                                                      children: List.generate(3,
                                                          (index) {
                                                        return const Icon(
                                                          Icons.star,
                                                          color: Colors
                                                              .orangeAccent,
                                                          size: 20,
                                                        );
                                                      }),
                                                    ),
                                                    groupValue: order.val,
                                                  ),
                                                  RadioListTile(
                                                    value: 2,
                                                    onChanged: (value) {
                                                      order.changeVal(value);
                                                    },
                                                    title: Row(
                                                      children: List.generate(2,
                                                          (index) {
                                                        return const Icon(
                                                          Icons.star,
                                                          color: Colors
                                                              .orangeAccent,
                                                          size: 20,
                                                        );
                                                      }),
                                                    ),
                                                    groupValue: order.val,
                                                  ),
                                                  RadioListTile(
                                                    value: 1,
                                                    onChanged: (value) {
                                                      order.changeVal(value);
                                                    },
                                                    title: Row(
                                                      children: List.generate(1,
                                                          (index) {
                                                        return const Icon(
                                                          Icons.star,
                                                          color: Colors
                                                              .orangeAccent,
                                                          size: 20,
                                                        );
                                                      }),
                                                    ),
                                                    groupValue: order.val,
                                                  ),
                                                  TextField(
                                                    controller: contentComment,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'bình luận',
                                                            border:
                                                                UnderlineInputBorder()),
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              Center(
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (order.val == 0 ||
                                                          contentComment.text ==
                                                              "") {
                                                        var content =
                                                            const SnackBar(
                                                                content: Text(
                                                                    'vui lòng nhập đánh giá'));
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                content);
                                                      } else {
                                                        await productapi
                                                            .addComment(
                                                                acc.acctemp!.id,
                                                                productapi
                                                                    .itemtemp
                                                                    .productid,
                                                                order.val,
                                                                contentComment
                                                                    .text);
                                                        // order.getComment(
                                                        //     productapi.itemtemp
                                                        //         .productid,
                                                        //     acc.acctemp!.id);

                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    1000), () {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                        });
                                                      }
                                                    },
                                                    child: const Text('Lưu')),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    });
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'đánh giá sản phẩm.....',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Đánh Giá',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        const Text('Tất cả đánh giá'),
                        IconButton(
                            onPressed: () {},
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined))
                      ],
                    )
                  ],
                ),
              ),
              //List Comment
              productapi.lstComments.isEmpty
                  ? const Center(
                      child: Text('sản phẩm chưa có đánh giá'),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: List.generate(productapi.lstComments.length,
                            (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: account.info!.id !=
                                            productapi
                                                .lstComments[index].accountid
                                        ? Image.network(
                                            'http://192.168.1.4:8000/${productapi.lstComments[index].image}',
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          )
                                        : account.info!.image == ""
                                            ? const Icon(Icons.account_circle,
                                                size: 45, color: Colors.blue)
                                            : account.tmpfile == ''
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              width: 2,
                                                              color: Colors
                                                                  .lightBlue),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          child: Image.network(
                                                              'http://192.168.1.4:8000/${account.info!.image}',
                                                              fit: BoxFit.fill),
                                                        )),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                width: 2,
                                                                color: Colors
                                                                    .lightBlue)),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          child: Image.file(
                                                            File(account
                                                                .tmpfile),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        )),
                                                  ),
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                              productapi
                                                  .lstComments[index].fullname,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                              children: List.generate(
                                                  productapi.lstComments[index]
                                                      .rating, (index) {
                                            return const Icon(Icons.star,
                                                color: Colors.orangeAccent,
                                                size: 12);
                                          })),
                                        )
                                      ]),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 55),
                                child:
                                    Text(productapi.lstComments[index].content),
                              )
                            ],
                          );
                        }),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
