import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/api/category/category_api.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:ecommerce_shop/api/slider/slider_api.dart';
import 'package:ecommerce_shop/provider/account_provider/loginprovider.dart';
import 'package:ecommerce_shop/provider/account_provider/register_provider.dart';
import 'package:ecommerce_shop/screens/cart_screen.dart';
import 'package:ecommerce_shop/screens/home_screen.dart';
import 'package:ecommerce_shop/screens/login.dart';
import 'package:ecommerce_shop/screens/register_screen.dart';
import 'package:ecommerce_shop/screens/search_screen.dart';
import 'package:ecommerce_shop/screens/test.dart';
import 'package:ecommerce_shop/screens/uploadfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SliderApi()),
        ChangeNotifierProvider(create: (_) => Login()),
        ChangeNotifierProvider(create: (_) => Register()),
        ChangeNotifierProvider(create: (_) => ProductApi()),
        ChangeNotifierProvider(create: (_) => CategoryApi()),
        ChangeNotifierProvider(create: (_) => ApiAcc()),
        ChangeNotifierProvider(create: (_) => CartApi())
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'poppins'),
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      initialRoute: '/',
      routes: {
        'upload': (context) => const UploadImage(),
        '/': (context) => const LoginScreen(),
        'home': (context) => const HomeScreen(),
        'register': (context) => const RegisterScreen(),
        'search': (context) => const SearchScreen(),
        'test': (_) => const Test(),
        'cart': (_) => const CartScreen()
      },
    );
  }
}
