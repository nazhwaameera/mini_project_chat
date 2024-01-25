import 'dart:convert';

import 'package:http/http.dart' as http;
abstract class ChatDataSource{
  Future<String> getUserData(String username);
  Future<String> getChatRoomData(String id);
  Future<String> createRoom(Map<String, dynamic> chat);
  Future<String> createMessage(Map<String, dynamic> chat);
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

    if (response.statusCode == 200) {
      // Parse the response body as JSON
      print('Ini data source: $response.body');
      return response.body;
    } else {
      throw Exception('Failed to get chat room data');
    }
  }

  @override
  Future<String> createMessage(Map<String, dynamic> chat) async {
    print('INI CREATE MESSAGE DARI DATA SOURCE ${chat['username']}');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/chat'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic> {
          'id': chat['id'],
          'from': chat['username'],
          'text': chat['text'],
          'timestamp': chat['timestamp']
        }),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to create chat. Status code: ${response.statusCode}, Response body: ${response.body}');
      }
    } catch (e) {
      // Print the exception message
      print('Exception: $e');
      // Re-throw the exception to propagate it
      throw e;
    }
  }

  @override
  Future<String> createRoom(Map<String, dynamic> chat) async {
    print('INI CREATE MESSAGE DARI DATA SOURCE ${chat['username']}');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/chat'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic> {
          'from': chat['from'],
          'to': chat['to']
        }),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to create chat. Status code: ${response.statusCode}, Response body: ${response.body}');
      }
    } catch (e) {
      // Print the exception message
      print('Exception: $e');
      // Re-throw the exception to propagate it
      throw e;
    }
  }

}