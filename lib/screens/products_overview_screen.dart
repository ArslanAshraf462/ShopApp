import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
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
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading= true;
      });
      
      Provider.of<Products>(context).fetchAndSetProduct().then((_) {
        setState(() {
          _isLoading=false;
        });
         });
    }
    _isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    //final productContainer = Provider.of<Products>(context, listen: false,);
    final cart = Provider.of<Cart>(context);
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
              
          ]
          ),
          Consumer<Cart>(builder: (_, cart, ch) =>Badge(
                child: ch!,
                  value: cart.itemCount.toString(), 
                  color: Colors.red,
                  ),
                  child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  }, 
                  icon: Icon(Icons.shopping_cart),),
                  ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading 
      ? Center(
        child: CircularProgressIndicator(),
      ) 
      :ProductsGrid(_showOnlyFavorites),
    );
  }
}
