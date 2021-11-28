import 'package:dio/dio.dart';
import 'package:flutter_hw/data/api/api_client.dart';
import 'package:flutter_hw/data/model/chat_message_element.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'chat_store.g.dart';

// This is the class used by rest of your codebase
class ChatStore = _ChatStore with _$ChatStore;

// The store-class
abstract class _ChatStore with Store {
  final String _author = 'Dart duck';
  RestClient restDio = RestClient(Dio());

  @observable
  ObservableList<ChatMessageElement> messages = ObservableList.of([]);

  @action
  void getNewMessages() async {
    restDio.getMessages().then((List<ChatMessageElement> chatMessages) {
      messages.clear();
      messages.addAll(chatMessages);
    }).catchError((error) {
      print(error.toString());
    });
  }

  @action
  void sendMessage(String newMessage, {Function? onSend}) async {
    ChatMessageElement newMessageElement =
    ChatMessageElement(author: _author, message: newMessage);

    restDio
        .sendMessage(newMessageElement)
        .then((ChatMessageElement chatMessage) {
      messages.add(chatMessage);

      if (onSend != null) {
        onSend();
      }
    }).catchError((error) {
      print(error.toString());
    });
  }
}