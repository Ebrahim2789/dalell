// views/order_list_view.dart
import 'package:dalell/config/constant.dart';
import 'package:dalell/container/container.dart';
import 'package:dalell/order/controller/address_controller.dart';
import 'package:dalell/order/controller/orderController.dart';
import 'package:dalell/config/theme/inputdecoration.dart';
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
  double progress = 0.65;

  List<String> title = const [
    'Product',
    'CreatedAt',
    'Total',
    'Quantity',
    'Status',
  ];
  List<dynamic> data = [];

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

  void _addOrders(Order o) async {
    final Orders = Order(
      id: o.id,
      status: o.status,
      productId: o.quantity,
      quantity: o.quantity,
      total: o.total,
      createdAt: o.createdAt,
      addressId: o.addressId,
    );
    await orderController.insertOrder(Orders);
    _loadOrders();
  }

  void _updateOrders(Order o) async {
    final updated = Order(
      id: o.id,
      status: o.status,
      productId: o.quantity,
      quantity: o.quantity,
      total: o.total,
      createdAt: o.createdAt,
      addressId: o.addressId,
    );
    await orderController.updateOrder(updated);
    _loadOrders();
  }

  void _deleteOrder(String id) async {
    await orderController.deleteOrder(id);
    _loadOrders();
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

          Iterator<dynamic> dat = orders.iterator;
          while (dat.moveNext()) {
            data.add(o.productId);
            data.add(o.createdAt.substring(0, 10));

            // data.add(o.addressId);
            data.add(o.total);
            data.add(o.quantity);
            data.add(o.status);
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: [
                containerCard(
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("My products",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Spacer(),
                          Text("Hold ", style: textStyle1(Colors.grey)),
                          Text("0",
                              style: textStyle(Colors.orange, FontWeight.bold)),
                          Text(" piece", style: textStyle1(Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          statsItem("Today Earnings", "0.00 Br"),
                          statsItem("Total Income", "40.00 Br"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.show_chart, color: Colors.orange),
                          SizedBox(width: 5),
                          Text("Total Investment amount",
                              style: textStyle1(Colors.grey)),
                          Spacer(),
                          Text("0.00 Br",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                containerCard(
                  ElevatedButton.icon(
                    style: styleFromButtonStyle(),
                    icon: const Icon(Icons.shopping_cart_rounded),
                    label: const Text("Add Order"),
                    onPressed: () {
                      _openForm;
                    },
                  ),
                ),
                // Stats Card

                // Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      tabButton("My Order", true),
                      const SizedBox(width: 30),
                      tabButton("All", false),
                    ],
                  ),
                ),

                // Product Cards
                containerCard(
                  Column(children: [
                    productCard(
                      context,
                      "T1",
                      title,
                      data,
                      "assets/images/image1.jpg",
                      progress: progress,
                    ),

                    Stack(
                      children: [
                        container1(
                          Colors.grey.shade300,
                        ),
                        container2(Colors.red, progress)
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text("${(progress * 100).toInt()}%",
                        style:
                            const TextStyle(color: Colors.red, fontSize: 12)),
                    // Tabs
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          TextButton.icon(
                              label: Text('Update'),
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _updateOrders(o)),
                          TextButton.icon(
                            label: Text('Cancel'),
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteOrder(o.id as String),
                            style: ButtonStyle(
                                iconAlignment: IconAlignment.end,
                                iconSize: WidgetStatePropertyAll(20.4)),
                          ),
                        ],
                      ),
                    ),
                  ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
