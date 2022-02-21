import 'package:ecommerce_shop/api/account/api_acc.dart';
import 'package:ecommerce_shop/api/cart/cart_api.dart';
import 'package:ecommerce_shop/api/category/category_api.dart';
import 'package:ecommerce_shop/api/order/order_api.dart';
import 'package:ecommerce_shop/api/product/product_api.dart';
import 'package:ecommerce_shop/api/slider/slider_api.dart';
import 'package:ecommerce_shop/api/wishlist/wish_list_api.dart';
import 'package:ecommerce_shop/loading_screen.dart';
import 'package:ecommerce_shop/provider/account_provider/loginprovider.dart';
import 'package:ecommerce_shop/provider/account_provider/register_provider.dart';
import 'package:ecommerce_shop/screens/account_screen.dart';
import 'package:ecommerce_shop/screens/cart_screen.dart';
import 'package:ecommerce_shop/screens/checkbox_rating.dart';
import 'package:ecommerce_shop/screens/checkout_screen.dart';
import 'package:ecommerce_shop/screens/home_screen.dart';
import 'package:ecommerce_shop/screens/login.dart';
import 'package:ecommerce_shop/screens/notifycation_screen.dart';
import 'package:ecommerce_shop/screens/order_cancel_screen.dart';
import 'package:ecommerce_shop/screens/order_detail.dart';
import 'package:ecommerce_shop/screens/ordermanagement_screen.dart';
import 'package:ecommerce_shop/screens/pay_success_screen.dart';
import 'package:ecommerce_shop/screens/product_all.dart';
import 'package:ecommerce_shop/screens/products_by_type.dart';
import 'package:ecommerce_shop/screens/register_screen.dart';
import 'package:ecommerce_shop/screens/reset_pass.dart';
import 'package:ecommerce_shop/screens/search_screen.dart';
import 'package:ecommerce_shop/screens/success_reset.dart';
import 'package:ecommerce_shop/screens/test.dart';
import 'package:ecommerce_shop/screens/uploadfile.dart';
import 'package:ecommerce_shop/screens/wish_list_screen.dart';
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
        ChangeNotifierProvider(create: (_) => CartApi()),
        ChangeNotifierProvider(create: (_) => OrderApi()),
        ChangeNotifierProvider(create: (_) => WishListApi()),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final routes = {
    LoadingScreen.id: (_) => const LoadingScreen(),
    HomeScreen.id: (_) => const HomeScreen(),
    Test.id: (_) => const Test(),
    WishListScreen.id: (_) => const WishListScreen(),
    CartScreen.id: (_) => const CartScreen(),
    AccountScreen.id: (_) => const AccountScreen(),
    // ProductsByType.id: (_) => const ProductsByType(),
    LoginScreen.id: (_) => const LoginScreen(),
    RegisterScreen.id: (_) => const RegisterScreen(),
    ProductAllScreen.id: (_) => const ProductAllScreen(),
    NotifycationScreen.id: (_) => const NotifycationScreen()
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'poppins'),
      debugShowCheckedModeBanner: false,
      // home: const HomeScreen(),
      initialRoute: LoadingScreen.id,
      // initialRoute: 'product_all',
      routes: {
        'upload': (context) => const UploadImage(),
        // '/': (context) => const LoginScreen(),
        // 'home': (context) => const HomeScreen(),
        // 'register': (context) => const RegisterScreen(),
        'search': (context) => const SearchScreen(),
        // 'test': (_) => const Test(),
        // 'cart': (_) => const CartScreen(),
        // 'info': (_) => const AccountScreen(),
        'checkout': (_) => const CheckoutScreen(),
        'ordermanagement': (_) => const OrderManagementScreen(),
        'pay_success': (_) => const PaySuccessScreen(),
        'rating': (_) => const CheckBoxScreen(),
        'loading': (_) => const LoadingScreen(),
        'products_by_type': (_) => const ProductsByType(),
        // 'wishlist': (_) => const WishListScreen(),
        'order_cancel': (_) => const OrderCancelScreen(),
        'order_detail': (_) => const OrderDetailScreen(),
        // 'product_all': (_) => const ProductAllScreen(),
        'resetpass': (_) => const ResetPasswordScreen(),
        'success_reset': (_) => const SuccessResetScreen()
      },
      onGenerateRoute: (settings) {
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondAnimation) =>
                routes[settings.name]!(context),
            transitionsBuilder: (context, animation, secondAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(1, 0), end: const Offset(0, 0)),
                ),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300));
      },
    );
  }
}
