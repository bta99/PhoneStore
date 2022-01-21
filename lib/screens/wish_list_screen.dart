import 'package:ecommerce_shop/api/cart/cart_api.dart';
// import 'package:ecommerce_shop/api/product/color_prod.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:ecommerce_shop/api/slider/slider_api.dart';
import 'package:ecommerce_shop/api/wishlist/wish_list_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    var productapi = Provider.of<ProductApi>(context, listen: false);
    var slideapi = Provider.of<SliderApi>(context, listen: false);
    // var account = Provider.of<ApiAcc>(context, listen: false);
    var acc = Provider.of<CartApi>(context, listen: false);
    if (productapi.wishlist.isEmpty) {
      productapi.getWishList(acc.acctemp!.id);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text(
            'Danh sách yêu thích',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          leading: IconButton(
              onPressed: () {
                // productapi.changeIndex(0);
                Navigator.pop(context);
                // Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 17,
                color: Colors.black,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ))
          ]),
      body: Consumer<ProductApi>(
        builder: (_, w, child) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: List.generate(productapi.wishlist.length, (index) {
                return GestureDetector(
                  onTap: () async {
                    var itemPro;
                    for (var item in slideapi.lstcolor) {
                      if (item.id == productapi.wishlist[index].productid) {
                        itemPro = item;
                        print(item.name);
                      }
                    }
                    await productapi.changeItem(itemPro);
                    Navigator.pushNamed(
                      context,
                      'test',
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'http://192.168.1.6:8000${productapi.wishlist[index].image}',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 230,
                              child: Text(
                                productapi.wishlist[index].name,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              'Màu:${productapi.wishlist[index].color}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            productapi.wishlist[index].salesPrice <= 0
                                ? Text(
                                    NumberFormat.currency(locale: 'vi').format(
                                        productapi.wishlist[index].price),
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Row(
                                    children: [
                                      Text(
                                        NumberFormat.currency(locale: 'vi')
                                            .format(productapi
                                                .wishlist[index].salesPrice),
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        NumberFormat.currency(locale: 'vi')
                                            .format(productapi
                                                .wishlist[index].price),
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete_outlined))
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 45,
        child: ElevatedButton(
            onPressed: () {}, child: const Text('Xoá danh sách yêu thích')),
      ),
    );
  }
}
