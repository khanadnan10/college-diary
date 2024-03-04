import 'package:flutter/foundation.dart';

class Post {
  final String pid;
  final String uid;
  final String? text;
  final List<String> likes;
  final List<String> dislikes;
  final List<String>? images;
  final Post postType;
  final DateTime createdAt;
  Post({
    required this.pid,
    required this.uid,
    this.text,
    required this.likes,
    required this.dislikes,
    this.images,
    required this.postType,
    required this.createdAt,
  });

  Post copyWith({
    String? pid,
    String? uid,
    String? text,
    List<String>? likes,
    List<String>? dislikes,
    List<String>? images,
    Post? postType,
    DateTime? createdAt,
  }) {
    return Post(
      pid: pid ?? this.pid,
      uid: uid ?? this.uid,
      text: text ?? this.text,
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
      'text': text,
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
      text: map['text'] != null ? map['text'] as String : null,
      likes: List<String>.from(map['likes'] as List<String>),
      dislikes: List<String>.from((map['dislikes'] as List<String>)),
      images: map['images'] != null
          ? List<String>.from((map['images'] as List<String>))
          : null,
      postType: map['postType'] as Post,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  @override
  String toString() {
    return 'Post(pid: $pid, uid: $uid, text: $text, likes: $likes, dislikes: $dislikes, images: $images, postType: $postType, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.pid == pid &&
        other.uid == uid &&
        other.text == text &&
        listEquals(other.likes, likes) &&
        listEquals(other.dislikes, dislikes) &&
        listEquals(other.images, images) &&
        other.postType == postType &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return pid.hashCode ^
        uid.hashCode ^
        text.hashCode ^
        likes.hashCode ^
        dislikes.hashCode ^
        images.hashCode ^
        postType.hashCode ^
        createdAt.hashCode;
  }
}
