import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  CartItem(this.id, this.productId,this.title ,this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40.0,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.0),
          margin: EdgeInsets.symmetric(vertical: 4.0,horizontal: 15.0),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<Cart>(context, listen: false).removeItem(productId);
        },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4.0,horizontal: 15.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Text('\$${price}'),
                ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price *  quantity)}'),
            trailing: Text('$quantity x'),
          ),
          ),
      ),
    );
  }
}