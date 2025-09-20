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
          node.label!,
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
    label: 'Attribute',
    children: [
      TreeNode(
        id: '1',
        label: 'Color',
        children: [
          TreeNode(id: '1-1', label: 'Black'),
          TreeNode(id: '1-2', label: 'White'),
        ],
      ),
      TreeNode(
        id: '2',
        label: 'Storage',
        children: [
          TreeNode(id: '2-1', label: '128GB'),
          TreeNode(id: '2-2', label: '256GB'),
        ],
      ),
      TreeNode(
        id: '3',
        label: 'Battery',
        children: [
          TreeNode(id: '3-1', label: '5000Amh'),
          TreeNode(id: '3-2', label: '7000Ahm'),
        ],
      ),
    ],
  );
}
void addChild(TreeNode parent, TreeNode child){
  child.parent=parent;
  parent.children.add(child);
}
void selectedPranet(TreeNode child){
  if (child.parent!=null) {
    print("prant of ${child.label} is${child.parent!.label}");
    
  }
  else{
     print("${child.label} has no pranet");
  }
}

TreeNode? findParent(TreeNode root,TreeNode child){
  for (var i in root.children) {
    if (i==child) {
return root;      
    }
    var result=findParent(i, child);
    if(result!=null) return result;
    
  }
  return null;
}
// Model for a tree node
class TreeNode {
  final String id;
  final String? label;
  TreeNode? parent;
  final List<TreeNode> children;

  TreeNode({
    required this.id,
     this.label,
    this.parent,
    this.children = const [],
  });
}
