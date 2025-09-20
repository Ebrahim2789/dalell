import 'dart:async';
import 'package:dalell/container/info_page.dart';
import 'package:dalell/container/listdemo.dart';
import 'package:dalell/product/models/product.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
//in main.dart write this:
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {

  static const table = 'Product';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  /// singleton pattern

  static Database? _database;

  /// gets database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// initialize the database
  Future<Database> _initDatabase() async {
    print('createing databse');
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'taskino.db');
    print('path is $path');
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Product ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "description TEXT,"
        "price INTEGER,"
        "imageUrl TEXT"
        ")");
    await db.execute(
        "INSERT INTO Product ('id', 'name', 'description', 'price','imageUrl') values (?, ?, ?, ?, ?)",
        [1, "iPhone", "iPhone is the stylist phone ever", 1000, "iphone.png"]);
    await db.execute(
        "INSERT INTO Product ('id', 'name', 'description', 'price','imageUrl') values (?, ?, ?, ?, ?)",
        [2, "Pixel", "Pixel is the most feature phone ever", 800, "pixel.png"]);
    await db.execute(
        "INSERT INTO Product ('id', 'name', 'description', 'price','imageUrl') values (?, ?, ?, ?, ?)",
        [
          3,
          "Laptop",
          "Laptop is most productive development tool",
          2000,
          "laptop.png"
        ]);
    await db.execute(
        "INSERT INTO Product ('id', 'name', 'description', 'price','imageUrl') values (?, ?, ?, ?, ?)",
        [
          4,
          "Tablet",
          "Laptop is most productive development tool",
          1500,
          "tablet.png"
        ]);
    await db.execute(
        "INSERT INTO Product ('id', 'name', 'description', 'price','imageUrl') values (?, ?, ?, ?, ?)",
        [
          5,
          "Pendrive",
          "Pendrive is useful storage medium",
          100,
          "pendrive.png"
        ]);
    await db.execute(
        "INSERT INTO Product ('id', 'name', 'description', 'price','imageUrl') values (?, ?, ?, ?, ?)",
        [
          6,
          "Floppy Drive",
          "Floppy drive is useful rescue storage medium",
          20,
          "floppy.png"
        ]);
  }

  Future<int> insert(Product product) async {
    Database db = await instance.database;
    return await db.insert(table, product.toMap());
  }

  Future<List<Product>> getAllProducts() async {
    final Database db = await instance.database;
    List<Map<String, Object?>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  Future<List<Product>> getProducts() async {
    final Database db = await instance.database;
    var data = await db.rawQuery('SELECT * FROM Product');
    List<Product> product =
        List.generate(data.length, (index) => Product.fromMap(data[index]));
    print(product.length);
    return product;
  }

  Future<void> insertProduct(Product product) async {
    final db = await instance.database;

    var data = await db.rawInsert(
        'INSERT INTO Product(id, name, description, price,imageUrl)  VALUES(?,?,?,?,?)',
        [
          product.id,
          product.name,
          product.description,
          product.price,
   
        ]);
    log('inserted $data');
  }

  void log(String s) {
    print(s);
  }


    Future<void> editProduct(Product product) async {
    final db = await instance.database;
    var data = await db.rawUpdate(
        'UPDATE Product SET name=?,description=?,price=? WHERE ID=?',
        [product.name, product.description, product.price, product.id]);
    log('updated $data');
  }
  Future<void> deleteProduct(String id) async {
    final db = await instance.database;
    var data = await db.rawDelete('DELETE from Product WHERE id=?', [id]);
    log('deleted $data');
  }
}

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;
  await DatabaseHelper.instance._initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _itemPressed(BuildContext context, ListData item) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => InfoPage(item: item),
        ),
      );
  final dbHelper = DatabaseHelper.instance;
  List<Product> _product = [];

  @override
  void initState() {
    super.initState();
    // _loadProduct();
    _getProduct();
  }

  void _loadProduct() async {
    List<Product> products = await dbHelper.getAllProducts();
    setState(() {
      _product = products;
    });
  }

  void _getProduct() async {
    List<Product> products = await dbHelper.getProducts();
    setState(() {
      _product = products;
    });

    if (_product.isNotEmpty) {
      print(_product.length);
    }
  }

  void _addProduct() async {
    Product newProduct = Product(
      id: 600,
      name: "name",
      description: "description",
      price: 78,

    );
    // final product =
     await dbHelper.insertProduct(newProduct);

    _getProduct();
    // setState(() {
    //   _product.add(newProduct);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('data'),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int count) {
            return ListTile(
                title: Text(_product[count].name),
                leading: const Icon(Icons.star_border),
                onTap: () => ());
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: _product.length,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addProduct();
            },
            child: const Icon(Icons.add)),
      ),
    );
  }
}


    class User {
      final int? id;
      final String name;
      final String email;

      User({this.id, required this.name, required this.email});

      Map<String, dynamic> toMap() {
        return {
          'id': id,
          'name': name,
          'email': email,
        };
      }

      factory User.fromMap(Map<String, dynamic> map) {
        return User(
          id: map['id'],
          name: map['name'],
          email: map['email'],
        );
      }
    }