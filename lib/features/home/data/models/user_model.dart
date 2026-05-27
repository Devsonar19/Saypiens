class SaypienUserModel {
  final String name;
  final String email;
  final String reason;

  const SaypienUserModel({
    required this.name,
    required this.email,
    required this.reason,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'reason': reason,
    };
  }

  factory SaypienUserModel.fromMap(Map<String, dynamic> map) {
    return SaypienUserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      reason: map['reason'] ?? '',
    );
  }
}