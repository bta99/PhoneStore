// ignore_for_file: await_only_futures
import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/provider/account_provider/loginprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = '/';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameCTL = TextEditingController();
  TextEditingController passCTL = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameCTL.dispose();
    passCTL.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var acc = Provider.of<CartApi>(context, listen: false);
    var account = Provider.of<ApiAcc>(context, listen: false);
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return boxConstraints.maxWidth > 700
          ? Scaffold(
              backgroundColor: Colors.red,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Ứng dụng chưa hỗ trợ trên cỡ màn hình này!')
                  ],
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Đăng Nhập',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: usernameCTL,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorText: context
                                      .read<Login>()
                                      .validateUsername(usernameCTL.text)
                                  ? null
                                  : context.watch<Login>().errorUsername,
                              suffixIcon: const Icon(Icons.account_circle_sharp,
                                  color: Colors.redAccent, size: 25),
                              hintStyle: const TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide:
                                      const BorderSide(color: Colors.blue)),
                              hintText: 'username',
                              border: const OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide:
                                      const BorderSide(color: Colors.black))),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: passCTL,
                          style: const TextStyle(color: Colors.black),
                          obscureText:
                              Provider.of<Login>(context, listen: false).show,
                          decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorText: context
                                      .read<Login>()
                                      .validatePass(passCTL.text)
                                  ? null
                                  : context.watch<Login>().errorPass,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    context.read<Login>().changeShow();
                                  },
                                  icon: Icon(
                                      context.watch<Login>().show
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.redAccent,
                                      size: 25)),
                              hintStyle: const TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide:
                                      const BorderSide(color: Colors.blue)),
                              hintText: 'password',
                              border: const OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide:
                                      const BorderSide(color: Colors.black))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'resetpass');
                                  },
                                  child: const Text(
                                    'Forgot password',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            )
                          ],
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        GestureDetector(
                          onTap: () async {
                            if (context
                                .read<Login>()
                                .checkLogin(usernameCTL.text, passCTL.text)) {
                              var kq = await ApiAcc()
                                  .login(usernameCTL.text, passCTL.text);
                              if (kq == null) {
                                return showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                          title: const Center(
                                              child: Text('Thông Báo')),
                                          content: const Text(
                                              'Sai Tên tài Khoản hoặc mật khẩu'),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, 'Cancel');
                                                },
                                                child: const Text('Ok'))
                                          ]);
                                    });
                              } else {
                                acc.saveAcc(kq);
                                account.getInfoAcc((msg) {
                                  print(msg);
                                }, kq.id);
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
                                    const Duration(milliseconds: 1000), () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    'home',
                                  );
                                });
                              }
                            }
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(
                                  color: Colors.redAccent,
                                  width: 2,
                                )),
                            child: const Center(
                              child: Text(
                                'Đăng nhập',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Bạn chưa có tài khoản?',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: Colors.redAccent,
                            ),
                            child: const Center(
                              child: Text(
                                'Đăng ký ngay',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
