class Tag {
  final String id;
  final String tagName;
  Tag({
    required this.id,
    required this.tagName,
  });

  Tag copyWith({
    String? id,
    String? tagName,
  }) {
    return Tag(
      id: id ?? this.id,
      tagName: tagName ?? this.tagName,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'tagName': tagName,
    };
  }

  factory Tag.fromJson(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] as String,
      tagName: map['tagName'] as String,
    );
  }
  @override
  String toString() => 'Tag(id: $id, tagName: $tagName)';

  @override
  bool operator ==(covariant Tag other) {
    if (identical(this, other)) return true;

    return other.id == id && other.tagName == tagName;
  }

  @override
  int get hashCode => id.hashCode ^ tagName.hashCode;
}
