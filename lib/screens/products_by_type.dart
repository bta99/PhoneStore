import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProductsByType extends StatefulWidget {
  const ProductsByType({Key? key}) : super(key: key);

  @override
  _ProductsByTypeState createState() => _ProductsByTypeState();
}

class _ProductsByTypeState extends State<ProductsByType> {
  @override
  Widget build(BuildContext context) {
    var productapi = Provider.of<ProductApi>(context, listen: false);
    var cateId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            'Sản phẩm theo danh mục',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              //bộ lọc tăng giảm theo giá,sales
              SizedBox(
                height: 30,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: () {
                          productapi.searchProduct((msg) {
                            print(msg);
                          }, cateId, "increase");
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Center(
                              child: Row(
                            children: const [
                              Text('Giá tăng dần'),
                              Icon(Icons.arrow_drop_up),
                            ],
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: () {
                          productapi.searchProduct((msg) {
                            print(msg);
                          }, cateId, "diminish");
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Center(
                              child: Row(
                            children: const [
                              Text('Giá giảm dần'),
                              Icon(Icons.arrow_drop_down),
                            ],
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: () {
                          productapi.searchProduct((msg) {
                            print(msg);
                          }, cateId, "sales");
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Center(
                              child: Row(
                            children: const [
                              Text('Giảm giá'),
                              Icon(Icons.price_change_outlined),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // danh sách sản phẩm theo danh mục
              FutureBuilder(
                future: productapi.searchProduct((msg) {
                  print(msg);
                }, cateId, ""),
                builder: (_, AsyncSnapshot snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Consumer<ProductApi>(
                      builder: (_, pro, child) {
                        return Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          direction: Axis.horizontal,
                          children: List.generate(productapi.products2.length,
                              (index) {
                            return GestureDetector(
                              onTap: () {
                                productapi
                                    .changeItem(productapi.products2[index]);
                                // print($api2.itemtemp?.id);
                                Navigator.pushNamed(
                                  context,
                                  'test',
                                );
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                // height: 200,
                                width: 160,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 5,
                                      spreadRadius: 5,
                                    )
                                  ],
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                          'http://192.168.1.6:8000${productapi.products2[index].image}'),
                                    ),
                                    SizedBox(
                                      width: 110,
                                      child: Text(
                                        productapi.products2[index].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    productapi.products2[index].salesprice <= 0
                                        ? SizedBox(
                                            width: 110,
                                            child: Text(
                                              NumberFormat.currency(
                                                      locale: 'vi')
                                                  .format(productapi
                                                      .products2[index].price),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: 13,
                                              ),
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              SizedBox(
                                                width: 110,
                                                child: Text(
                                                  NumberFormat.currency(
                                                          locale: 'vi')
                                                      .format(productapi
                                                          .products2[index]
                                                          .salesprice),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 110,
                                                child: Text(
                                                  NumberFormat.currency(
                                                          locale: 'vi')
                                                      .format(productapi
                                                          .products2[index]
                                                          .price),
                                                  style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontWeight: FontWeight.bold,
                                                    // color: Colors.red,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
