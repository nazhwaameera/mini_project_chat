class Message{
  String id;
  String username;
  String text;
  var timestamp;

  Message({required this.id, required this.username, required this.text, required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) {
    print('Debug: ${json['username'].runtimeType}, ${json['text'].runtimeType}, ${json['timestamp'].runtimeType}');
    return Message(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      text: json['text'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    print('Ini toJson message $username, $text, $timestamp');
    return {
      'id': id,
      'username': username,
      'text': text,
      'timestamp': timestamp,
    };
  }
}