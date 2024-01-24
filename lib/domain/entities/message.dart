class Message{
  String username;
  String text;
  String timestamp;

  Message({required this.username, required this.text, required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      username: json['username'],
      text: json['text'],
      timestamp: json['timestamp'],
    );
  }
}