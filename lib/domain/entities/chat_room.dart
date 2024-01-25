import 'message.dart';

class ChatRoom{
  List<String> users;
  List<Message> messages;

  ChatRoom({required this.users, required this.messages});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    print('Raw JSON: $json');

    var users = <String>[];
    for(var i = 0; i < json['users'].length; i++){
      users.add(json['users'][i]);
      print('User $i: ${json['users'][i]}');
    }

    print('Raw user: $users');

    var messages = <Message>[];
    for(var j = 0; j < json['messages'].length; j++){
      messages.add(Message.fromJson(json['messages'][j]));
      print('Message $j: ${json['messages'][j]}');
    }

    print('Raw message: $messages');
    print('Ini ChatRoom: ChatRoom ${users}, ${messages}');

    return ChatRoom(
      users: users,
      messages: messages,
    );
  }
}