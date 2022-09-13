import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  // ProductDetailScreen(this.title);
  static const routeName = '/productdetail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct=Provider.of<Products>(context).items.firstWhere(
      (pro) => pro.id==productId
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),

    );
  }
}