class TableModel {
  final int id;
  final String name;
  final String status; // 'free', 'booked', 'other'

  TableModel({required this.id, required this.name, required this.status});

  TableModel copyWith({int? id, String? name, String? status}){
   return TableModel(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
   );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'status': status};
  }

  static TableModel fromMap(Map<String, dynamic> map) {
    return TableModel(
      id: map['id'],
      name: map['name'],
      status: map['status'],
    );
  }
}
