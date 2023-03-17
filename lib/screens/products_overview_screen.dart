import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge_widget.dart';
import '../widgets/app_drawer.dart';

import '../screens/cart_screen.dart';

import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';

enum filterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isinit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<ProductsProvider>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final productContainer = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (filterOptions selectedValue) {
              setState(() {
                if (selectedValue == filterOptions.Favorites) {
                  _showOnlyFavorites = true;
                  // productContainer.showFavoriteOnly();
                } else {
                  _showOnlyFavorites = false;
                  // productContainer.showAll();
                }
              });
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
          ),
          Consumer<CartProvider>(
              builder: (_, cart, ch) =>
                  BadgeWidget(value: cart.itemCount.toString(), child: ch!),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              )),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
