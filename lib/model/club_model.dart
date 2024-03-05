import 'package:flutter/foundation.dart';

class Club {
  final String cid;
  final String name;
  final String avatar;
  final List<String> members;
  final List<String> guardians;
  Club({
    required this.cid,
    required this.name,
    required this.avatar,
    required this.members,
    required this.guardians,
  });

  Club copyWith({
    String? cid,
    String? name,
    String? avatar,
    List<String>? members,
    List<String>? guardians,
  }) {
    return Club(
      cid: cid ?? this.cid,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      members: members ?? this.members,
      guardians: guardians ?? this.guardians,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cid': cid,
      'name': name,
      'avatar': avatar,
      'members': members,
      'guardians': guardians,
    };
  }

  factory Club.fromMap(Map<String, dynamic> map) {
    return Club(
      cid: map['cid'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      members: List<String>.from((map['members'] as List<String>)),
      guardians: List<String>.from(
        (map['guardians'] as List<String>),
      ),
    );
  }

  @override
  String toString() {
    return 'Club(cid: $cid, name: $name, avatar: $avatar, members: $members, guardians: $guardians)';
  }

  @override
  bool operator ==(covariant Club other) {
    if (identical(this, other)) return true;

    return other.cid == cid &&
        other.name == name &&
        other.avatar == avatar &&
        listEquals(other.members, members) &&
        listEquals(other.guardians, guardians);
  }

  @override
  int get hashCode {
    return cid.hashCode ^
        name.hashCode ^
        avatar.hashCode ^
        members.hashCode ^
        guardians.hashCode;
  }
}
