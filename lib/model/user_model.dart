class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String enrollmentNumber;
  final String profilePic;
  final bool isVerifiedByAdmin;
  final bool isBanned;
  final bool isAdmin;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.enrollmentNumber,
    required this.profilePic,
    required this.isVerifiedByAdmin,
    required this.isBanned,
    required this.isAdmin,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
    String? enrollmentNumber,
    String? profilePic,
    bool? isVerifiedByAdmin,
    bool? isBanned,
    bool? isAdmin,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      enrollmentNumber: enrollmentNumber ?? this.enrollmentNumber,
      profilePic: profilePic ?? this.profilePic,
      isVerifiedByAdmin: isVerifiedByAdmin ?? this.isVerifiedByAdmin,
      isBanned: isBanned ?? this.isBanned,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'enrollmentNumber': enrollmentNumber,
      'profilePic': profilePic,
      'isVerifiedByAdmin': isVerifiedByAdmin,
      'isBanned': isBanned,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      enrollmentNumber: map['enrollmentNumber'] as String,
      profilePic: map['profilePic'] as String,
      isVerifiedByAdmin: map['isVerifiedByAdmin'] as bool,
      isBanned: map['isBanned'] as bool,
      isAdmin: map['isAdmin'] as bool,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, phoneNumber: $phoneNumber, enrollmentNumber: $enrollmentNumber, profilePic: $profilePic, isVerifiedByAdmin: $isVerifiedByAdmin, isBanned: $isBanned, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.enrollmentNumber == enrollmentNumber &&
        other.profilePic == profilePic &&
        other.isVerifiedByAdmin == isVerifiedByAdmin &&
        other.isBanned == isBanned &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        enrollmentNumber.hashCode ^
        profilePic.hashCode ^
        isVerifiedByAdmin.hashCode ^
        isBanned.hashCode ^
        isAdmin.hashCode;
  }
}
