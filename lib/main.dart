import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

import './providers/products_provider.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';
import './providers/auth_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
              create: (context) => ProductsProvider(null, null, []),
              update: (context, auth, previousProductsProvider) =>
                  ProductsProvider(
                      auth.token,
                      auth.userId,
                      previousProductsProvider == null
                          ? []
                          : previousProductsProvider.items)),
          ChangeNotifierProvider(create: (context) => CartProvider()),
          ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
              create: (context) => OrdersProvider(null, null, []),
              update: (context, auth, previousOrdersProvider) => OrdersProvider(
                  auth.token,
                  auth.userId,
                  previousOrdersProvider == null
                      ? []
                      : previousOrdersProvider.orders)),
        ],
        // value: ProductsProvider(),
        child: Consumer<AuthProvider>(
            builder: (context, auth, _) => MaterialApp(
                  title: 'MyShop',
                  theme: ThemeData(
                      fontFamily: 'Lato',
                      primarySwatch: Colors.purple,
                      accentColor: Colors.deepOrange),
                  home: auth.isAuth
                      ? ProductsOverviewScreen()
                      : FutureBuilder(
                          builder: (context, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? SplashScreen()
                                  : AuthScreen(),
                          future: auth.tryAutoLogin(),
                        ),
                  routes: {
                    ProductDetailScreen.routeName: ((context) =>
                        ProductDetailScreen()),
                    CartScreen.routeName: ((context) => CartScreen()),
                    UserProductsScreen.routeName: ((context) =>
                        UserProductsScreen()),
                    OrdersScreen.routeName: ((context) => OrdersScreen()),
                    EditProductScreen.routeName: ((context) =>
                        EditProductScreen())
                  },
                )));
  }
}
