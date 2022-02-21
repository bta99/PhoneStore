import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:ecommerce_shop/api/slider/slider_api.dart';
import 'package:ecommerce_shop/screens/product_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var productapi = Provider.of<ProductApi>(context, listen: false);
    var slideapi = Provider.of<SliderApi>(context, listen: false);
    // var cateapi = Provider.of<CategoryApi>(context, listen: false);
    var accountapi = Provider.of<ApiAcc>(context, listen: false);
    if (slideapi.sliders.isEmpty) {
      slideapi.getSlider((msg) {
        print(msg);
      });
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text(
            // ignore: unnecessary_string_interpolations
            'Trang Chủ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'notification');
                  },
                  icon: const Icon(Icons.notifications, color: Colors.orange)),
              const Positioned(
                child: Icon(Icons.circle, color: Colors.green, size: 10),
                left: 25,
                top: 8,
              )
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'cart');
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Image.asset(
                  'images/shopping-cart.png',
                  width: 25,
                  height: 25,
                ),
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              // ignore: avoid_unnecessary_containers
              child: SizedBox(
                height: 40,
                child: TextField(
                  onTap: () {
                    Navigator.pushNamed(context, 'search');
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.redAccent, width: 1),
                          borderRadius: BorderRadius.circular(25)),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.redAccent, width: 1),
                          borderRadius: BorderRadius.circular(25)),
                      prefixIcon: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Tìm sản phẩm',
                            style: TextStyle(color: Colors.grey),
                          )),
                      suffixIcon:
                          // ignore: avoid_unnecessary_containers
                          Container(
                        width: 55,
                        margin:
                            const EdgeInsets.only(right: 3, top: 3, bottom: 3),
                        child: Image.asset(
                          'images/search.png',
                          width: 15,
                          height: 15,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(25)),
                      )),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Consumer<SliderApi>(
            builder: (_, value, child) {
              return Column(
                children: [
                  slideapi.sliders.isEmpty
                      ? SizedBox(
                          height: 150,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [CircularProgressIndicator()],
                            ),
                          ))
                      : CarouselSlider(
                          items:
                              List.generate(slideapi.sliders.length, (index) {
                            return Container(
                                color: Colors.transparent,
                                // height: 200,
                                child: Image.network(
                                    'http://192.168.1.4:8000${slideapi.sliders[index].image}'));
                          }),
                          options: CarouselOptions(
                            aspectRatio: 23 / 9,
                            autoPlay: true,
                            enableInfiniteScroll: true,
                            viewportFraction: 1,
                          )),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Danh mục sản phẩm',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  // color: Colors.redAccent,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.list_alt,
                              color: Colors.orangeAccent,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        slideapi.categories.isEmpty
                            ? SizedBox(
                                height: 100,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator()
                                    ],
                                  ),
                                ))
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                    slideapi.categories.length, (index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print(slideapi.categories[index].id);
                                          Navigator.pushNamed(
                                              context, 'products_by_type',
                                              arguments: slideapi
                                                  .categories[index].id);
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(2),
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                              style: BorderStyle.solid,
                                              color: Colors.white,
                                            )),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                    'http://192.168.1.4:8000${slideapi.categories[index].image}',
                                                    fit: BoxFit.cover))),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        slideapi.categories[index].productType,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  );
                                })),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Sales',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.black),
                                  ),
                                  // Icon(Icons.bolt, color: Colors.orangeAccent)
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    'images/flash-sale.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ],
                              ),
                              Row(children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Text('xem thêm',
                                        style: TextStyle(color: Colors.black))),
                                const Icon(Icons.keyboard_arrow_down_outlined)
                              ])
                            ]),
                      ),
                      // ignore: sized_box_for_whitespace
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        height: 260,
                        child: slideapi.lstsales.isEmpty
                            ? SizedBox(
                                // height: 200,
                                child: Center(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                      CircularProgressIndicator()
                                    ])),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  children: List.generate(
                                      slideapi.lstsales.length, (index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        await productapi.changeItem(
                                            slideapi.lstsales[index]);
                                        Navigator.pushNamed(
                                          context,
                                          'test',
                                        );
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: 10,
                                              bottom: 10),
                                          // height: 200,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  blurRadius: 5,
                                                  spreadRadius: 5,
                                                )
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.transparent,
                                                  style: BorderStyle.solid,
                                                  width: 2)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Stack(
                                                children: [
                                                  Image.network(
                                                      'http://192.168.1.4:8000${slideapi.lstsales[index].image}'),
                                                  Positioned(
                                                    right: 5,
                                                    child: Image.asset(
                                                      'images/sale.png',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15, right: 10),
                                                child: Text(
                                                    slideapi.lstsales[index]
                                                            .name +
                                                        ' ' +
                                                        slideapi.lstsales[index]
                                                            .color,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              const SizedBox(height: 5),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Column(children: [
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'vi')
                                                        .format(slideapi
                                                            .lstsales[index]
                                                            .salesprice),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'vi')
                                                        .format(slideapi
                                                            .lstsales[index]
                                                            .price),
                                                    style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ],
                                          )),
                                    );
                                  }),
                                ),
                              ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Danh sách sản phẩm',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                  Image.asset(
                                    'images/smartphone.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ],
                              ),
                              Row(children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, ProductAllScreen.id);
                                    },
                                    child: const Text('xem thêm',
                                        style: TextStyle(color: Colors.black))),
                                const Icon(Icons.keyboard_arrow_down_outlined)
                              ])
                            ]),
                      ),
                      // ignore: sized_box_for_whitespace
                      Container(
                        decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        height: 250,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: List.generate(slideapi.lstcolor.length,
                                (index) {
                              return GestureDetector(
                                onTap: () async {
                                  await productapi
                                      .changeItem(slideapi.lstcolor[index]);
                                  Navigator.pushNamed(
                                    context,
                                    'test',
                                  );
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, top: 10, bottom: 10),
                                    height: 250,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 5,
                                            spreadRadius: 5,
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.transparent,
                                            style: BorderStyle.solid,
                                            width: 2)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            Image.network(
                                                'http://192.168.1.4:8000${slideapi.lstcolor[index].image}'),
                                            slideapi.lstcolor[index]
                                                        .salesprice >
                                                    0
                                                ? Positioned(
                                                    right: 5,
                                                    child: Image.asset(
                                                      'images/sale.png',
                                                      width: 30,
                                                      height: 30,
                                                    ))
                                                : Container()
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 10),
                                          child: Text(
                                              slideapi.lstcolor[index].name +
                                                  ' ' +
                                                  slideapi
                                                      .lstcolor[index].color,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        const SizedBox(height: 5),
                                        slideapi.lstcolor[index].salesprice == 0
                                            ? Text(
                                                NumberFormat.currency(
                                                        locale: 'vi')
                                                    .format(slideapi
                                                        .lstcolor[index].price),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                  fontSize: 13,
                                                ),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Column(children: [
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'vi')
                                                        .format(slideapi
                                                            .lstcolor[index]
                                                            .salesprice),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'vi')
                                                        .format(slideapi
                                                            .lstcolor[index]
                                                            .price),
                                                    style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ]),
                                              )
                                      ],
                                    )),
                              );
                            }),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: Consumer<ProductApi>(
          builder: (_, pro, child) {
            return SizedBox(
              height: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        productapi.changeIndex(0);
                        Navigator.popAndPushNamed(context, 'home');
                      },
                      child: Column(children: [
                        productapi.index == 0
                            ? Image.asset('images/active_home.png')
                            : Image.asset('images/home.png'),
                        productapi.index == 0
                            ? const Text('Trang Chủ',
                                style: TextStyle(color: Colors.orange))
                            : const Text('Trang Chủ')
                      ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        // productapi.changeIndex(1);
                        Navigator.pushNamed(context, 'wishlist');
                      },
                      child: Column(children: [
                        productapi.index == 1
                            ? Image.asset('images/like.png')
                            : Image.asset('images/love.png'),
                        productapi.index == 1
                            ? const Text('Yêu Thích',
                                style: TextStyle(color: Colors.red))
                            : const Text(
                                'Yêu Thích',
                              )
                      ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        productapi.changeIndex(2);
                        Navigator.pushNamed(context, 'info');
                      },
                      child: Column(children: [
                        productapi.index == 2
                            ? Image.asset('images/user.png')
                            : Image.asset('images/account.png'),
                        productapi.index == 2
                            ? const Text('Tài Khoản',
                                style: TextStyle(color: Colors.red))
                            : const Text(
                                'Tài Khoản',
                              )
                      ]),
                    ),
                  ]),
            );
          },
        ));
  }
}
