class User {
  final int id;
  final String username;
  final String token;
  final String groupID;

  User({
    required this.id,
    required this.username,
    required this.token,
    required this.groupID,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'] ?? 0,
      username: json['user']['username'] ?? '',
      token: json['token'] ?? '',
      groupID: json['groups']?.toString() ?? '',
    );
  }
}
