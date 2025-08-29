// controllers/address_controller.dart

import 'package:dalell/order/controller/address_controller.dart';
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
          return ListTile(
            title: Text(a.customerName),
            subtitle: Text("${a.city}, ${a.street}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _updateAddress(a)),
                IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteAddress(a.id as String)),
              ],
            ),
          );
        }, separatorBuilder: (BuildContext context, int index) =>const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAddress,
        child: Icon(Icons.add),
      ),
    );
  }
}