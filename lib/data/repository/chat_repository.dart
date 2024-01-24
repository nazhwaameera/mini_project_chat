import 'dart:convert';

import '../../domain/entities/chat_room.dart';
import '../../domain/entities/user.dart';
import '../datasource/chat_data_source.dart';

class ChatRepository{
  var remoteChatDataSource = RemoteChatDataSource();

  Future<User> getUserData(String username) async {
    var jsonArray = jsonDecode(await remoteChatDataSource.getUserData(username))['data'];
    User user = User.fromJson(jsonArray);
    return user;
  }

  Future<ChatRoom> getChatRoomData(String id) async {
    var jsonArray = jsonDecode(await remoteChatDataSource.getChatRoomData(id))['data'];
    ChatRoom chatRoom = ChatRoom.fromJson(jsonArray);
    print('INI DEBUGGING WOI ${jsonArray}');
    return chatRoom;
  }
}