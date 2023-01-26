class TodoModel {
  String title;
  bool done;

  TodoModel({required this.title, required this.done});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(title: json['title'] ?? '', done: json['done'] ?? true);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['done'] = done;
    return data;
  }
}
