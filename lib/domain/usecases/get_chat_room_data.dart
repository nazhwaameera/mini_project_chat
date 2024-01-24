import '../../data/repository/chat_repository.dart';
import '../entities/chat_room.dart';

class GetChatRoomData {
  var repository = ChatRepository();

  Future<ChatRoom> execute(String id) async {
    return repository.getChatRoomData(id);
  }
}