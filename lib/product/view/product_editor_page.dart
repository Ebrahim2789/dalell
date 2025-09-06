import 'dart:io';

import 'package:dalell/oop/tree.dart';
import 'package:dalell/product/controller/product_controller.dart';
import 'package:dalell/product/models/product.dart';
import 'package:dalell/product/models/product_attribute.dart';
import 'package:dalell/product/repositories/brand_repository.dart';
import 'package:dalell/product/repositories/category_repository.dart';
import 'package:dalell/product/repositories/product_ateribute_repository.dart';
import 'package:dalell/product/repositories/product_media_repository.dart';

import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:dalell/product/models/brand.dart';
import 'package:dalell/product/models/category.dart';

final List<String> media = [];

List<PlatformFile> imags = [];

class ProductEditorPage extends StatefulWidget {
  final Product? product;

  const ProductEditorPage({super.key, this.product});

  @override
  State<ProductEditorPage> createState() => ProductEditorPageState();
}

class ProductEditorPageState extends State<ProductEditorPage> {
  final _formKey = GlobalKey<FormState>();
  final ProductController controller = ProductController();

  final mediaRepo = ProductMediaRepository();
  final categorRepo = CategoryRepository();
  final attributRepo = ProductAteributeRepository();

  final optionRepo = ProductOptionRepository();

  final brandRepo = BrandRepository();

  late TextEditingController nameCtrl;
  late TextEditingController descCtrl;
  late TextEditingController priceCtrl;

  final List<String> _allCategories = const [
    'Perfume',
    'Cosmetics',
    'Gifts',
    'Men',
    'Women',
    'Premium',
    'New'
  ];
  final Set<int> _selectedCategories = {1, 3};

  final List<String> _brands = const [
    'LTA',
    'Noura',
    'AromaX',
    'EthiScent',
    'Dahlia'
  ];
  int? _brand = 1;
  final List<Brand> _brandss = [];
  final List<Category> _allCategoriess = [];

  List<ProductAttribute> pa = [
    ProductAttribute(
      name: "Color",
      options: [
        ProductOption(value: "Black"),
        ProductOption(value: "White"),
      ],
    ),
    ProductAttribute(
      name: "Storage",
      options: [
        ProductOption(value: "128GB"),
        ProductOption(value: "256GB"),
      ],
    ),
  ];

  late List<Product> pro = [];
  void _loadAllProductFilds() async {
    // pro.first.name != "goods";
    // pro.last.name != "goods";

    // late Iterator<dynamic> data = pa.iterator;
    // int a = 0;

    // while (data.moveNext()) {
    //   pro.first.attributes[a].options != data.current;
    //   a++;
    // }

// Insert a brand
    List<Brand> brand = await brandRepo.getAllBrands();
    if (brand.isNotEmpty) {
      // for (var b in brand) {
      //   print(b.name);
      // }
      setState(
        () => _brandss.addAll(brand),
      );
    } else {
      for (var b in _brands) {
        brandRepo.insertBrand(Brand(
          name: b,
          logoUrl: 'assets/images/image2.jpg',
        ));
      }
    }

    List<Category> category = await categorRepo.getAllCategory();
    if (category.isNotEmpty) {
      // for (var c in category) {
      //   print(c.name);
      // }

      setState(
        () => _allCategoriess.addAll(category),
      );
    } else {
      for (var c in _allCategories) {
        categorRepo.insertCategory(Category(name: c));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAllProductFilds();
    nameCtrl = TextEditingController(text: widget.product?.name ?? "");
    descCtrl = TextEditingController(text: widget.product?.description ?? "");
    priceCtrl = TextEditingController(
        text: widget.product != null ? widget.product!.price.toString() : "");
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?.id ?? 1,
        name: nameCtrl.text,
        description: descCtrl.text,
        price: double.tryParse(priceCtrl.text) ?? 0,
        brand: Brand(
            id: _brand, name: 'SoundMax', logoUrl: 'assets/images/image2.jpg'),
        category: Category(id: _selectedCategories.first, name: ''),
        media: [
          
        ],
        attributes: [
          
        ],
        options: [],
      );

      if (widget.product == null) {
        print(product.brand);
        print(product.category);
        // await controller.insertProduct(product);
      } else {
        await controller.updateProduct(product);
      }

      print(imags.first);

      // Navigator.pop(context, true); // return to list
    }
  }

  final List<String> medias = [];
  final List<String> _media =
      []; // store paths/urls/base64 after you hook it up

  bool _published = true;
  DateTime? _scheduleDate;

  // ---- Helpers ----
  Future<void> _pickMedia(String filenam) async {
    setState(() => _media.add(filenam));
  }

  Future<void> _pickSchedule() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(now.year + 3),
      initialDate: _scheduleDate ?? now,
    );
    if (picked != null) setState(() => _scheduleDate = picked);
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved (UI only). Hook up your logic!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).colorScheme.surface;
    final onBg = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            elevation: 0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(20, 56, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text('Create / Edit Product',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: 6),
                      Text('Media • Publish • Category • Brand',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            ),
            title: const Text('Product'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // --- Content ---
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _SectionCard(
                        title: 'Product Details"',
                        subtitle: 'Control visibility & schedule',
                        child: _producDetails(nameCtrl, descCtrl, priceCtrl),
                      ),
                      const SizedBox(height: 14),
                      _SectionCard(
                        title: 'Products Category',
                        subtitle: 'Pick one or more categories',
                        child: _categoryChips(),
                      ),
                      const SizedBox(height: 14),
                      _SectionCard(
                        title: 'Products Brand',
                        subtitle: 'Associate the product with a brand',
                        child: _brandDropdown(bg, onBg),
                      ),
                      const SizedBox(height: 14),
                      _SectionCard(
                        title: 'Products Media',
                        subtitle: 'Images & videos that represent this product',
                        child: _mediaGrid(),

                        // _FilePick(),

                        // _mediaGrid(),
                      ),
                      const SizedBox(height: 14),
                      _SectionCard(
                        title: 'Products Publish',
                        subtitle: 'Control visibility & schedule',
                        child: _publishSection(onBg),
                      ),
                      const SizedBox(height: 10),
                      _SectionCard(
                        title: 'Products Option',
                        subtitle: 'Control visibility & schedule',
                        child: _atterbuteClip(),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),

      // Sticky Save Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // Optional: preview action
                },
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Preview'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _saveProduct,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6D00),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _producDetails(TextEditingController nameCtrl,
      TextEditingController descCtrl, TextEditingController priceCtrl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(children: [
        // const Icon(Icons.apps_outlined, color: Color(0xFFFF6D00)),
        const SizedBox(width: 8),
        TextFormField(
          controller: nameCtrl,
          decoration: InputDecoration(
            labelText: 'Product Name',
            prefixIcon: Icon(Icons.label),
          ),
          validator: (v) => v!.isEmpty ? "Enter product name" : null,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: descCtrl,
          decoration: InputDecoration(
            labelText: 'Product Description',
            prefixIcon: Icon(Icons.description),
          ),
          maxLines: 3,
          validator: (v) => v!.isEmpty ? "Enter product Description" : null,
        ),

        const SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: priceCtrl,
                decoration: InputDecoration(
                  labelText: 'Original Price',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Enter product Price" : null,
              ),
              SizedBox(height: 10),
              // TextFormField(
              //   decoration: InputDecoration(
              //     labelText: 'Wholesale Price',
              //     prefixIcon: Icon(Icons.attach_money),
              //   ),
              //   keyboardType: TextInputType.number,
              // ),
              // SizedBox(height: 16),
              // TextFormField(
              //   decoration: InputDecoration(
              //     labelText: 'Retail Price',
              //     prefixIcon: Icon(Icons.attach_money),
              //   ),
              //   keyboardType: TextInputType.number,
              // ),
              // SizedBox(height: 16),
              // TextFormField(
              //   decoration: InputDecoration(
              //     labelText: 'Stock',
              //     prefixIcon: Icon(Icons.inventory),
              //   ),
              //   keyboardType: TextInputType.number,
              // ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget optionsPick(List<Product> product, int index) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Media:',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 100.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: product.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                width: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(128),
                      blurRadius: 5.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(product.first.media.first.url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      )
    ]);
  }

  Widget _mediaGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          shrinkWrap: true,
          itemCount: _media.length + 1,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final isAdd = index == _media.length;
            if (isAdd) {
              return _AddTile(onTap: _saveImage);
            }
            return _MediaTile(
                onRemove: () => setState(() => _media.removeAt(index)),
                media: _media);
          },
        ),
        const SizedBox(height: 8),
        const Text(
          'Tip: First image will be used as the cover.',
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }

  Future<void> _saveImage() async {
    try {
      // Get temporary directory
      final Directory dir = await getApplicationDocumentsDirectory();
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      PlatformFile platformFile = result!.files.first;
      final String filenam =
          'images${DateTime.now().millisecond}.${platformFile.extension}';
      var paths = '${dir.path}/$filenam';
      // Save to filesystem
      final File file = File(platformFile.path!);
      // final File newimage = await file.copy(paths);

      // print("imagepath =${newimage.uri}");
      // var url=(newimage.uri).toString();

      // _pickMedia(filenam);
      _pickMedia('assets/images/image2.jpg');
    } catch (e) {
      print(e);
    }
  }

  Widget _publishSection(Color onBg) {
    return Column(
      children: [
        _KVRow(
          label: 'Published',
          trailing: Switch(
            value: _published,
            onChanged: (v) => setState(() => _published = v),
          ),
        ),
        const Divider(height: 16),
        _KVRow(
          label: 'Schedule',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _scheduleDate == null
                    ? 'Not scheduled'
                    : '${_scheduleDate!.year}-${_scheduleDate!.month.toString().padLeft(2, '0')}-${_scheduleDate!.day.toString().padLeft(2, '0')}',
                style: TextStyle(color: Colors.black.withOpacity(.7)),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: _pickSchedule,
                icon: const Icon(Icons.event_outlined),
                label: const Text('Pick'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFFF6D00),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'If scheduled, the product becomes visible on that date.',
            style: TextStyle(fontSize: 12, color: onBg.withOpacity(.6)),
          ),
        ),
      ],
    );
  }

  Widget _categoryChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _allCategoriess.map((c) {
        final selected = _selectedCategories.contains(c.id);
        return ChoiceChip(
          label: Text(c.name),
          selected: selected,
          onSelected: (_) {
            setState(() {
              if (selected) {
                _selectedCategories.remove(c.id);
              } else {
                _selectedCategories.add(c.id!);
              }
            });
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          selectedColor: const Color(0xFFFFE0B2),
          labelStyle: TextStyle(
            color: selected ? const Color(0xFFBF360C) : Colors.black87,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
          backgroundColor: const Color(0xFFF3F4F7),
        );
      }).toList(),
    );
  }

  Widget _atterbuteClip() {
    String? selectedNodeId;

    return Wrap(spacing: 8, runSpacing: 8, children: [
      TreeNodeWidget(
        node: sampleTreeData(),
        selectedNodeId: selectedNodeId,
        onNodeSelected: (nodeId) {
          setState(() {
            selectedNodeId = nodeId;
          });
        },
      ),
    ]);
  }

  Widget _brandDropdown(Color bg, Color onBg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _brand,
          items: _brandss
              .map((b) => DropdownMenuItem(
                    value: b.id,
                    child: Row(
                      children: [
                        const Icon(Icons.local_fire_department_outlined,
                            size: 18),
                        const SizedBox(width: 8),
                        Text(b.name),
                      ],
                    ),
                  ))
              .toList(),
          onChanged: (v) => setState(() => _brand = v),
          isExpanded: true,
          icon: const Icon(Icons.expand_more),
        ),
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  final VoidCallback onTap;
  const _AddTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: DottedBorder(
        radius: const Radius.circular(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add_photo_alternate_outlined, size: 28),
              SizedBox(height: 6),
              Text('Add', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class _MediaTile extends StatelessWidget {
  final VoidCallback onRemove;
  final List<String> media;

  const _MediaTile({required this.onRemove, required this.media});

  @override
  Widget build(BuildContext context) {
    Iterator<String> m = media.iterator;
    m.moveNext();
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F7),
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(
                  media.isNotEmpty ? m.current : "assets/images/image3.jpg"),
              fit: BoxFit.cover, // replace with your actual image
            ),
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: InkWell(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.55),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

// ====== Reusable UI Widgets ======

class _SectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  const _SectionCard({
    required this.title,
    required this.child,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.apps_outlined, color: Color(0xFFFF6D00)),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!,
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _FilePick extends StatelessWidget {
  const _FilePick();

  @override
  Widget build(BuildContext context) {
    return FormBuilderFilePicker(
        name: "images",
        decoration: InputDecoration(labelText: "Attachments"),
        maxFiles: null,
        previewImages: true,
        onChanged: (val) =>
            // _saveImage(),

            imags.add(val!.first),
        // onSaved: (newValue) => ,
        typeSelectors: [
          TypeSelector(
            type: FileType.any,
            selector: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.add_circle),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Add documents"),
                ),
              ],
            ),
          ),
        ],
        onFileLoading: (val) {
          media.add(val as String);
        },
        onSaved: (newValue) {
          imags.add(newValue!.single);
        });
  }
}

class _KVRow extends StatelessWidget {
  final String label;
  final Widget trailing;
  const _KVRow({required this.label, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
          trailing,
        ],
      ),
    );
  }
}

/// Simple dotted border without external packages.
class DottedBorder extends StatelessWidget {
  final Widget child;
  final Radius radius;
  const DottedBorder(
      {super.key, required this.child, this.radius = Radius.zero});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: _DashedBorder(radius),
      ),
      child: ClipRRect(borderRadius: BorderRadius.all(radius), child: child),
    );
  }
}

class _DashedBorder extends RoundedRectangleBorder {
  _DashedBorder(Radius radius) : super(borderRadius: BorderRadius.all(radius));

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final rrect = borderRadius.resolve(textDirection).toRRect(rect);
    final path = Path()..addRRect(rrect);
    final paint = Paint()
      ..color = const Color(0xFFBDBDBD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final len = distance + dashWidth < metric.length
            ? dashWidth
            : metric.length - distance;
        final extract = metric.extractPath(distance, distance + len);
        canvas.drawPath(extract, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }
}
