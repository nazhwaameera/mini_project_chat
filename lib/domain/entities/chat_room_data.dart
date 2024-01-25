class ChatRoomData{
  String from;
  String to;

  ChatRoomData({required this.from, required this.to});

  factory ChatRoomData.fromJson(Map<String, dynamic> json) {
    print('Raw JSON chat room data: $json');

    return ChatRoomData(
        from: json['from'],
        to: json['to;']
    );
  }

  Map<String, dynamic> toJson() {
    print('Ini toJson chat room data $from, $to');
    return {
      'from': from,
      'to': to
    };
  }


}