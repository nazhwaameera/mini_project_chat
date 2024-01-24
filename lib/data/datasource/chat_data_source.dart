import 'package:http/http.dart' as http;
abstract class ChatDataSource{
  Future<String> getUserData(String username);
  Future<String> getChatRoomData(String id);
  // Future<String> getRoomData();
  // Future<String> createRoom();
  // Future<String> createChat(Map<String, dynamic> chat);
}

class RemoteChatDataSource implements ChatDataSource {
  static const URL = 'http://127.0.0.1:8080';
  String baseUrl;
  RemoteChatDataSource({this.baseUrl = URL});
  
  @override
  Future<String> getUserData(String username) async{
    final response = await http.get(Uri.parse('$baseUrl/api/user/$username'));

    if(response.statusCode == 200) {
      return response.body;
    }else {
      throw Exception('Failed to get user data');
    }
  }

  @override
  Future<String> getChatRoomData(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/chat/$id'));

    if(response.statusCode == 200) {
      return response.body;
    }else {
      throw Exception('Failed to get chat room data');
    }
  }
  
}