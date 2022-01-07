import 'dart:io';
import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    var id = Provider.of<CartApi>(context, listen: false);
    var account = Provider.of<ApiAcc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Thay đổi ảnh đại diện',
            style: TextStyle(color: Colors.black, fontSize: 15)),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              if (account.imagePath == "") {
                account.setImage("");
                account.getInfoAcc((msg) {
                  print(msg);
                }, account.info!.id);
                Navigator.popAndPushNamed(context, 'info');
              } else {
                var content = const SnackBar(content: Text('bạn chưa lưu ảnh'));
                ScaffoldMessenger.of(context).showSnackBar(content);
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 16,
            )),
      ),
      body: Consumer<ApiAcc>(
        builder: (_, acc, child) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          account.chooseImage();
                        },
                        child: const Text('chọn ảnh')),
                  ),
                  account.imagePath != ""
                      ? Container(
                          color: Colors.transparent,
                          width: 150,
                          height: 105,
                          child: Image.file(File(account.imagePath)),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red)),
                          width: 150,
                          height: 105,
                        ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (account.file != null) {
                            await account.uploadFile(
                                File(account.file!.path), id.acctemp!.id);
                            account.imagePath = account.file!.path;
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
                            await account.getInfoAcc((msg) {
                              print(msg);
                            }, account.info!.id);
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              Navigator.popAndPushNamed(context, 'info');
                            });
                          } else {
                            var content = const SnackBar(
                                content: Text('vui lòng chọn ảnh'));
                            ScaffoldMessenger.of(context).showSnackBar(content);
                          }
                        },
                        child: const Text('Lưu ảnh')),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
