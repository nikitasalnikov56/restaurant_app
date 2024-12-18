import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/ui/blocks/table_bloc/table_bloc.dart';
import 'package:test_app/ui/constants/constants.dart';
import 'package:test_app/ui/pages/menu_screen.dart';
import 'package:test_app/ui/style/app_colors.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableBloc, TableState>(
      builder: (context, state) {
        return GridView.builder(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: tables.length,
          itemBuilder: (context, index) {
            final table = tables[index];
            final waiterName = state.tableAssignments[table] ?? 'Не назначен';

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuScreen(
                      tableName: table,
                    ),
                  ),
                );
              },
              child: GridTile(
                footer: DecoratedBox(
                  decoration: BoxDecoration(
                    color: waiterName != 'Не назначен'
                        ? AppColors.green
                        : AppColors.grey,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    height: 20,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          table,
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        waiterName,
                        style: const TextStyle(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
