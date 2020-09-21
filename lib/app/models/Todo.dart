class Todo {
  String title;
  String description;
  DateTime createdAt;
  DateTime modifiedAt;
  bool isFinished;

  Todo({
    this.title,
    this.description,
    this.createdAt,
    this.modifiedAt,
    this.isFinished,
  });

  factory Todo.fromMap(Map<String, dynamic> map) => Todo(
        title: map["title"],
        description: map["description"],
        createdAt: DateTime.parse(map["createdAt"]),
        modifiedAt: DateTime.parse(map["modifiedAt"]),
        isFinished: map["isFinished"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "modifiedAt": modifiedAt.toIso8601String(),
        "isFinished": isFinished,
      };
}
