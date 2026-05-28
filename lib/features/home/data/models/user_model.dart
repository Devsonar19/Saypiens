class SaypienUserModel {
  final String name;
  final String email;
  final String insta;
  final String reason;

  const SaypienUserModel({
    required this.name,
    required this.email,
    required this.insta,
    required this.reason,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'insta': insta,
      'reason': reason,
    };
  }

  factory SaypienUserModel.fromMap(Map<String, dynamic> map) {
    return SaypienUserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      insta: map['insta'] ?? '',
      reason: map['reason'] ?? '',
    );
  }
}