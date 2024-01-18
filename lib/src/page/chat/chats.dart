import 'package:flutter/material.dart';
import 'package:bancodt/src/page/chat/chat.dart';


void main() {
  runApp(ChatsPage());
}

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ChatList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.message),
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This would be replaced with a ListView.builder for dynamic content
    return ListView(
      children: [
        ChatItem(), // Repeat this with actual data
        // ...
      ],
    );
  }
}

class ChatItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        //backgroundImage: NetworkImage('userProfileImageURL'),
      ),
      title: Text('Contact Name'),
      subtitle: Text('Last message...'),
      trailing: Text('Time'),
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ChatPage()),
              (Route<dynamic> route) => false,
        );
        // TODO: Navigate to chat details
      },
    );
  }
}
