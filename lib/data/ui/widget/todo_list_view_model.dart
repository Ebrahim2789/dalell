import 'package:dalell/data/models/product.dart';
import 'package:dalell/data/repositories/product_repostory.dart';
import 'package:dalell/utils/command.dart';
import 'package:flutter/material.dart';

import '../../../utils/result.dart';

class ProductListViewModel extends ChangeNotifier {
  ProductListViewModel({required ProductRepository ProductRepository})
      : _ProductRepository = ProductRepository {
    load = Command0<void>(_load)..execute();
    add = Command1<void, String>(_add);
    delete = Command1<void, int>(_delete);
  }

  final ProductRepository _ProductRepository;

  /// Load Product items from repository.
  late Command0<void> load;

  /// Add a new Product item.
  late Command1<void, String> add;

  /// Delete a Product item by its id.
  late Command1<void, int> delete;

  // #docregion ProductListViewModel
  List<Product> _Products = [];

  List<Product> get Products => _Products;

  Future<Result<void>> _load() async {
    try {
      final result = await _ProductRepository.fetchProducts();
      switch (result) {
        case Ok<List<Product>>():
          _Products = result.value;
          return Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
  // #enddocregion ProductListViewModel

  // #docregion Add
  Future<Result<void>> _add(String task) async {
    try {
      final result = await _ProductRepository.createProduct(task);
      switch (result) {
        case Ok<Product>():
          _Products.add(result.value);
          return Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
  // #enddocregion Add

  // #docregion Delete
  Future<Result<void>> _delete(int id) async {
    try {
      final result = await _ProductRepository.deleteProduct(id);
      switch (result) {
        case Ok<void>():
          _Products.removeWhere((Product) => Product.id == id);
          return Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  // #enddocregion Delete
}
