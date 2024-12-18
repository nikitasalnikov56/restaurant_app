import 'package:dio/dio.dart';
import 'package:test_app/data/models/products.dart';

class Api {
  static final dio = Dio();
  static List<Product> products = [];

//methods
  static Future<List<Product>> getProducts() async {
    final response = await dio.get('https://fakestoreapi.com/products');
    try {
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        products = data.map((items) => Product.fromJson(items)).toList();
        return products;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        products = data.map((items) => Product.fromJson(items)).toList();
        return products;
      } else {
        throw Exception('Error: $e');
      }
    }
  }
}
