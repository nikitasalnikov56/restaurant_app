import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/data/repositories/table_repository.dart';
import 'package:test_app/ui/blocks/table_bloc/table_bloc.dart';
import 'package:test_app/ui/pages/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => TableBloc(TableRepository()),
      child: const MaterialApp(
        title: 'Restaurant Booking',
        home: DefaultTabController(
          length: 1,
          child: HomeScreen(),
        ),
      ),
    );
  }
}
