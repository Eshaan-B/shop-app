import 'package:flutter/material.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import './providers/products_provider.dart';
import 'providers/cart.dart';
import 'screens/CartScreen.dart';
import 'providers/orders.dart';
import 'screens/OrdersScreen.dart';
import 'screens/user_product_screen.dart';
import 'screens/edit_product.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(136, 14, 79, .1),
      100: Color.fromRGBO(136, 14, 79, .2),
      200: Color.fromRGBO(136, 14, 79, .3),
      300: Color.fromRGBO(136, 14, 79, .4),
      400: Color.fromRGBO(136, 14, 79, .5),
      500: Color.fromRGBO(136, 14, 79, .6),
      600: Color.fromRGBO(136, 14, 79, .7),
      700: Color.fromRGBO(136, 14, 79, .8),
      800: Color.fromRGBO(136, 14, 79, .9),
      900: Color.fromRGBO(136, 14, 79, 1),
    };
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: MaterialColor(0xff1a1c20, color),
          accentColor: MaterialColor(0xfff9813a, color),
          fontFamily: 'Lato',
        ),
        routes: {
          '/': (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName:(ctx)=>EditProductScreen(),
        },
      ),
    );
  }
}
