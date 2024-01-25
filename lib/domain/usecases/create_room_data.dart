import 'package:mini_project_chat/data/repository/chat_repository.dart';
import '../entities/chat_room_data.dart';

class CreateRoom {
  var repository = ChatRepository();

  Future<String> execute(ChatRoomData chatRoomData) async {
    return repository.createRoom(chatRoomData);
  }
}