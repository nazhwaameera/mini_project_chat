import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mini_project_chat/domain/entities/message.dart';
import 'package:mini_project_chat/domain/usecases/create_message_data.dart';
import 'package:mini_project_chat/domain/usecases/get_chat_room_data.dart';

import '../../domain/entities/chat_room.dart';

class ChatRoomPage extends StatefulWidget {
  final String username;
  final String roomId;

  ChatRoomPage({required this.username, required this.roomId});

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  TextEditingController messageController = TextEditingController();

  late Future<ChatRoom> chatRoomData;

  @override
  void initState() {
    super.initState();
    chatRoomData = GetChatRoomData().execute(widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room ${widget.roomId}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ChatRoom>(
              future: chatRoomData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No messages available.'));
                } else {
                  final messages = snapshot.data!;
                  final chats = messages.messages;

                  return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      var message = chats[index].text;
                      return ListTile(
                        title: Text(message),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage() async {
    String text = messageController.text.trim();
    if (text.isNotEmpty) {
      var newMessage = Message(
        id: widget.roomId,
        username: widget.username,
        text: text,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      try {
        await CreateMessage().execute(newMessage);
        messageController.clear();
        // Update chatRoomData after sending a new message
        setState(() {
          chatRoomData = GetChatRoomData().execute(widget.roomId);
        });
      } catch (e) {
        // Handle exception
        print('Error sending message: $e');
      }
    }
  }
}


