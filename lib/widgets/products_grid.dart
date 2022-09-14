import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = showFavs ? productData.favoriteItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ), 
      itemBuilder: (context,index){
        return ChangeNotifierProvider.value(
          //create: (context) => products[index],
          value: products[index],
          child: ProductItem(
            // products[index].id, 
            // products[index].title, 
            // products[index].imageUrl,
            ),
        );
      });
  }
}