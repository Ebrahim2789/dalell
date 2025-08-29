
// views/order_list_view.dart
import 'package:dalell/order/controller/address_controller.dart';
import 'package:dalell/order/controller/orderController.dart';
import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/address.dart';
import 'order_form.dart';

class OrderListView extends StatefulWidget {
  const OrderListView({super.key});

  @override
  _OrderListViewState createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  final OrderController orderController = OrderController();
  final AddressController addressController = AddressController();
  List<Order> orders = [];
  Map<String, Address> addressMap = {};

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() async {
    final data = await orderController.getAllOrders();
    final addresses = await addressController.getAllAddresses();

    // map addresses for quick lookup
    addressMap = {for (var a in addresses) a.city: a};

    setState(() => orders = data);
  }

  void _openForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderForm(onSaved: _loadOrders),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, i) {
          final o = orders[i];
          final addr = addressMap[o.addressId];
          return ListTile(
            title: Text("Order  - ${o.status}"),
            subtitle: Text(
                "Product: ${o.productId}, Qty: ${o.quantity}, Total: ${o.total}\n"
                "Address: ${addr?.customerName}, ${addr?.city}"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openForm,
        child: Icon(Icons.add),
      ),
    );
  }
}


