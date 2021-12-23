import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_hw/chat/presentation/store/chat_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'message_view.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<StatefulWidget> {
  // final ChatStore _chatStore = ChatStore();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // _chatStore.getNewMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Center(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(child: Observer(
                  builder: (context) {
                    return ListView.builder(
                      itemCount: 0,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 16),
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemBuilder: (BuildContext context, int index) {
                        return ConversationList(
                          name: "",
                          messageText: "",
                        );
                      },
                    );
                  },
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
                        // _chatStore.sendMessage(_messageController.text,
                        //     onSend: () => {_messageController.clear()});
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
