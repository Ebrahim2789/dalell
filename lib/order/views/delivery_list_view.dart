// models/order.dart

import 'package:dalell/order/controller/delivery_controller.dart';
import 'package:dalell/order/models/order.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DeliveryListView extends StatefulWidget {
  const DeliveryListView({super.key});

  @override
  _DeliveryListViewState createState() => _DeliveryListViewState();
}

class _DeliveryListViewState extends State<DeliveryListView> {
  final DeliveryController controller = DeliveryController();
  List<Delivery> deliveries = [];

  @override
  void initState() {
    super.initState();
    _loadDeliveries();
  }

  void _loadDeliveries() async {
    final data = await controller.getAllDeliveries();
    setState(() => deliveries = data);
  }

  void _addDelivery() async {
    final delivery = Delivery(
      id: 1,
      orderId: 1, // sample order id
      address: "Addis Ababa, Ethiopia",
      status: "pending",
      deliveredAt: null,
    );
    await controller.insertDelivery(delivery);
    _loadDeliveries();
  }

  void _updateDelivery(Delivery d) async {
    final updated = Delivery(
      id: d.id,
      orderId: d.orderId,
      address: d.address,
      status: "delivered",
      deliveredAt: DateTime.now().toIso8601String(),
    );
    await controller.updateDelivery(updated);
    _loadDeliveries();
  }

  void _deleteDelivery(String id) async {
    await controller.deleteDelivery(id);
    _loadDeliveries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Deliveries")),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: SizedBox(
          child: ListView.separated(
              itemCount: deliveries.length,
              itemBuilder: (context, i) {
                final d = deliveries[i];
                return ListTile(
                  leading:Text("Status: ${d.status}") ,
                  title: Text("Delivery: ${d.id}"),
                  subtitle: Text("Address: ${d.address},Status: ${d.status}"),
                  horizontalTitleGap: 8.0,
                  style: ListTileStyle.drawer,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _updateDelivery(d)),
                      IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteDelivery(d.id as String)),
                    ],
                  ),
                  isThreeLine: true,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDelivery,
        child: Icon(Icons.add),
      ),
    );
  }
}
