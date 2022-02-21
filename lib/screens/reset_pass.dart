import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController txt_Reset = TextEditingController();
    var api_reset = Provider.of<ApiAcc>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'reset password',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 16,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text('Nhập email reset password'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: txt_Reset,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        api_reset.resetPassword(txt_Reset.text);
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

                        Future.delayed(const Duration(milliseconds: 1500), () {
                          Navigator.pushNamed(context, 'success_reset');
                        });
                      },
                      child: const Text('Gửi Email reset')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
