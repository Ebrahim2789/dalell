import 'package:flutter/material.dart';

class ImageWidetDeom extends StatefulWidget {
  const ImageWidetDeom({super.key, required this.title});
  final String title;

  @override
  State<ImageWidetDeom> createState() => _ImageWidetDeomState();
}

class _ImageWidetDeomState extends State<ImageWidetDeom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.lightBlue,
      ),
      body:    const FormWidgetDemo()
      
    );
  }
}

class FormWidgetDemo extends StatefulWidget {
  const FormWidgetDemo({super.key});

  @override
  State<FormWidgetDemo> createState() => _FormWidgetDemoState();
}

class _FormWidgetDemoState extends State<FormWidgetDemo> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Order order = Order();
  String? _valediateItemValue(String value) {
    return value.isEmpty ? "Item must not be empty" : null;
  }

  String? _valediateQuintitValue(String value) {
    int? isInteger = value.isEmpty ? 0 : int.tryParse(value);
    return isInteger == 0 ? 'item requred' : null;
  }

  void onSubmite() {
    if (_formStateKey.currentState!.validate()) {
      _formStateKey.currentState?.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
            key: _formStateKey,
            // autovalidateMode: true,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter your email to recover your password',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'new password',
                    labelText: 'Enter Your new password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  validator: (value) => _valediateItemValue(value!),
                  onSaved: (newValue) => order.item = newValue!,
                ),
                const Padding(padding: EdgeInsets.all(16)),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Conferm password',
                      labelText: 'Enter Your new password agian',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ))),
                  validator: (value) => _valediateQuintitValue(value!),
                  onSaved: (newValue) =>
                      order.quintity = int.tryParse(newValue!)!,
                ),
                TextButton(
                  onPressed: () => onSubmite(),
                  child: const Text('Save'),
                )
              ],
            ))
      ],
    );
  }
}

class Order {
  late String item;
  late int quintity;
}
