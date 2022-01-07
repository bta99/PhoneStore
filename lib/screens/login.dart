// ignore_for_file: await_only_futures
import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/provider/account_provider/loginprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Đăng Nhập',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: usernameCTL,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            errorText: context
                                    .read<Login>()
                                    .validateUsername(usernameCTL.text)
                                ? null
                                : context.watch<Login>().errorUsername,
                            suffixIcon: const Icon(Icons.account_circle_sharp,
                                color: Colors.black, size: 25),
                            hintStyle: const TextStyle(color: Colors.black),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            hintText: 'username',
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
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
                            errorText:
                                context.read<Login>().validatePass(passCTL.text)
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
                                    color: Colors.black,
                                    size: 25)),
                            hintStyle: const TextStyle(color: Colors.black),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            hintText: 'password',
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 40,
                        width: 330,
                        child: ElevatedButton(
                            onPressed: () async {
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Đăng Nhập'),
                                Icon(Icons.login)
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          child: const Text('Đăng Ký',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
