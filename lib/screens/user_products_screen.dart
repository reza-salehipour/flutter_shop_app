import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

import '../widgets/user_products_item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: ((_, index) => Column(
                  children: <Widget>[
                    UserProductItem(
                        title: productsData.items[index].title,
                        imageUrl: productsData.items[index].imageUrl),
                    const Divider()
                  ],
                )),
            itemCount: productsData.items.length,
          )),
      drawer: AppDrawer(),
    );
  }
}
