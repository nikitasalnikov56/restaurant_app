import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_app/data/repositories/table_repository.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final TableRepository tableRepository;

  TableBloc(this.tableRepository) : super(TableState(tableAssignments: {})) {
    tableRepository.init().then((_) {
      add(LoadTables());
    });
    on<AssignWaiterToTable>((event, emit) async {
      try {
        print(
            'Assigning waiter ${event.waiter} to table ${event.table}'); // Лог для отслеживания данных
        final newAssignments = Map<String, String>.from(state.tableAssignments);
        newAssignments[event.table] = event.waiter;
        emit(state.copyWith(tableAssignments: newAssignments));

        // Сохранение данных в базу данных
        await tableRepository.assignWaiter(event.table, event.waiter);
      } catch (e) {
        print("Ошибка при назначении официанта: $e");
      }
    });

    // Загрузка данных из базы данных при старте
  on<LoadTables>((event, emit) async {
  try {
    final assignments = await tableRepository.getAssignments();
    final Map<String, String> loadedAssignments = {
      for (var assignment in assignments)
        assignment.tableName: assignment.waiterName,
    };
    print('Загруженные назначения: $loadedAssignments');
    emit(state.copyWith(tableAssignments: loadedAssignments));
  } catch (e) {
    print('Ошибка при загрузке данных: $e');
  }
});

  }
}
