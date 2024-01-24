import 'package:mini_project_chat/data/repository/chat_repository.dart';

import '../entities/user.dart';

class GetUserData {
  var repository = ChatRepository();

  Future<User> execute(String username) async {
    return repository.getUserData(username);
  }
}