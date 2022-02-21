import 'package:ecommerce_shop/api/product/color_prod.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:ecommerce_shop/api/slider/slider_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductAllScreen extends StatefulWidget {
  const ProductAllScreen({Key? key}) : super(key: key);
  static String id = 'product_all';
  @override
  _ProductAllScreenState createState() => _ProductAllScreenState();
}

class _ProductAllScreenState extends State<ProductAllScreen> {
  @override
  Widget build(BuildContext context) {
    var slideapi = Provider.of<SliderApi>(context, listen: false);
    var productapi = Provider.of<ProductApi>(context, listen: false);
    TextEditingController search = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Tất cả sản phẩm',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              slideapi.resetLstsearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: Colors.black,
            )),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Container(
            height: 55,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 15, right: 15),
              child: TextField(
                controller: search,
                onChanged: (value) {
                  slideapi.search(search.text);
                },
                decoration: InputDecoration(
                  hintText: 'search here',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: Image.asset('images/search.png'),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  )),
                  contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<SliderApi>(
        builder: (_, value, child) {
          return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  children:
                      List.generate(slideapi.lstforsearch.length, (index) {
                    return GestureDetector(
                      onTap: () async {
                        await productapi
                            .changeItem(slideapi.lstforsearch[index]);
                        Navigator.pushNamed(
                          context,
                          'test',
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        width: 160,
                        // height: 270,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 5,
                            )
                          ],
                          borderRadius: BorderRadius.circular(5),
                          // border: Border.all(
                          //   color: Colors.black,
                          // ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Image.network(
                                    'http://192.168.1.4:8000${slideapi.lstforsearch[index].image}'),
                                slideapi.lstforsearch[index].salesprice > 0
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
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5),
                              child: Text(slideapi.lstforsearch[index].name),
                            ),
                            slideapi.lstforsearch[index].salesprice > 0
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 5),
                                        child: Text(
                                          NumberFormat.currency(locale: 'vi')
                                              .format(slideapi
                                                  .lstforsearch[index]
                                                  .salesprice),
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5),
                                          child: Text(
                                            NumberFormat.currency(locale: 'vi')
                                                .format(slideapi
                                                    .lstforsearch[index].price),
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ))
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5),
                                    child: Text(
                                      NumberFormat.currency(locale: 'vi')
                                          .format(slideapi
                                              .lstforsearch[index].price),
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ));
        },
      ),
    );
  }
}
