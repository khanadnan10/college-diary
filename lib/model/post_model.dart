// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables
import 'dart:convert';

class Post {
  final String pid;
  final String uid;
  final String userName;
  final String department;
  final String branch;
  final String? content;
  final likes;
  final dislikes;
  final String? images;
  
  final String postType;
  final DateTime createdAt;
  const Post({
    required this.pid,
    required this.uid,
    required this.userName,
    required this.department,
    required this.branch,
    this.content,
    this.images,
    this.likes,
    this.dislikes,
    required this.postType,
    required this.createdAt,
  });

  Post copyWith({
    String? pid,
    String? uid,
    String? userName,
    String? department,
    String? branch,
    String? content,
    String? images,
    String? postType,
    DateTime? createdAt,
  }) {
    return Post(
      pid: pid ?? this.pid,
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      department: department ?? this.department,
      branch: branch ?? this.branch,
      content: content ?? this.content,
      images: images ?? this.images,
      postType: postType ?? this.postType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'uid': uid,
      'userName': userName,
      'department': department,
      'branch': branch,
      'content': content,
      'images': images,
      'postType': postType,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      pid: map['pid'] as String,
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      department: map['department'] as String,
      branch: map['branch'] as String,
      content: map['content'] != null ? map['content'] as String : null,
      images: map['images'] != null ? map['images'] as String : null,
      postType: map['postType'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(pid: $pid, uid: $uid, userName: $userName, department: $department, branch: $branch, content: $content, images: $images, postType: $postType, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.pid == pid &&
        other.uid == uid &&
        other.userName == userName &&
        other.department == department &&
        other.branch == branch &&
        other.content == content &&
        other.images == images &&
        other.postType == postType &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return pid.hashCode ^
        uid.hashCode ^
        userName.hashCode ^
        department.hashCode ^
        branch.hashCode ^
        content.hashCode ^
        images.hashCode ^
        postType.hashCode ^
        createdAt.hashCode;
  }
}
