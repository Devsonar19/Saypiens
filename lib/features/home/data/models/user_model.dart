class SaypienUserModel {
  final String name;
  final String email;
  final String mobile;
  final int age;
  final String insta;
  final String reason;

  const SaypienUserModel({
    required this.name,
    required this.email,
    required this.mobile,
    required this.age,
    required this.insta,
    required this.reason,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobile': mobile,
      'age': age,
      'insta': insta,
      'reason': reason,
    };
  }

  factory SaypienUserModel.fromMap(Map<String, dynamic> map) {
    return SaypienUserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      mobile: map['mobile'] ?? '',
      age: map['age']?.toInt() ?? 0,
      insta: map['insta'] ?? '',
      reason: map['reason'] ?? '',
    );
  }
}