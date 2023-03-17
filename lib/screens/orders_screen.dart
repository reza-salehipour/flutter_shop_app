import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart' show OrdersProvider;

import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<OrdersProvider>(context, listen: false)
        .fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<OrdersProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: _ordersFuture,
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (dataSnapshot.error != null) {
                  return const Center(child: Text('error accure'));
                } else {
                  return Consumer<OrdersProvider>(
                      builder: (ctx, orderData, child) => ListView.builder(
                          itemBuilder: (_, i) => OrderItem(
                                order: orderData.orders[i],
                              )));
                }
              }
            }));
  }
}
