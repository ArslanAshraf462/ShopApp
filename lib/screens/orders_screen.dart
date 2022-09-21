import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future? _ordersFuture;
  Future _obtainOrdersFuture(){
    return Provider.of<Orders>(context,listen: false).fetchAndSetOrders();
  }
  @override
  void setState(VoidCallback fn) {
    _ordersFuture=_obtainOrdersFuture();
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
   // final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (context, dataSnapshot) {
        if(dataSnapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        else{
          if(dataSnapshot.hasError == null){
            //Do Some error handling here
            return Center(child: Text('An error occured!'),);
          }
          else{
            return Consumer<Orders>(builder: (context, ordersData, child) {
              return ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (context, index) => OrderItem(ordersData.orders[index]),
        );
            },);
          }
        }
      },
      ),
    );
  }
}