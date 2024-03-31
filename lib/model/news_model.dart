class News {
  final String id;
  final String title;
  final String content;
  final String? image;
  final String? link;
  final String author;
  final String department;
  final DateTime createdAt;
  News({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    this.link,
    required this.author,
    required this.department,
    required this.createdAt,
  });

  News copyWith({
    String? id,
    String? title,
    String? content,
    String? image,
    String? link,
    String? author,
    String? department,
    DateTime? createdAt,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      link: link ?? this.link,
      author: author ?? this.author,
      department: department ?? this.department,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'link': link,
      'author': author,
      'department': department,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      author: map['author'] as String,
      department: map['department'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  @override
  bool operator ==(covariant News other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.image == image &&
        other.link == link &&
        other.author == author &&
        other.department == department &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        image.hashCode ^
        link.hashCode ^
        author.hashCode ^
        department.hashCode ^
        createdAt.hashCode;
  }
}
