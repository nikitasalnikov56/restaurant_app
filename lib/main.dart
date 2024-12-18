import 'package:flutter/material.dart';
import 'package:test_app/data/repositories/product_repossitory.dart';
import 'package:test_app/data/repositories/table_repository.dart';
import 'package:test_app/my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  final tableRepository = TableRepository();
  final productRepository = ProductRepository();
  await tableRepository.init();
  await productRepository.init();
  runApp(const MyApp());
}

