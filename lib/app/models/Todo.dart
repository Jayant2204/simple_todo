class Todo {
  String title;
  String description;
  DateTime createdAt;
  bool isFinished;

  Todo({
    this.title,
    this.description,
    this.createdAt,
    this.isFinished,
  });

  factory Todo.fromMap(Map<String, dynamic> map) => Todo(
        title: map["title"],
        description: map["description"],
        createdAt: DateTime.parse(map["createdAt"]),
        isFinished: map["isFinished"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "isFinished": isFinished,
      };
}
