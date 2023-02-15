import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum filterOptions { Favorites, All }

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final productContainer = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (filterOptions selectedValue) {
              if (selectedValue == filterOptions.Favorites) {
                // productContainer.showFavoriteOnly();
              } else {
                // productContainer.showAll();
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: filterOptions.Favorites,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                  child: Text('Show All'), value: filterOptions.All)
            ],
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
