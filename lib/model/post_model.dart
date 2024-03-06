// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class Post {
  final String pid;
  final String uid;
  final String? content;
  final List<String> likes;
  final List<String> dislikes;
  final String? images;
  final String postType;
  final DateTime createdAt;
  Post({
    required this.pid,
    required this.uid,
    this.content,
    required this.likes,
    required this.dislikes,
    this.images,
    required this.postType,
    required this.createdAt,
  });

  Post copyWith({
    String? pid,
    String? uid,
    String? content,
    List<String>? likes,
    List<String>? dislikes,
    String? images,
    String? postType,
    DateTime? createdAt,
  }) {
    return Post(
      pid: pid ?? this.pid,
      uid: uid ?? this.uid,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      images: images ?? this.images,
      postType: postType ?? this.postType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'uid': uid,
      'content': content,
      'likes': likes,
      'dislikes': dislikes,
      'images': images,
      'postType': postType,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      pid: map['pid'] as String,
      uid: map['uid'] as String,
      content: map['content'] != null ? map['content'] as String : null,
      likes: List<String>.from((map['likes'] as List<String>)),
      dislikes: List<String>.from((map['dislikes'] as List<String>)),
      images: map['images'] != null ? map['images'] as String : null,
      postType: map['postType'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }
  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.pid == pid &&
        other.uid == uid &&
        other.content == content &&
        listEquals(other.likes, likes) &&
        listEquals(other.dislikes, dislikes) &&
        other.images == images &&
        other.postType == postType &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return pid.hashCode ^
        uid.hashCode ^
        content.hashCode ^
        likes.hashCode ^
        dislikes.hashCode ^
        images.hashCode ^
        postType.hashCode ^
        createdAt.hashCode;
  }

  @override
  String toString() {
    return 'Post(pid: $pid, uid: $uid, content: $content, likes: $likes, dislikes: $dislikes, images: $images, postType: $postType, createdAt: $createdAt)';
  }
}
