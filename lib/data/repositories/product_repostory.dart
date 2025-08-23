import 'package:dalell/data/models/product.dart';

import '../../utils/result.dart';
import '../services/database_service.dart';

// #docregion ProductRepository
class ProductRepository {
  ProductRepository({required DatabaseService database}) : _database = database;

  final DatabaseService _database;

  Future<Result<List<Product>>> fetchProducts() async {
    if (!_database.isOpen()) {
      await _database.open();
    }
    return _database.getAll();
  }

  Future<Result<Product>> createProduct(String task) async {
    if (!_database.isOpen()) {
      await _database.open();
    }
    return _database.insert(task);
  }

  Future<Result<void>> deleteProduct(int id) async {
    if (!_database.isOpen()) {
      await _database.open();
    }
    return _database.delete(id);
  }
}

// #enddocregion ProductRepository


