

import 'package:dalell/data/ui/widget/todo_list_view_model.dart';
import 'package:flutter/material.dart';


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.viewModel});

  final ProductListViewModel viewModel;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    widget.viewModel.add.addListener(_onAdd);
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.viewModel.add.removeListener(_onAdd);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          // #docregion ListenableBuilder
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, child) {
              return ListView.builder(
                itemCount: widget.viewModel.Products.length,
                itemBuilder: (context, index) {
                  final Product = widget.viewModel.Products[index];
                  return ListTile(
                    title: Text(Product.description),
                    // #docregion Delete
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => widget.viewModel.delete.execute(Product.id),
                    ),
                    // #enddocregion Delete
                  );
                },
              );
            },
          ),
          // #enddocregion ListenableBuilder
        ),
        Material(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Add a new task',
                    ),
                  ),
                ),
                // #docregion FilledButton
                FilledButton.icon(
                  onPressed: () =>
                      widget.viewModel.add.execute(_controller.text),
                  label: const Text('Add'),
                  icon: const Icon(Icons.add),
                ),
                // #enddocregion FilledButton
              ],
            ),
          ),
        ),
      ],
    );
  }

  // #docregion Add
  void _onAdd() {
    // Clear the text field when the add command completes.
    if (widget.viewModel.add.completed) {
      widget.viewModel.add.clearResult();
      _controller.clear();
    }
  }

  // #enddocregion Add
}