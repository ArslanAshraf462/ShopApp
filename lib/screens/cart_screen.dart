import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.white,),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    ),
                   OrderButton(cart: cart),
                ],
              ),
              ),
          ),
          SizedBox(height: 10.0,),
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx,i) => CartItem(
                cart.items.values.toList()[i].id, 
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].title, 
                cart.items.values.toList()[i].price, 
                cart.items.values.toList()[i].quantity),
                ),
            ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;
  OrderButton({required this.cart});

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return  TextButton(
                      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
                          ? null
                          : () async {
                            setState(() {
                              _isLoading = true;
                            });
                             await Provider.of<Orders>(context, listen: false)
                                  .addOrder(
                                widget.cart.items.values.toList(),
                                widget.cart.totalAmount,
                              );
                              setState(() {
                                _isLoading=false;
                              });
                              widget.cart.clear();
                            },
                      child: _isLoading ? CircularProgressIndicator() : Text(
                        'ORDER NOW',
                      ),
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      );
  }
}