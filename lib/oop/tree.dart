import 'package:flutter/material.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beautiful Tree UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        // Define a clean, modern theme
        scaffoldBackgroundColor: Colors.grey[100],

        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      home: const TreeViewScreen(),
    );
  }
}

class TreeViewScreen extends StatefulWidget {
  const TreeViewScreen({super.key});

  @override
  State<TreeViewScreen> createState() => _TreeViewScreenState();
}

class _TreeViewScreenState extends State<TreeViewScreen> {
  // Track the selected node
  String? selectedNodeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tree View UI'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Build the tree with sample data
            TreeNodeWidget(
              node: sampleTreeData(),
              selectedNodeId: selectedNodeId,
              onNodeSelected: (nodeId) {
                setState(() {
                  selectedNodeId = nodeId;
                });
              },
            ),
          ],
        ),
      ),
    );
  }


}

// Widget to render a tree node
class TreeNodeWidget extends StatelessWidget {
  final TreeNode node;
  final String? selectedNodeId;
  final Function(String) onNodeSelected;

  const TreeNodeWidget({
    super.key,
    required this.node,
    required this.selectedNodeId,
    required this.onNodeSelected,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedNodeId == node.id;

    return Card(
      // Highlight selected node with a different color
      color: isSelected ? Colors.blue[100] : Colors.white,
      child: ExpansionTile(
        // Customize the expansion tile for a beautiful UI
        leading: Icon(
          node.children.isNotEmpty ? Icons.category : Icons.label,
          color: isSelected ? Colors.blue : Colors.grey[600],
        ),
        title: Text(
          node.label,
          style: TextStyle(
            color: isSelected ? Colors.blue[800] : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Icon(
          Icons.arrow_drop_down,
          color: isSelected ? Colors.blue : Colors.grey[600],
        ),
        // Add padding to children for indentation
        childrenPadding: const EdgeInsets.only(left: 16),
        // Control the expansion animation
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.centerLeft,
        // Build child nodes recursively
        children: node.children.map((child) {
          return TreeNodeWidget(
            node: child,
            selectedNodeId: selectedNodeId,
            onNodeSelected: onNodeSelected,
          );
        }).toList(),
        // Handle tap to select the node
        onExpansionChanged: (expanded) {
          if (!expanded) {
            onNodeSelected(node.id);
          }
        },
      ),
    );
  }
}


  // Sample tree data
  TreeNode sampleTreeData() {
    return TreeNode(
      id: 'root',
      label: 'Categories',
      children: [
        TreeNode(
          id: 'cat1',
          label: 'Electronics',
          children: [
            TreeNode(id: 'cat1-1', label: 'Phones'),
            TreeNode(id: 'cat1-2', label: 'Laptops'),
            TreeNode(
              id: 'cat1-3',
              label: 'Accessories',
              children: [
                TreeNode(id: 'cat1-3-1', label: 'Chargers'),
                TreeNode(id: 'cat1-3-2', label: 'Headphones'),
              ],
            ),
          ],
        ),
        TreeNode(
          id: 'cat2',
          label: 'Clothing',
          children: [
            TreeNode(id: 'cat2-1', label: 'Men'),
            TreeNode(id: 'cat2-2', label: 'Women'),
          ],
        ),
      ],
    );
  }

// Model for a tree node
class TreeNode {
  final String id;
  final String label;
  final List<TreeNode> children;

  TreeNode({
    required this.id,
    required this.label,
    this.children = const [],
  });
}