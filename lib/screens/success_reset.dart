import 'package:flutter/material.dart';

class SuccessResetScreen extends StatefulWidget {
  const SuccessResetScreen({Key? key}) : super(key: key);

  @override
  _SuccessResetScreenState createState() => _SuccessResetScreenState();
}

class _SuccessResetScreenState extends State<SuccessResetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/payment_success_icon.png',
              width: 100,
              height: 100,
            ),
            const Center(
                child: Text(
              'Đã gửi Email reset',
              style: TextStyle(
                fontSize: 17,
              ),
            )),
            const Center(
                child: Text(
              'Vui lòng kiểm tra Email!',
              style: TextStyle(
                fontSize: 17,
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Container(
                  width: 180,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      )),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        'Quay về đăng nhập',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
