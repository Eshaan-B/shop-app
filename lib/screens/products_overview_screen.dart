import 'package:flutter/material.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('The Black Market'),
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) =>
              [
                PopupMenuItem(
                  child: Text('Only favourites'),
                  value: FilterOptions.Favourites,
                ),
                PopupMenuItem(
                  child: Text('All'),
                  value: FilterOptions.All,
                ),
              ],
              onSelected: (selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favourites) {
                    _showOnlyFavourites = true;
                  } else {
                    _showOnlyFavourites = false;
                  }
                });
              },
            ),
            Consumer<Cart>(
              builder: (ctx, cart, child) =>
                  Badge(
                      child: child,
                      value: cart.itemCount.toString()),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: ProductsGrid(
          showOnlyFavs: _showOnlyFavourites,
        ));
  }
}
