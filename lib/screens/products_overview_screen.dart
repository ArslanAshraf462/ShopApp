import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

enum FiltersOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    //final productContainer = Provider.of<Products>(context, listen: false,);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FiltersOptions selectedValue) {
              setState(() {
                if(selectedValue == FiltersOptions.Favorites)
              {
                _showOnlyFavorites=true;
                //productContainer.showFavoritesOnly();
              }else{
                _showOnlyFavorites=false;
               // productContainer.showAll();
              }
              });
            },
            child: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Only Favorites'), value: FiltersOptions.Favorites,),
              PopupMenuItem(child: Text('Show All'), value: FiltersOptions.All,),
          ]),
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
