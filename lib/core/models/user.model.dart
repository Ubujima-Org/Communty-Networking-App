import 'dart:convert';

class User {
  final String id;
  final String name;
  final DateTime registration;
  final int status;
  final String email;
  final bool emailVerification;
  final Map<String, dynamic> prefs;

  User({
    required this.id,
    required this.name,
    required this.registration,
    required this.status,
    required this.email,
    required this.emailVerification,
    required this.prefs,
  });

  User copyWith({
    String? id,
    String? name,
    DateTime? registration,
    int? status,
    String? email,
    bool? emailVerification,
    Map<String, dynamic>? prefs,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      registration: registration ?? this.registration,
      status: status ?? this.status,
      email: email ?? this.email,
      emailVerification: emailVerification ?? this.emailVerification,
      prefs: prefs ?? this.prefs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '\$id': id,
      'name': name,
      'registration': registration.millisecondsSinceEpoch,
      'status': status,
      'email': email,
      'emailVerification': emailVerification,
      'prefs': prefs,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['\$id'],
      name: map['name'],
      registration: DateTime.fromMillisecondsSinceEpoch(map['registration']),
      status: map['status'],
      email: map['email'],
      emailVerification: map['emailVerification'],
      prefs: Map<String, dynamic>.from(map['prefs']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
