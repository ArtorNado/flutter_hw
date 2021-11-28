import 'package:flutter_hw/chat/data/model/chat_message_element.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://itis-chat-app-ex.herokuapp.com/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/chat")
  Future<List<ChatMessageElement>> getMessages();

  @POST("/chat")
  Future<ChatMessageElement> sendMessage(@Body() ChatMessageElement message);
}
