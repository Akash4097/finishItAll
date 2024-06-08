import 'activity.dart';
import 'tag.dart';

class Task extends Activity {
  final DateTime dueDate;
  final double totalTime;
  final List<Tag>? tags;
  Task({
    required this.dueDate,
    required super.id,
    required super.title,
    required super.createdAt,
    this.tags,
    this.totalTime = 0.0,
    Status status = Status.idle,
    super.updatedAt,
    super.description,
  });

  Task copyWith({
    DateTime? dueDate,
    double? totalTime,
    List<Tag>? tags,
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    Status? status,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id ?? this.id,
      dueDate: dueDate ?? this.dueDate,
      totalTime: totalTime ?? this.totalTime,
      tags: tags ?? this.tags,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'title': title,
      'description': description,
      'updatedAt': updatedAt ?? updatedAt?.microsecondsSinceEpoch,
      'status': status.name,
      'totalTime': totalTime,
      'tags': tags?.map((tag) => tag.toJson()).toList(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
        id: map['id'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
        title: map['title'],
        description: map['description'],
        updatedAt: map['updatedAt'],
        status: Status.values.byName(map['status']),
        dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int),
        totalTime: map['totalTime'] as double,
        tags: map['tags'] != null
            ? List<Tag>.from(
                (map['tags'] as List<Map<String, dynamic>>)
                    .map<Tag>((tag) => Tag.fromJson(tag))
                    .toList(),
              )
            : null);
  }
}
