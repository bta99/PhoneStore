import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_shop/api/account/account_api.dart';
import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/api/category/category_api.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:ecommerce_shop/api/slider/slider_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var acc = Provider.of<CartApi>(context, listen: false);
    var $api2 = Provider.of<ProductApi>(context, listen: false);
    var $slide = Provider.of<SliderApi>(context, listen: false);
    var $cate = Provider.of<CategoryApi>(context, listen: false);
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
                  // print(arg.address);
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
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'cart');
              },
              icon: const Icon(Icons.shopping_bag_sharp, color: Colors.black))
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
                        borderSide:
                            const BorderSide(color: Colors.redAccent, width: 1),
                        borderRadius: BorderRadius.circular(25)),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.redAccent, width: 1),
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
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search, color: Colors.white)),
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
        child: Column(
          children: [
            FutureBuilder(future: $slide.getSlider((msg) {
              print(msg);
            }), builder: (_, AsyncSnapshot snapshot) {
              return CarouselSlider(
                  items: List.generate($slide.sliders.length, (index) {
                    return Container(
                        color: Colors.transparent,
                        // height: 200,
                        child: Image.network(
                            'http://192.168.1.6:8000${$slide.sliders[index].image}'));
                  }),
                  options: CarouselOptions(
                    aspectRatio: 22 / 9,
                    autoPlay: true,
                    enableInfiniteScroll: true,
                    viewportFraction: 1,
                  ));
            }),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Danh Mục Sản Phẩm',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.redAccent),
                        ),
                      ),
                      Icon(Icons.category_rounded, color: Colors.orangeAccent)
                    ],
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: $cate.getCategory((msg) {
                      print(msg);
                    }),
                    builder: (_, AsyncSnapshot snapshot) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:
                              List.generate($cate.categories.length, (index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
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
                                              'http://192.168.1.6:8000${$cate.categories[index].image}',
                                              fit: BoxFit.cover))),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  $cate.categories[index].productType,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            );
                          }));
                    },
                  )
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
                          children: const [
                            Text(
                              'Sales',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black),
                            ),
                            Icon(Icons.bolt, color: Colors.orangeAccent)
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: List.generate(10, (index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              height: 200,
                              width: 130,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    style: BorderStyle.solid, width: 2),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                      'https://cdn.tgdd.vn/Products/Images/42/230529/iphone-13-pro-max-sierra-blue-600x600.jpg'),
                                  const Text(
                                    'IPHONE 13',
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    '25.000.000đ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  )
                                ],
                              )),
                        ],
                      );
                    }),
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
                          children: const [
                            Text(
                              'Danh sách sản phẩm',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            Icon(Icons.phone_iphone_outlined,
                                color: Colors.orangeAccent)
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
                  decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  height: 240,
                  child: FutureBuilder(
                    future: $api2.getProduct((msg) {
                      print(msg);
                    }),
                    builder: (_, AsyncSnapshot snapshot) {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: List.generate($api2.lstcolor.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              $api2.changeItem($api2.lstcolor[index]);
                              // print($api2.itemtemp?.id);
                              Navigator.pushNamed(context, 'test',
                                  arguments: $api2.itemtemp);
                            },
                            child: Container(
                                margin: const EdgeInsets.only(
                                    left: 5, right: 5, top: 10, bottom: 10),
                                height: 200,
                                width: 130,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        style: BorderStyle.solid, width: 2)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                        'http://192.168.1.6:8000${$api2.lstcolor[index].image}'),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 10),
                                      child: Text(
                                        $api2.lstcolor[index].name +
                                            ' ' +
                                            $api2.lstcolor[index].color,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      $api2.lstcolor[index].price.toString() +
                                          "\$",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    )
                                  ],
                                )),
                          );
                        }),
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.redAccent,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: 'Trang Chủ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: 'Yêu Thích'),
          BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts), label: 'Tài Khoản'),
        ],
      ),
    );
  }
}
