import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/ui/blocks/table_bloc/table_bloc.dart';
import 'package:test_app/ui/constants/constants.dart';

class AssignWaiterScreen extends StatelessWidget {
  const AssignWaiterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Назначить официанта')),
      body: ListView.builder(
        itemCount: tables.length,
        itemBuilder: (context, index) {
          final table = tables[index];
          return ListTile(
            title: Text(table),
            trailing: DropdownButton<String>(
              value: context.read<TableBloc>().state.tableAssignments[table],
              hint: const Text('Выберите официанта'),
              items: names.map((waiter) {
                return DropdownMenuItem<String>(
                  value: waiter,
                  child: Text(waiter),
                );
              }).toList(),
              onChanged: (value) {
                context
                    .read<TableBloc>()
                    .add(AssignWaiterToTable(table, value!));
              },
            ),
          );
        },
      ),
    );
  }
}
