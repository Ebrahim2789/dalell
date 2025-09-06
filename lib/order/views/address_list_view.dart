// controllers/address_controller.dart

import 'package:dalell/config/constant.dart';
import 'package:dalell/container/container.dart';
import 'package:dalell/order/controller/address_controller.dart';
import 'package:dalell/config/theme/inputdecoration.dart';
import 'package:flutter/material.dart';

import '../models/address.dart';

class AddressListView extends StatefulWidget {
  const AddressListView({super.key});

  @override
  _AddressListViewState createState() => _AddressListViewState();
}

class _AddressListViewState extends State<AddressListView> {
  final AddressController controller = AddressController();
  List<Address> addresses = [];
  double progress = 0.65;
  List<String> title = const [
    'CustomerName',
    'Phone',
    'City'
        'Street',
    'zipCode'
  ];
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  void _loadAddresses() async {
    final data = await controller.getAllAddresses();
    setState(() => addresses = data);
  }

  void _addAddress() async {
    final address = Address(
      id: 1,
      customerName: "John Doe",
      phone: "+251911000000",
      city: "Dire Dawa",
      street: "Kezira Street 12",
      zipCode: "1000",
    );
    await controller.insertAddress(address);
    _loadAddresses();
  }

  void _updateAddress(Address a) async {
    final updated = Address(
      id: a.id,
      customerName: a.customerName,
      phone: a.phone,
      city: "Addis Ababa", // update city
      street: a.street,
      zipCode: a.zipCode,
    );
    await controller.updateAddress(updated);
    _loadAddresses();
  }

  void _deleteAddress(String id) async {
    await controller.deleteAddress(id);
    _loadAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Addresses")),
      body: ListView.separated(
        itemCount: addresses.length,
        itemBuilder: (context, i) {
          final a = addresses[i];

          Iterator<dynamic> dat = addresses.iterator;
          while (dat.moveNext()) {
            data.add(a.customerName);
            data.add(a.phone);
            data.add(a.city);
            data.add(a.street);
            data.add(a.zipCode);
          }

          return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'What are you looking for...',
                          focusedBorder: focusedOutlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          hintStyle: TextStyle(color: Colors.grey),
                          icon: Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(height: 30),
                      containerCard(
                        ElevatedButton.icon(
                          style: styleFromButtonStyle(),
                          icon: const Icon(Icons.swap_horiz),
                          label: const Text("Add Address"),
                          onPressed: () {
                            _addAddress;
                          },
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'What are you looking for...',
                          focusedBorder: focusedOutlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 30),
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
                  // buildPrizeBox("Addersss", Icons.add_ic_call),
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
                                  onPressed: () => _updateAddress(a)),
                              TextButton.icon(
                                label: Text('Delete'),
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteAddress(a.id as String),
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
              ));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
