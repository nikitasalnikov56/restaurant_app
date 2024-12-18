part of 'table_bloc.dart';


class TableState {
  final Map<String, String> tableAssignments;

  TableState({required this.tableAssignments});

  TableState copyWith({Map<String, String>? tableAssignments}) {
    return TableState(
      tableAssignments: tableAssignments ?? this.tableAssignments,
    );
  }
}