import 'dart:io';
import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
// import 'package:ecommerce_shop/provider/account_provider/loginprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  static String id = 'info';
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController nameCTL = TextEditingController();
  TextEditingController phoneCTL = TextEditingController();
  TextEditingController addressCTL = TextEditingController();
  TextEditingController oldpassCTL = TextEditingController();
  TextEditingController newpassCTL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var productapi = Provider.of<ProductApi>(context, listen: false);
    var accountapi = Provider.of<ApiAcc>(context, listen: false);
    var cartapi = Provider.of<CartApi>(context, listen: false);
    if (accountapi.info == null) {
      accountapi.getInfoAcc((msg) {
        print(msg);
      }, cartapi.acctemp!.id);
    }
    return Scaffold(
      body: accountapi.info == null
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator()],
            ))
          : Consumer<ApiAcc>(
              builder: (_, acc, child) {
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      AppBar(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        leading: GestureDetector(
                            onTap: () {
                              // print(acc.info!.image);
                              acc.imagePath = "";
                              Navigator.pushNamed(context, 'upload',
                                  arguments: cartapi.acctemp!.id);
                            },
                            child: acc.info?.image == null ||
                                    acc.info?.image == ""
                                ? const Icon(Icons.account_circle,
                                    size: 45, color: Colors.blue)
                                : acc.tmpfile == ''
                                    ? Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                            height: 30,
                                            width: 30,
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
                                                  'http://192.168.1.4:8000/${acc.info!.image}',
                                                  fit: BoxFit.fill),
                                            )),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.lightBlue)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.file(
                                                File(acc.tmpfile),
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                      )),
                        title: acc.info != null
                            ? Text(acc.info!.fullname,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold))
                            : null,
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                      title: const Text(
                                          'Chỉnh sửa Thông Tin Tài Khoản',
                                          style: TextStyle(fontSize: 15)),
                                      content: SizedBox(
                                          height: 400,
                                          width: 300,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: const [
                                                  Text('Họ Tên'),
                                                ],
                                              ),
                                              TextField(
                                                controller: nameCTL
                                                  ..text =
                                                      accountapi.info!.fullname,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: const [
                                                  Text('Số điện thoại'),
                                                ],
                                              ),
                                              TextField(
                                                controller: phoneCTL
                                                  ..text =
                                                      accountapi.info!.phone,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: const [
                                                  Text('Địa Chỉ'),
                                                ],
                                              ),
                                              TextField(
                                                controller: addressCTL
                                                  ..text =
                                                      accountapi.info!.address,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: const [
                                                  Text('Email'),
                                                ],
                                              ),
                                              TextFormField(
                                                readOnly: true,
                                                initialValue: acc.info!.email,
                                                decoration:
                                                    const InputDecoration(),
                                              ),
                                              SizedBox(
                                                width: 300,
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      await accountapi
                                                          .updateInfo(
                                                              accountapi
                                                                  .info!.id,
                                                              nameCTL.text,
                                                              phoneCTL.text,
                                                              addressCTL.text);
                                                      // accountapi.getInfoAcc(
                                                      //     (msg) {
                                                      //   print(msg);
                                                      // }, accountapi.info!.id);
                                                      Navigator.pop(
                                                          context, 'cancel');
                                                    },
                                                    child: const Text('Lưu')),
                                              )
                                            ],
                                          )));
                                });
                          });
                        },
                        leading: const Icon(Icons.settings,
                            size: 17, color: Colors.black),
                        title: const Text('Chỉnh Sửa Thông Tin Cá Nhân',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'wishlist');
                        },
                        child: const ListTile(
                          leading: Icon(Icons.favorite_border_outlined,
                              size: 17, color: Colors.black),
                          title: Text('Danh sách yêu thích',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'ordermanagement');
                        },
                        child: const ListTile(
                          leading: Icon(Icons.payment_outlined,
                              size: 17, color: Colors.black),
                          title: Text('Tình trạng đơn hàng',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const ListTile(
                        leading: Icon(Icons.playlist_add_check_outlined,
                            size: 17, color: Colors.black),
                        title: Text('Đơn hàng thành công',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'order_cancel');
                        },
                        child: const ListTile(
                          leading: Icon(Icons.remove_done_outlined,
                              size: 17, color: Colors.black),
                          title: Text('Đơn hàng đã huỷ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Center(
                                    child: Text(
                                      'Thay đổi mật khẩu',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  content: SizedBox(
                                    height: 250,
                                    child: ListView(children: [
                                      Row(
                                        children: const [
                                          Text('Mật khẩu cũ'),
                                        ],
                                      ),
                                      TextField(
                                        controller: oldpassCTL,
                                        decoration: const InputDecoration(),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: const [
                                          Text('Mật khẩu mới'),
                                        ],
                                      ),
                                      TextField(
                                        controller: newpassCTL,
                                        decoration: const InputDecoration(),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      SizedBox(
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              if (oldpassCTL.text == "" ||
                                                  newpassCTL.text == "") {
                                                Navigator.pop(context);
                                                var content = const SnackBar(
                                                    content: Text(
                                                        'vui lòng nhập đầy đủ thông tin'));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(content);
                                              } else {
                                                var kq =
                                                    await accountapi.changePass(
                                                        accountapi.info!.id,
                                                        oldpassCTL.text,
                                                        newpassCTL.text);
                                                Navigator.pop(context);
                                                if (kq == false) {
                                                  var content = const SnackBar(
                                                      content: Text(
                                                          'vui lòng nhập đúng mật khẩu cũ'));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(content);
                                                }
                                              }
                                              oldpassCTL.clear();
                                              newpassCTL.clear();
                                            },
                                            child: const Text('Lưu')),
                                      )
                                    ]),
                                  ),
                                );
                              });
                        },
                        child: const ListTile(
                          leading: Icon(Icons.change_circle_outlined,
                              size: 17, color: Colors.black),
                          title: Text('Thay đổi mật khẩu',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 15, right: 15),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, 'loading', (route) => false);
                            // Navigator.restorablePopAndPushNamed(
                            //     context, 'loading');
                          },
                          child: Container(
                            height: 45,
                            // color: Colors.red,
                            decoration: BoxDecoration(
                                border: Border.all(
                              width: 1.5,
                              color: Colors.red,
                            )),
                            child: const Center(
                              child: Text('Đăng xuất',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      const Center(
                        child: Text('ShopPhone v0.1.1.1',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            )),
                      )
                    ],
                  ),
                );
              },
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
                      Navigator.pushNamed(context, 'home');
                    },
                    child: Column(children: [
                      productapi.index == 0
                          ? const Icon(Icons.home_filled, color: Colors.red)
                          : Image.asset('images/home.png'),
                      productapi.index == 0
                          ? const Text('Trang Chủ',
                              style: TextStyle(color: Colors.red))
                          : const Text('Trang Chủ')
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      // $api2.changeIndex(1);
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
                    },
                    child: Column(children: [
                      productapi.index == 2
                          ? Image.asset('images/user.png')
                          : Image.asset('images/account.png'),
                      productapi.index == 2
                          ? const Text('Tài Khoản',
                              style: TextStyle(color: Colors.orange))
                          : const Text(
                              'Tài Khoản',
                            )
                    ]),
                  ),
                ]),
          );
        },
      ),
    );
  }
}
