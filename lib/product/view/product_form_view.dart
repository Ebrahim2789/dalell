// product_repository.dart

import 'dart:io';

import 'package:dalell/config/theme/themedata.dart';
import 'package:dalell/product/controller/product_controller.dart';
import 'package:dalell/product/models/product.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import 'package:dalell/product/models/brand.dart';
import 'package:dalell/product/models/category.dart';
void main() {
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: appTheme(),
      home: const ProductForm(),
    );
  }
}

class ProductFormView extends StatefulWidget {
  final Product? product; // if not null → edit mode

  const ProductFormView({super.key, this.product});

  @override
  _ProductFormViewState createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  
  final _formKey = GlobalKey<FormState>();
  final ProductController controller = ProductController();

  late TextEditingController nameCtrl;
  late TextEditingController descCtrl;
  late TextEditingController priceCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.product?.name ?? "");
    descCtrl = TextEditingController(text: widget.product?.description ?? "");
    priceCtrl = TextEditingController(
        text: widget.product != null ? widget.product!.price.toString() : "");
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?.id ??1,
        name: nameCtrl.text,
        description: descCtrl.text,

        price: double.tryParse(priceCtrl.text) ?? 0, 
       brand: 
       Brand(id: 1, name: 'SoundMax', logoUrl: 'assets/images/image2.jpg'),
      category: 
      Category(id: 1, name: 'Electronics'),
         media: [],
        attributes: [], options: [], 
      );

      if (widget.product == null) {
        await controller.insertProduct(product);
      } else {
        await controller.updateProduct(product);
      }

      Navigator.pop(context, true); // return to list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.product == null ? "Add Product" : "Edit Product")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: 
        
        
        Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: "Name"),
              validator: (v) => v!.isEmpty ? "Enter product name" : null,
            ),
            TextFormField(
              controller: descCtrl,
              decoration: InputDecoration(labelText: "Description"),
              validator: (v) => v!.isEmpty ? "Enter description" : null,
            ),
            TextFormField(
              controller: priceCtrl,
              decoration: InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
              validator: (v) => v!.isEmpty ? "Enter price" : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProduct,
              child: Text("Save"),
            )
          ]),
        ),
      ),
    );
  }
}

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  ProductFormState createState() => ProductFormState();
}

class ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  List<dynamic> _selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderTextField(
                  name: 'productName',
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// File Picker
                FormBuilderFilePicker(
                  name: 'images',
                  allowMultiple: true,
                  maxFiles: 5,
                  previewImages: false, // ❌ disable default preview
                  decoration: InputDecoration(
                    labelText: "Upload Product Images",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _selectedFiles = val ?? [];
                    });
                  },
                  typeSelectors: [
                    TypeSelector(
                      type: FileType.image,
                      selector: Row(
                        children: const <Widget>[
                          Icon(Icons.add_a_photo, color: Colors.blue),
                          SizedBox(width: 8),
                          Text("Add Images"),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// Custom Preview Grid
                if (_selectedFiles.isNotEmpty) ...[
                  Text(
                    "Preview",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _selectedFiles.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final file = _selectedFiles[index];
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(file.path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedFiles.removeAt(index);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],

                const SizedBox(height: 20),

                /// Save button
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        final formData = _formKey.currentState?.value;
                        print("Form Data: $formData");
                      }
                    },
                    icon: Icon(Icons.save),
                    label: Text("Save Product"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}