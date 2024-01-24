class User{
  String username;
  List<String> rooms;

  User({required this.username, required this.rooms});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] ?? '', // Replace '' with a default value if needed
      rooms: List<String>.from(json['rooms'] ?? []),
    );
  }
}