class Profile {
  Profile({
    this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
    this.phoneNumber,
    this.verified,
  });

  String uid;
  String email;
  String photoUrl;
  String displayName;
  String phoneNumber;
  bool verified;

  factory Profile.fromMap(Map<String, dynamic> data) {
    data = data ?? {};

    return Profile(
      uid: data['uid'] ?? 'none',
      email: data['email'] ?? 'none',
      photoUrl: data['photoUrl'] ?? 'none',
      displayName: data['displayName'] ?? 'none',
      phoneNumber: data['phoneNumber'] ?? 'none',
      verified: data['verified'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'photoUrl': photoUrl,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'verified': verified,
    };
  }
}
