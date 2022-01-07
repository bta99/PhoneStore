import 'package:ecommerce_shop/api/order/order_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckBoxScreen extends StatefulWidget {
  const CheckBoxScreen({Key? key}) : super(key: key);

  @override
  _CheckBoxScreenState createState() => _CheckBoxScreenState();
}

class _CheckBoxScreenState extends State<CheckBoxScreen> {
  @override
  Widget build(BuildContext context) {
    var rating = Provider.of<OrderApi>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('rating demo'),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1641287991660-2769da8d79cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
                            fit: BoxFit.fill,
                          ))),
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
                                builder: (_, order, child) {
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
                                              rating.changeVal(value);
                                            },
                                            title: Row(
                                              children:
                                                  List.generate(5, (index) {
                                                return const Icon(
                                                  Icons.star,
                                                  color: Colors.orangeAccent,
                                                  size: 20,
                                                );
                                              }),
                                            ),
                                            groupValue: rating.val,
                                          ),
                                          RadioListTile(
                                            value: 4,
                                            onChanged: (value) {
                                              rating.changeVal(value);
                                            },
                                            title: Row(
                                              children:
                                                  List.generate(4, (index) {
                                                return const Icon(
                                                  Icons.star,
                                                  color: Colors.orangeAccent,
                                                  size: 20,
                                                );
                                              }),
                                            ),
                                            groupValue: rating.val,
                                          ),
                                          RadioListTile(
                                            value: 3,
                                            onChanged: (value) {
                                              rating.changeVal(value);
                                            },
                                            title: Row(
                                              children:
                                                  List.generate(3, (index) {
                                                return const Icon(
                                                  Icons.star,
                                                  color: Colors.orangeAccent,
                                                  size: 20,
                                                );
                                              }),
                                            ),
                                            groupValue: rating.val,
                                          ),
                                          RadioListTile(
                                            value: 2,
                                            onChanged: (value) {
                                              rating.changeVal(value);
                                            },
                                            title: Row(
                                              children:
                                                  List.generate(2, (index) {
                                                return const Icon(
                                                  Icons.star,
                                                  color: Colors.orangeAccent,
                                                  size: 20,
                                                );
                                              }),
                                            ),
                                            groupValue: rating.val,
                                          ),
                                          RadioListTile(
                                            value: 1,
                                            onChanged: (value) {
                                              rating.changeVal(value);
                                            },
                                            title: Row(
                                              children:
                                                  List.generate(1, (index) {
                                                return const Icon(
                                                  Icons.star,
                                                  color: Colors.orangeAccent,
                                                  size: 20,
                                                );
                                              }),
                                            ),
                                            groupValue: rating.val,
                                          ),
                                          const TextField(
                                            decoration: InputDecoration(
                                                hintText: 'bình luận',
                                                border: UnderlineInputBorder()),
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      Center(
                                        child: ElevatedButton(
                                            onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
