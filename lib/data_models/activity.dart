abstract class Activity {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Status status;
  Activity({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    this.updatedAt,
    required this.status,
  });

  @override
  String toString() {
    return 'Activity(id: $id, title: $title, description: $description,'
        ' createdAt: $createdAt, updatedAt: $updatedAt, status: $status)';
  }

  @override
  bool operator ==(covariant Activity other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}

enum Status {
  idle,
  running,
  completed,
  pause,
  start,
  postponed,
}
