// models/order.dart

import 'package:dalell/config/constant.dart';
import 'package:dalell/container/container.dart';
import 'package:dalell/order/controller/delivery_controller.dart';
import 'package:dalell/order/models/order.dart';
import 'package:dalell/routes/routes.dart';
import 'package:flutter/material.dart';


// class DeliveryListView extends StatefulWidget {
//   const DeliveryListView({super.key});

//   @override
//   _DeliveryListViewState createState() => _DeliveryListViewState();
// }

// class _DeliveryListViewState extends State<DeliveryListView> {
//   final DeliveryController controller = DeliveryController();
//   List<Delivery> deliveries = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadDeliveries();
//   }

//   void _loadDeliveries() async {
//     final data = await controller.getAllDeliveries();
//     setState(() => deliveries = data);
//   }

//   void _addDelivery() async {
//     final delivery = Delivery(
//       id: 1,
//       orderId: 1, // sample order id
//       address: "Addis Ababa, Ethiopia",
//       status: "pending",
//       deliveredAt: null,
//     );
//     await controller.insertDelivery(delivery);
//     _loadDeliveries();
//   }

//   void _updateDelivery(Delivery d) async {
//     final updated = Delivery(
//       id: d.id,
//       orderId: d.orderId,
//       address: d.address,
//       status: "delivered",
//       deliveredAt: DateTime.now().toIso8601String(),
//     );
//     await controller.updateDelivery(updated);
//     _loadDeliveries();
//   }

//   void _deleteDelivery(String id) async {
//     await controller.deleteDelivery(id);
//     _loadDeliveries();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Deliveries")),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 8.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.05),
//               blurRadius: 18,
//               offset: const Offset(0, 8),
//             ),
//           ],
//           border: Border.all(color: Colors.grey.shade200),
//         ),
//         child: SizedBox(

//           child: ListView.separated(
//               itemCount: deliveries.length,
//               itemBuilder: (context, i) {
//                 final d = deliveries[i];
//                 return ListTile(
//                   leading:Text("Status: ${d.status}") ,
//                   title: Text("Delivery: ${d.id}"),
//                   subtitle: Text("Address: ${d.address},Status: ${d.status}"),
//                   horizontalTitleGap: 8.0,
//                   style: ListTileStyle.drawer,

//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                           icon: Icon(Icons.edit, color: Colors.blue),
//                           onPressed: () => _updateDelivery(d)),
//                       IconButton(
//                           icon: Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => _deleteDelivery(d.id as String)),
//                     ],
//                   ),
//                   isThreeLine: true,
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) =>
//                   const Divider()),
//         ),
//       ),

//     );
//   }
// }

class DeliveryListView extends StatefulWidget {
  const DeliveryListView({super.key});

  @override
  _DeliveryListViewState createState() => _DeliveryListViewState();
}

class _DeliveryListViewState extends State<DeliveryListView> {
  final DeliveryController controller = DeliveryController();
  List<Delivery> deliveries = [];
  double progress = 0.65;

    List<String> title = const [
      'OrderId',
      'Address',
      'Status',
      'DeliveredAt'
  ];
  List<dynamic> data = [];
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
      // AppBar
      appBar: AppBar(
        title: const Text("Deliveries",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      // Body
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: deliveries.length,
          itemBuilder: (context, i) {
            final d = deliveries[i];

          Iterator<dynamic> dat = deliveries.iterator;
          while (dat.moveNext()) {
            data.add(d.orderId);
    
            data.add(d.address);
            data.add(d.status);
          data.add(d.deliveredAt);
          }


            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),


              child: Column(
                children: [
                  // Stats Card

                  containerCard(Column(
                      children: [
                        const Row(
                          children: [
                            Text("My products",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Spacer(),
                            Text("Hold ", style: TextStyle(color: Colors.grey)),
                            Text("0",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold)),
                            Text(" piece",
                                style: TextStyle(color: Colors.grey)),
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
                        const Row(
                          children: [
                            Icon(Icons.show_chart, color: Colors.orange),
                            SizedBox(width: 5),
                            Text("Total Investment amount",
                                style: TextStyle(color: Colors.grey)),
                            Spacer(),
                            Text("0.00 Br",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade50,
                            foregroundColor: Colors.blue,
                            minimumSize: const Size(double.infinity, 45),
                          ),
                          icon: const Icon(Icons.swap_horiz),
                          label: const Text("Transfer to Balance"),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RouteGenerator.productOrderPage);
                          },
                        ),
                      ],
                    ),),
   
                  // Tabs
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        tabButton("ALL", true),
                        const SizedBox(width: 10),
                        tabButton("Dalell", false),
                      ],
                    ),
                  ),

                  // Product Cards
    

                   containerCard(
                    Column(
                      children: [
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
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12)),
                        // Tabs
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              TextButton.icon(
                                  label: Text('Update'),
                                  icon: Icon(Icons.edit, color: Colors.blue),
         onPressed: () => _updateDelivery(d)),
                              TextButton.icon(
                                label: Text('Delete'),
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteDelivery(d.id as String),
                                style: ButtonStyle(
                                    iconAlignment: IconAlignment.end,
                                    iconSize: WidgetStatePropertyAll(20.4)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
  
                ],
              ),
            );
            
          },
          
          ),

                floatingActionButton: FloatingActionButton(
        onPressed: _addDelivery,
        child: Icon(Icons.add),
      ),
    );
  }

  // Stats item widget
  static Widget statsItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}