part of 'table_bloc.dart';

@immutable
sealed class TableEvent {}


class AssignWaiterToTable extends TableEvent {
  final String table;
  final String waiter;

  AssignWaiterToTable(this.table, this.waiter);
}
class LoadTables extends TableEvent {} 