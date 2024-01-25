import 'package:flutter/material.dart';
import 'package:mini_project_chat/domain/entities/chat_room_data.dart';
import 'package:mini_project_chat/presentation/pages/chat_room_page.dart';

import '../../domain/entities/chat_room.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/create_room_data.dart';
import '../../domain/usecases/get_user_data.dart';
import '../../domain/usecases/get_chat_room_data.dart';

class ChatRoomListPage extends StatefulWidget {
  late String username; // Assuming you have the username for the logged-in user

  ChatRoomListPage({required this.username});

  @override
  _ChatRoomListPageState createState() => _ChatRoomListPageState();
}

class _ChatRoomListPageState extends State<ChatRoomListPage> {
  late Future<List<String>> chatRooms;

  @override
  void initState() {
    super.initState();
    chatRooms = GetUserData().execute(widget.username).then(
          (userData) {
        // Extracting the rooms property from the user
        return userData.rooms;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Rooms'),
      ),
      body: FutureBuilder<User>(
        future: GetUserData().execute(widget.username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Error loading chat rooms'));
          } else {
            final user = snapshot.data!;

            return ListView.builder(
              itemCount: user.rooms.length,
              itemBuilder: (context, index) {
                final roomId = user.rooms[index];
                print('INI DEBUGGING 3 ${roomId}');
                return FutureBuilder<ChatRoom>(
                  future: GetChatRoomData().execute(roomId),
                  builder: (context, chatRoomSnapshot) {
                    print('INI DEBUGGING 2 ${chatRoomSnapshot}');
                    if (chatRoomSnapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text(roomId),
                        subtitle: Text('Loading...'),
                        onTap: () {
                          // Handle onTap as needed
                        },
                      );
                    } else if (chatRoomSnapshot.hasError) {
                      print('Error loading chat room data for room $roomId: ${chatRoomSnapshot.error}');
                      return ListTile(
                        title: Text(roomId),
                        subtitle: Text('Error loading chat room data'),
                      );
                    } else if (!chatRoomSnapshot.hasData) {
                      print('No data available for chat room $roomId');
                      return ListTile(
                        title: Text(roomId),
                        subtitle: Text('No data available for chat room'),
                      );
                    } else {
                      final chatRoom = chatRoomSnapshot.data!;
                      final opponentUsers = chatRoom.users.where((username) => username != widget.username).toList();

                      return ListTile(
                        title: Text('Opponents: ${opponentUsers.map((username) => username).join(', ')}'),
                        subtitle: Text(chatRoom.messages[0].text),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatRoomPage(username:widget.username, roomId: roomId)),
                          );
                        },
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateChatRoomDialog(context);
        },
        tooltip: 'Create Chat Room',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showCreateChatRoomDialog(BuildContext context) {
    TextEditingController usernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Chat Room'),
          content: TextField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Enter Username'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _createChatRoom(usernameController.text);
                Navigator.pop(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _createChatRoom(String username) async {
    if (username.isNotEmpty) {
      var newChatRoom = ChatRoomData(
        from: widget.username,
        to: username,
      );

      try {
        // String id = await CreateRoom().execute(newChatRoom);
        // Update chatRoomData after sending a new message
        setState(() {

        });
        GetUserData().execute(widget.username);
      } catch (e) {
        // Handle exception
        print('Error sending message: $e');
      }
    }
  }
}
