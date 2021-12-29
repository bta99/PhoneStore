import 'package:ecommerce_shop/api/account/account_api.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    var $api = Provider.of<ProductApi>(context, listen: false);
    var acc = Provider.of<CartApi>(context, listen: false);
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
                              $api.searchProduct2((msg) {
                                print(msg);
                              }, search.text);
                            },
                            child: const Icon(
                              Icons.search,
                            )),
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(bottom: 15, left: 5)),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      show = !show;
                    });
                  },
                  icon: const Icon(Icons.filter_list, color: Colors.black))
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
                    ? const Text("")
                    : Column(
                        children: [
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Tìm Theo Loại',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await $api.searchProduct((msg) {
                                      print(msg);
                                    }, 4);
                                    // setState(() {});
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    width: 100,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.transparent,
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: const Center(
                                        child: Text('Điện Thoại',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ))),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await Provider.of<ProductApi>(context,
                                            listen: false)
                                        .searchProduct((msg) {
                                      print(msg);
                                    }, 5);
                                    // setState(() {});
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 100,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.transparent,
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: const Center(
                                        child: Text('LapTop',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ))),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await Provider.of<ProductApi>(context,
                                            listen: false)
                                        .searchProduct((msg) {
                                      print(msg);
                                    }, 0);
                                    print('hello');
                                    // setState(() {});
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.transparent,
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: const Center(
                                        child: Text('Tablet',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ))),
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
                      children: List.generate($api.products2.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            $api.changeItem($api.products2[index]);
                            Navigator.pushNamed(context, 'test',
                                arguments: $api.itemtemp);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            width: 160,
                            // height: 200,
                            color: Colors.white,
                            child: Column(
                              children: [
                                ClipRRect(
                                    // borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                        'http://192.168.1.6:8000${$api.products2[index].image}')),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text($api.products2[index].name),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('${$api.products2[index].price}'),
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