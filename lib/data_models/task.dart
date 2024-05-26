class Task {
  final String id;
  final String title;
  Task({
    required this.id,
    required this.title,
  });

  Task copyWith({
    String? id,
    String? title,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
    );
  }
  @override
  String toString() => 'Task(id: $id, title: $title)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
