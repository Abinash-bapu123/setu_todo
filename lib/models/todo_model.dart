class TodoModel {
  int id;
  String? todoItem;
  String? createdDate;
  TodoModel({
    required this.id,
    required this.todoItem,
    required this.createdDate,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todoItem: json['todoItem'],
      createdDate: json['createdDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoItem': todoItem,
      'createdDate': createdDate,
    };
  }
}
