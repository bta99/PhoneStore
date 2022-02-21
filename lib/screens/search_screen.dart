import 'package:ecommerce_shop/api/account/account_api.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/api/product/color_prod.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:ecommerce_shop/api/slider/slider_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../api/product/product_api.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool show = true;

  @override
  Widget build(BuildContext context) {
    var productapi = Provider.of<ProductApi>(context, listen: false);
    var slideapi = Provider.of<SliderApi>(context, listen: false);
    TextEditingController search = TextEditingController();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
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
                controller: search,
                onTap: () {},
                onChanged: (value) {
                  List<Colorpro> lst = [];
                  for (var item in slideapi.lstcolor) {
                    if (item.name
                        .toLowerCase()
                        .contains(search.text.toLowerCase())) {
                      lst.add(item);
                    }
                  }
                  productapi.changeSearchProduct(lst);
                },
                decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding:
                          const EdgeInsets.only(top: 2, right: 2, bottom: 2),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.red),
                        width: 20,
                        child: GestureDetector(
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

                              Future.delayed(const Duration(milliseconds: 1500),
                                  () {
                                Navigator.pop(context, 'cancel');
                              });
                              productapi.searchProduct2((msg) {
                                print(msg);
                              }, search.text);
                            },
                            child: Image.asset('images/search.png')),
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: 'search here',
                    contentPadding: const EdgeInsets.only(bottom: 11, left: 5)),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    show = !show;
                    print(show);
                  });
                },
                child: Image.asset('images/filter.png'),
              )
            ],
            leading: IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, 'home');
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black))),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                show
                    ? Container()
                    : Column(
                        children: [
                          // Row(
                          //   children: const [
                          //     Padding(
                          //       padding: EdgeInsets.only(left: 10.0),
                          //       child: Text(
                          //         'Tìm Theo Loại',
                          //         style: TextStyle(
                          //             color: Colors.black,
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 15),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: 60,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                GestureDetector(
                                  onTap: () async {
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
                                    await productapi.searchProduct((msg) {
                                      print(msg);
                                    }, 4, "");
                                    // setState(() {});
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                          'images/smartphone.png',
                                          width: 40,
                                          height: 40),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
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
                                        const Duration(milliseconds: 1000), () {
                                      Navigator.pop(context, 'cancel');
                                    });
                                    await Provider.of<ProductApi>(context,
                                            listen: false)
                                        .searchProduct((msg) {
                                      print(msg);
                                    }, 5, "");
                                    // setState(() {});
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Center(
                                      child: Image.asset('images/laptop.png',
                                          width: 40, height: 40),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
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
                                        const Duration(milliseconds: 1000), () {
                                      Navigator.pop(context, 'cancel');
                                    });
                                    await Provider.of<ProductApi>(context,
                                            listen: false)
                                        .searchProduct((msg) {
                                      print(msg);
                                    }, 0, "");
                                    print('hello');
                                    // setState(() {});
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Center(
                                      child: Image.asset('images/tablet.png',
                                          width: 40, height: 40),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Divider(
                    height: 5,
                    indent: 5,
                    color: Colors.black,
                  ),
                ),
                // ignore: unnecessary_string_interpolations
                Consumer<ProductApi>(
                  builder: (_, pro, child) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          List.generate(productapi.products2.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            productapi.changeItem(productapi.products2[index]);
                            Navigator.pushNamed(
                              context,
                              'test',
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            width: 160,
                            // height: 200,
                            // color: Colors.white,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 5,
                                    spreadRadius: 5,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 1.5,
                                )),
                            child: Column(
                              children: [
                                ClipRRect(
                                    // borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                        'http://192.168.1.4:8000${productapi.products2[index].image}')),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 5.0,
                                      left: 15,
                                      right: 10),
                                  child: Text(
                                    productapi.products2[index].name,
                                  ),
                                ),
                                productapi.products2[index].salesprice <= 0
                                    ? Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                            NumberFormat.currency(locale: 'vi')
                                                .format(productapi
                                                    .products2[index].price),
                                            style: const TextStyle(
                                                color: Colors.red)),
                                      )
                                    : Column(
                                        children: [
                                          Text(
                                              NumberFormat.currency(
                                                      locale: 'vi')
                                                  .format(productapi
                                                      .products2[index]
                                                      .salesprice),
                                              style: const TextStyle(
                                                  color: Colors.red)),
                                          Text(
                                              NumberFormat.currency(
                                                      locale: 'vi')
                                                  .format(productapi
                                                      .products2[index].price),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              )),
                                        ],
                                      )
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                )
              ],
            )));
  }
}
