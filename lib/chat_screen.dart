import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<StatefulWidget> {
  final String _title = 'Messages';
  final List<String> _messages = [];

  final TextEditingController _messageController = TextEditingController();

  void addMessageToList(String newMessage) {
    setState(() {
      _messages.add(newMessage);
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: _messages.map((item) {
                    return ListTile(
                      title: Text(
                        item,
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontStyle: FontStyle.italic),
                      ),
                    );
                  }).toList(),
                )),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(Icons.send),
                      onTap: () {
                        addMessageToList(_messageController.text);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
