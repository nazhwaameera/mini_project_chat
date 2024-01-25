import 'package:mini_project_chat/data/repository/chat_repository.dart';

import '../entities/message.dart';

class CreateMessage {
  var repository = ChatRepository();

  Future<bool> execute(Message message) async {
    return repository.createMessage(message);
  }
}