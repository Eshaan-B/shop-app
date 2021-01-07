import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../widgets/products_grid.dart';
import '../providers/products_provider.dart';
class ProductsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext cont    ext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Black Market'),
      ),
      body: ProductsGrid()
    );
  }
}
