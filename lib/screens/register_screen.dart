// ignore_for_file: unnecessary_null_comparison

import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/provider/account_provider/register_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullnameCTL = TextEditingController();
  TextEditingController usernameCTL = TextEditingController();
  TextEditingController phoneCTL = TextEditingController();
  TextEditingController addressCTL = TextEditingController();
  TextEditingController passCTL = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Đăng Ký Tài Khoản',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: fullnameCTL,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          errorText: context
                                  .read<Register>()
                                  .validateFullname(fullnameCTL.text)
                              ? null
                              : context.watch<Register>().errorFullname,
                          suffixIcon: const Icon(Icons.account_circle_sharp,
                              color: Colors.black, size: 25),
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: 'Fullname',
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: usernameCTL,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          errorText: context
                                  .read<Register>()
                                  .validateUsername(usernameCTL.text)
                              ? null
                              : context.watch<Register>().errorUsername,
                          suffixIcon: const Icon(Icons.email,
                              color: Colors.black, size: 25),
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: 'Email',
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: phoneCTL,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          errorText: context
                                  .read<Register>()
                                  .validatePhone(phoneCTL.text)
                              ? null
                              : context.watch<Register>().errorPhone,
                          suffixIcon: const Icon(Icons.phone,
                              color: Colors.black, size: 25),
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: 'phone',
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: addressCTL,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          errorText: context
                                  .read<Register>()
                                  .validateAddress(addressCTL.text)
                              ? null
                              : context.watch<Register>().errorAdress,
                          suffixIcon: const Icon(Icons.manage_accounts,
                              color: Colors.black, size: 25),
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: 'address',
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
                          Provider.of<Register>(context, listen: false).show,
                      decoration: InputDecoration(
                          errorText: context
                                  .read<Register>()
                                  .validatePass(passCTL.text)
                              ? null
                              : context.watch<Register>().errorPass,
                          suffixIcon: IconButton(
                              onPressed: () {
                                context.read<Register>().changeShow();
                              },
                              icon: Icon(
                                  context.watch<Register>().show
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
                    TextField(
                      controller: confirmpass,
                      style: const TextStyle(color: Colors.black),
                      obscureText:
                          Provider.of<Register>(context, listen: false).show2,
                      decoration: InputDecoration(
                          errorText: context
                                  .read<Register>()
                                  .validateConfirmPass(
                                      confirmpass.text, passCTL.text)
                              ? null
                              : context.watch<Register>().errorConfirmpass,
                          suffixIcon: IconButton(
                              onPressed: () {
                                context.read<Register>().changeShow2();
                              },
                              icon: Icon(
                                  context.watch<Register>().show2
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                  size: 25)),
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: 'confirm password',
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
                            if (context.read<Register>().checkLogin(
                                usernameCTL.text,
                                passCTL.text,
                                fullnameCTL.text,
                                confirmpass.text,
                                phoneCTL.text,
                                addressCTL.text)) {
                              var kq = await ApiAcc().Register(
                                  fullnameCTL.text,
                                  usernameCTL.text,
                                  passCTL.text,
                                  phoneCTL.text,
                                  addressCTL.text);
                              if (kq.toString() != 'true' || kq == null) {
                                return showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                          title: const Center(
                                              child: Text('Thông Báo')),
                                          content: const Text(
                                              'Email này đã tồn tại!'),
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
                                return showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: const Center(
                                            child: Text('Thông Báo')),
                                        content: const SizedBox(
                                            height: 60,
                                            child: Text('Đăng Ký Thành Công!')),
                                        actions: [
                                          Center(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, '/');
                                                  },
                                                  child:
                                                      const Text('Đăng Nhập')))
                                        ],
                                      );
                                    });
                              }
                            }
                            context.read<Register>().checkLogin(
                                usernameCTL.text,
                                passCTL.text,
                                fullnameCTL.text,
                                confirmpass.text,
                                phoneCTL.text,
                                addressCTL.text);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              // CircularProgressIndicator(color: Colors.black)
                              Text('Đăng Ký'), Icon(Icons.login)
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text('Đăng Nhập',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold)))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}




//  Center(
//         child: SizedBox(
//           child: Padding(
//             padding: const EdgeInsets.all(15),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Đăng Ký Tài Khoản',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextField(
//                     controller: fullnameCTL,
//                     style: const TextStyle(color: Colors.black),
//                     decoration: InputDecoration(
//                         errorText: context
//                                 .read<Register>()
//                                 .validateFullname(fullnameCTL.text)
//                             ? null
//                             : context.watch<Register>().errorFullname,
//                         suffixIcon: const Icon(Icons.account_circle_sharp,
//                             color: Colors.black, size: 25),
//                         hintStyle: const TextStyle(color: Colors.black),
//                         focusedBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue)),
//                         hintText: 'Fullname',
//                         border: const OutlineInputBorder(),
//                         enabledBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black))),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   TextField(
//                     controller: usernameCTL,
//                     style: const TextStyle(color: Colors.black),
//                     decoration: InputDecoration(
//                         errorText: context
//                                 .read<Register>()
//                                 .validateUsername(usernameCTL.text)
//                             ? null
//                             : context.watch<Register>().errorUsername,
//                         suffixIcon: const Icon(Icons.email,
//                             color: Colors.black, size: 25),
//                         hintStyle: const TextStyle(color: Colors.black),
//                         focusedBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue)),
//                         hintText: 'username',
//                         border: const OutlineInputBorder(),
//                         enabledBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black))),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   TextField(
//                     controller: passCTL,
//                     style: const TextStyle(color: Colors.black),
//                     obscureText:
//                         Provider.of<Register>(context, listen: false).show,
//                     decoration: InputDecoration(
//                         errorText:
//                             context.read<Register>().validatePass(passCTL.text)
//                                 ? null
//                                 : context.watch<Register>().errorPass,
//                         suffixIcon: IconButton(
//                             onPressed: () {
//                               context.read<Register>().changeShow();
//                             },
//                             icon: Icon(
//                                 context.watch<Register>().show
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                                 color: Colors.black,
//                                 size: 25)),
//                         hintStyle: const TextStyle(color: Colors.black),
//                         focusedBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue)),
//                         hintText: 'password',
//                         border: const OutlineInputBorder(),
//                         enabledBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black))),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   TextField(
//                     controller: confirmpass,
//                     style: const TextStyle(color: Colors.black),
//                     obscureText:
//                         Provider.of<Register>(context, listen: false).show2,
//                     decoration: InputDecoration(
//                         errorText: context.read<Register>().validateConfirmPass(
//                                 confirmpass.text, passCTL.text)
//                             ? null
//                             : context.watch<Register>().errorConfirmpass,
//                         suffixIcon: IconButton(
//                             onPressed: () {
//                               context.read<Register>().changeShow2();
//                             },
//                             icon: Icon(
//                                 context.watch<Register>().show2
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                                 color: Colors.black,
//                                 size: 25)),
//                         hintStyle: const TextStyle(color: Colors.black),
//                         focusedBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue)),
//                         hintText: 'confirm password',
//                         border: const OutlineInputBorder(),
//                         enabledBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black))),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   SizedBox(
//                     height: 40,
//                     width: 135,
//                     child: ElevatedButton(
//                         onPressed: () async {
//                           if (context.read<Register>().checkLogin(
//                               usernameCTL.text,
//                               passCTL.text,
//                               fullnameCTL.text,
//                               confirmpass.text)) {
//                             var kq = await ApiAcc().Register(fullnameCTL.text,
//                                 usernameCTL.text, passCTL.text);
//                             if (kq.toString() != 'true' || kq == null) {
//                               return showDialog(
//                                   context: context,
//                                   builder: (_) {
//                                     return AlertDialog(
//                                         title: const Center(
//                                             child: Text('Thông Báo')),
//                                         content:
//                                             const Text('Email này đã tồn tại!'),
//                                         actions: [
//                                           ElevatedButton(
//                                               onPressed: () {
//                                                 Navigator.pop(
//                                                     context, 'Cancel');
//                                               },
//                                               child: const Text('Ok'))
//                                         ]);
//                                   });
//                             } else {
//                               return showDialog(
//                                   context: context,
//                                   builder: (_) {
//                                     return AlertDialog(
//                                       title: const Center(
//                                           child: Text('Thông Báo')),
//                                       content: const SizedBox(
//                                           height: 60,
//                                           child: Text('Đăng Ký Thành Công!')),
//                                       actions: [
//                                         Center(
//                                             child: ElevatedButton(
//                                                 onPressed: () {
//                                                   Navigator.pushNamed(
//                                                       context, 'home');
//                                                 },
//                                                 child: const Text('Đăng Nhập')))
//                                       ],
//                                     );
//                                   });
//                             }
//                           }
//                           context.read<Register>().checkLogin(usernameCTL.text,
//                               passCTL.text, fullnameCTL.text, confirmpass.text);
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             // CircularProgressIndicator(color: Colors.black)
//                             Text('Đăng Ký'), Icon(Icons.login)
//                           ],
//                         )),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   GestureDetector(
//                       onTap: () {
//                         Navigator.pushNamed(context, 'home');
//                       },
//                       child: const Text('Đăng Nhập',
//                           style: TextStyle(
//                               color: Colors.blueAccent,
//                               fontWeight: FontWeight.bold)))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       )