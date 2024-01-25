import 'dart:convert';

import 'package:mini_project_chat/domain/entities/chat_room_data.dart';

import '../../domain/entities/chat_room.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/user.dart';
import '../datasource/chat_data_source.dart';

class ChatRepository{
  var remoteChatDataSource = RemoteChatDataSource();

  Future<User> getUserData(String username) async {
    var jsonArray = jsonDecode(await remoteChatDataSource.getUserData(username))['data'];
    print('Ini GetUserData $jsonArray');
    User user = User.fromJson(jsonArray);
    print('Ini GetUserData user ${user}');
    return user;
  }

  Future<ChatRoom> getChatRoomData(String id) async {
    var jsonArray = jsonDecode(await remoteChatDataSource.getChatRoomData(id))['data'];
    print('Ini data jsonArray $jsonArray');
    ChatRoom chatRoom = ChatRoom.fromJson(jsonArray);
    print('Ini data getChatRoom $chatRoom');
    return chatRoom;
  }

  @override
  Future<bool> createMessage(Message message) async {
    print('Ini message create: ${message.id.runtimeType}');
    var response = await remoteChatDataSource.createMessage(message.toJson());
    var result = jsonDecode(response)['data'];
    print('Ini response create: $result');
    return jsonDecode(response)['data'];
  }

  @override
  Future<String> createRoom(ChatRoomData chatRoomData) async {
    print('Ini message create: ${chatRoomData.from.runtimeType}');
    var response = await remoteChatDataSource.createRoom(chatRoomData.toJson());
    var result = jsonDecode(response)['data'];
    print('Ini response create: $result');
    return jsonDecode(response)['data'];
  }
}