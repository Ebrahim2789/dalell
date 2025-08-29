// db/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("productss125.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // print(path);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE brands(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      logoUrl TEXT
    );
    ''');

    await db.execute('''
    CREATE TABLE categories(
     id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT
    );
    ''');

    await db.execute('''
    CREATE TABLE products(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      description TEXT,
      brandId INTEGER,
      categoryId INTEGER,
      price REAL,
      FOREIGN KEY (brandId) REFERENCES brands(id),
      FOREIGN KEY (categoryId) REFERENCES categories(id)
    );
    ''');

    await db.execute('''
    CREATE TABLE media(
     id INTEGER PRIMARY KEY AUTOINCREMENT,
    productid INTEGER NOT NULL,
      url TEXT ,
      type TEXT,
     FOREIGN KEY (productid) REFERENCES products(id) ON DELETE CASCADE
    );
    ''');

    await db.execute('''
    CREATE TABLE attributes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      productId INTEGER ,
      name TEXT,
      FOREIGN KEY (productId) REFERENCES products(id)
    );
    ''');

    await db.execute('''
    CREATE TABLE attribute_options(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      attributeId INTEGER,
      value TEXT,
      FOREIGN KEY (attributeId) REFERENCES attributes(id)
    );
    ''');

    await db.execute('''
CREATE TABLE orders(
  id INTEGER PRIMARY KEY,
  productId INTEGER,
  quantity INTEGER,
  total REAL,
  status TEXT,
  createdAt TEXT,
  addressId INTEGER,
  FOREIGN KEY(addressId) REFERENCES addresses(id),
    FOREIGN KEY (productId) REFERENCES products(id)
);
''');
    await db.execute('''
CREATE TABLE addresses(
  id INTEGER PRIMARY KEY,
  customerName TEXT,
  phone TEXT,
  city TEXT,
  street TEXT,
  zipCode TEXT
);
''');

    await db.execute('''
CREATE TABLE deliveries(
  id INTEGER PRIMARY KEY,
  orderId INTEGER NOT NULL,
  address TEXT,
  status TEXT,
  deliveredAt TEXT,
  FOREIGN KEY (orderId) REFERENCES orders(id)
);
''');
  }
}
