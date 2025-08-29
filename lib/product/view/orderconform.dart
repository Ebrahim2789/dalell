import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:path_provider/path_provider.dart';

final List<String> media = [];

List<PlatformFile> imags=[];
class ProductEditorPage extends StatefulWidget {
  const ProductEditorPage({super.key});

  @override
  State<ProductEditorPage> createState() => _ProductEditorPageState();
}

class _ProductEditorPageState extends State<ProductEditorPage> {
  // ---- Mock data / state ----
  // final List<String> media = []; // store paths/urls/base64 after you hook it up
  bool _published = true;
  DateTime? _scheduleDate;

  final List<String> _allCategories = const [
    'Perfume',
    'Cosmetics',
    'Gifts',
    'Men',
    'Women',
    'Premium',
    'New'
  ];
  final Set<String> _selectedCategories = {'Perfume', 'New'};

  final List<String> _brands = const [
    'LTA',
    'Noura',
    'AromaX',
    'EthiScent',
    'Dahlia'
  ];
  String? _brand = 'LTA';

  // ---- Helpers ----
  Future<void> _pickMedia() async {
    setState(() => media.add(""));
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
              child: Column(
                children: [
                  _SectionCard(
                    title: 'Products Media',
                    subtitle: 'Images & videos that represent this product',
                    child: 
                    _FilePick(),
                    // _mediaGrid(),
                  ),
                  const SizedBox(height: 14),
                  _SectionCard(
                    title: 'Products Publish',
                    subtitle: 'Control visibility & schedule',
                    child: _publishSection(onBg),
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
                  const SizedBox(height: 100),
                ],
              ),
            ),
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
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _save,
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

  // ---- UI Pieces ----
  Widget _mediaGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          shrinkWrap: true,
          itemCount: media.length + 1,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final isAdd = index == media.length;
            if (isAdd) {
              return _AddTile(onTap: _pickMedia);
            }
            return _MediaTile(
              onRemove: () => setState(() => media.removeAt(index)),
            );
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
      children: _allCategories.map((c) {
        final selected = _selectedCategories.contains(c);
        return ChoiceChip(
          label: Text(c),
          selected: selected,
          onSelected: (_) {
            setState(() {
              if (selected) {
                _selectedCategories.remove(c);
              } else {
                _selectedCategories.add(c);
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

  Widget _brandDropdown(Color bg, Color onBg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _brand,
          items: _brands
              .map((b) => DropdownMenuItem(
                    value: b,
                    child: Row(
                      children: [
                        const Icon(Icons.local_fire_department_outlined,
                            size: 18),
                        const SizedBox(width: 8),
                        Text(b),
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
      onChanged: (val) => print(val),
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
           
        
          _saveImage(imags.single);

        print(val.name);
      },
      onSaved: (newValue) {
        imags.add(newValue!.single);
        
          _saveImage(imags.single);
      }
    );
  }
}

 String? message;

  Future<void> _saveImage(PlatformFile imageUrl) async {
    try {
      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/image.png';

      // Save to filesystem
      final file = File(filename);
      // await file.writeAsBytes(imageUrl.);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
    } catch (e) {
      message = 'An error occurred while saving the image';
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
        radius: Radius.circular(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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

Future<void> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image, // Or .image, .video, .audio, .media
    // allowedExtensions: ['jpeg', 'jpg', 'png'], // Specify allowed extensions for custom type
    allowMultiple: false, // Set to true to allow multiple file selection
  );

  if (result != null) {
    // Access the selected file(s)
    PlatformFile file = result.files.first; // For single file selection
    print('Selected file name: ${file.name}');
    print('Selected file path: ${file.path}');
    // Further processing of the file can be done here
  } else {
    // User canceled the picker
    print('File picking canceled.');
  }
}

class _MediaTile extends StatefulWidget {
  final VoidCallback onRemove;
  const _MediaTile({required this.onRemove});

  @override
  State<_MediaTile> createState() => _MediaTileState();
}

class _MediaTileState extends State<_MediaTile> {
  String imageurl = "assets/images/iphone.png";
  String? message;

  Future<void> _saveImage(String imageUrl) async {
   
    setState(() {
      imageurl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F7),
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(imageurl),
              fit: BoxFit.cover, // replace with your actual image
            ),
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: InkWell(
            onTap: widget.onRemove,
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




// This gives you a modern rounded popup with a warning icon, customizable text, and a true/false return so you can handle the user’s decision easily.

// 👉 Do you want me to also make a custom-styled bottom sheet confirmation popup (instead of AlertDialog) for a more modern mobile feel?

// Notes to integrate later

// Media: connect _pickMedia() with image_picker/file_picker and push actual file paths into _media. Replace AssetImage('assets/placeholder-image.png').

// Publish: if _published is false but you set a schedule date, treat it as “scheduled publish”.

// Brand/Category: wire to your models; the UI gives you Set<String> and a String? for brand.


// Want this converted to a GetX/Bloc version or split into reusable widgets for your design system?
