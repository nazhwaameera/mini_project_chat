import 'message.dart';
import 'user.dart';

class ChatRoom{
  String id;
  List<User> users;
  List<Message> messages;

  ChatRoom({required this.id, required this.users, required this.messages});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    List<User> users = (json['users'] as List<dynamic>).map((userData) {
      return User.fromJson(userData);
    }).toList();

    List<Message> messages = (json['messages'] as List<dynamic>).map((messageData) {
      return Message.fromJson(messageData);
    }).toList();

    return ChatRoom(
      id: json['id'],
      users: users,
      messages: messages,
    );
  }
}