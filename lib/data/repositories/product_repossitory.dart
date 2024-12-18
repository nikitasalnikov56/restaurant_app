import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/products.dart';

class ProductRepository {
  late Database db;

  Future<void> init() async {
    final dbPath = join(await getDatabasesPath(), 'restaurant.db');
    // await deleteDatabase(dbPath);
    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT, tableName TEXT, productId INTEGER, title TEXT, price REAL, description TEXT, image TEXT)',
        );
      },
    );
  }

  Future<List<Product>> getProducts() async {
    // Выполняем запрос к таблице 'products', чтобы получить все продукты
    final List<Map<String, dynamic>> maps = await db.query('cart');

    // Преобразуем результат в список объектов Product
    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'], // Получаем описание из базы данных
        imageUrl: maps[i]
            ['imageUrl'], // Получаем URL изображения из базы данных
      );
    });
  }

  Future<void> addProductToCart(Product product, String tableName) async {
    await db.insert(
      'cart',
      {
        'tableName': tableName,
        'productId': product.id,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'image': product.imageUrl
      },
    );
  }

  Future<List<Product>> getCartItems(String tableName) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'cart',
      where: 'tableName = ?',
      whereArgs: [tableName],
    );
    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['productId'],
        title: maps[i]['productName'],
        price: maps[i]['productPrice'],
        imageUrl: '',
        description:
            '', // Заполните этот параметр в зависимости от вашего дизайна
      );
    });
  }
}
