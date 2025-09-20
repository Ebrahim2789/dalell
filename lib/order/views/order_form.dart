
// views/order_form.dart
import 'package:dalell/order/controller/address_controller.dart';
import 'package:dalell/order/controller/orderController.dart';
import 'package:flutter/material.dart';

import '../models/order.dart';
import '../models/address.dart';

class OrderForm extends StatefulWidget {
  final Function onSaved;

  const OrderForm({super.key, required this.onSaved});

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final OrderController orderController = OrderController();
  final AddressController addressController = AddressController();

  final _formKey = GlobalKey<FormState>();
  final _productIdController = TextEditingController();
  final _quantityController = TextEditingController();
  final _totalController = TextEditingController();

  String? selectedAddressId;
  List<Address> addresses = [];

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  void _loadAddresses() async {
    final data = await addressController.getAllAddresses();
    setState(() => addresses = data);
  }

  void _saveOrder() async {
    if (_formKey.currentState!.validate() && selectedAddressId != null) {
      final order = Order(
        id: 1,
        productId:int.tryParse( _productIdController.text),
        quantity: int.parse(_quantityController.text),
        total: double.parse(_totalController.text),
        status: "Pending",
        createdAt: DateTime.now().toIso8601String(),
        addressId: selectedAddressId!, // use selected address
      );
      await orderController.insertOrder(order);
      widget.onSaved();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Order")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: newMethod(),
      ),
    );
  }

  Form newMethod() {
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _productIdController,
              decoration: InputDecoration(labelText: "Product ID"),
              keyboardType: TextInputType.number,
              validator: (v) => v!.isEmpty ? "Enter product ID" : null,
            ),
            TextFormField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Quantity"),
              validator: (v) => v!.isEmpty ? "Enter quantity" : null,
            ),
            TextFormField(
              controller: _totalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Total"),
              validator: (v) => v!.isEmpty ? "Enter total" : null,
            ),
            DropdownButtonFormField<String>(
              initialValue: selectedAddressId,
              items: addresses.map((a) {
                return DropdownMenuItem(
                  value: a.city,
                  child: Text("${a.customerName} - ${a.city}"),
                );
              }).toList(),
              onChanged: (v) => setState(() => selectedAddressId = v),
              decoration: InputDecoration(labelText: "Select Address"),
              validator: (v) =>
                  v == null ? "Please select an address" : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveOrder,
              child: Text("Save Order"),
            ),
          ],
        ),
      );
  }
}
