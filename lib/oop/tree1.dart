

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beautiful Flutter Tree UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.grey[100],
        expansionTileTheme: ExpansionTileThemeData(
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          iconColor: Colors.deepPurple,
          collapsedIconColor: Colors.deepPurpleAccent,
          textColor: Colors.black87,
          collapsedTextColor: Colors.black87,
        ),
      ),
      home: const AttributeTreeScreen(),
    );
  }
}

class AttributeTreeScreen extends StatefulWidget {
  const AttributeTreeScreen({super.key});

  @override
  State<AttributeTreeScreen> createState() => _AttributeTreeScreenState();
}

class _AttributeTreeScreenState extends State<AttributeTreeScreen> {
  // Data model for the tree
  

  // List to keep track of selected options
  final List<String> _selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attribute Selection Tree'),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: buildTree(treeNodes),
            ),
          ),
          _buildSelectedOptions(),
        ],
      ),
    );
  }

  // Recursive function to build the tree UI
  List<Widget> buildTree(List<TreeNode> nodes, {int level = 0}) {
    return nodes.map((node) {
      if (node.isLeaf) {
        // Leaf node: Checkbox for selection
        return Padding(
          padding: EdgeInsets.only(left: 16.0 * level),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: CheckboxListTile(
              title: Text(node.title, style: const TextStyle(fontSize: 16)),
              value: _selectedOptions.contains(node.title),
              activeColor: Colors.deepPurple,
              checkColor: Colors.white,
              onChanged: (bool? selected) {
                setState(() {
                  if (selected == true) {
                    _selectedOptions.add(node.title);
                  } else {
                    _selectedOptions.remove(node.title);
                  }
                });
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        );
      } else {
        // Parent node: ExpansionTile
        return Padding(
          padding: EdgeInsets.only(left: 16.0 * level),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              leading: Icon(Icons.category, color: Colors.deepPurpleAccent),
              title: Text(node.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              children: buildTree(node.children, level: level + 1),
            ),
          ),
        );
      }
    }).toList();
  }

  // Bottom section to show selected options
  Widget _buildSelectedOptions() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, -2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Selected Options:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedOptions.map((option) => Chip(
              label: Text(option),
              backgroundColor: Colors.deepPurple[100],
              labelStyle: const TextStyle(color: Colors.deepPurple),
              deleteIconColor: Colors.deepPurple,
              onDeleted: () {
                setState(() {
                  _selectedOptions.remove(option);
                });
              },
            )).toList(),
          ),
        ],
      ),
    );
  }
}

final List<TreeNode> treeNodes = [
    TreeNode(
      title: 'Color',
      children: [
        TreeNode(title: 'Red', isLeaf: true),
        TreeNode(title: 'Blue', isLeaf: true),
        TreeNode(title: 'Green', isLeaf: true),
      ],
    ),
    TreeNode(
      title: 'Size',
      children: [
        TreeNode(title: 'Small', isLeaf: true),
        TreeNode(title: 'Medium', isLeaf: true),
        TreeNode(title: 'Large', isLeaf: true),
      ],
    ),
    TreeNode(
      title: 'Material',
      children: [
        TreeNode(title: 'Cotton', isLeaf: true),
        TreeNode(title: 'Wool', isLeaf: true),
        TreeNode(title: 'Synthetic', isLeaf: true),
      ],
    ),
  ];

// Data model class
class TreeNode {
  final String title;
  final List<TreeNode> children;
  final bool isLeaf;

  TreeNode({
    required this.title,
    this.children = const [],
    this.isLeaf = false,
  });
}

