class AssignmentModel {
  final int? id;
  final String tableName;
  final String waiterName;

  AssignmentModel({this.id, required this.tableName, required this.waiterName});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tableName': tableName,
      'waiterName': waiterName,
    };
  }

  factory AssignmentModel.fromMap(Map<String, dynamic> map) {
    return AssignmentModel(
      id: map['id'],
      tableName: map['tableName'],
      waiterName: map['waiterName'],
    );
  }
}
