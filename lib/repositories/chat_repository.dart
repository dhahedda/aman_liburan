import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/api_client.dart';

class ChatRepository {
  Future<GlobalResponse> getInitiateChat({@required String receiverId}) async {
    try {
      final path = '/initiate_chat?receiverid=$receiverId';
      final response = await ApiClient().httpGetHelper(path, 'getInitiateChat');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }

  Future<GlobalResponse> postRetrieveChatLobby({@required EmptyParam params}) async {
    try {
      final response = await ApiClient().httpPostHelper('/chat_lobby', params.toJson(), 'postRetrieveChatLobby');
      // Without utf8.decode, moonrunes (Japanese characters) will appear as gibberish
      // https://stackoverflow.com/a/60110308/13285235
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }

  Future<GlobalResponse> getRetrieveChatMesssages({@required String room}) async {
    try {
      final path = '/chat_messages?room=$room&start=1&limit=120';
      final response = await ApiClient().httpGetHelper(path, 'getRetrieveChatMesssages');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }

  Future<GlobalResponse> postInsertChatMessage({@required InsertMessageParam params}) async {
    try {
      final response = await ApiClient().httpPostHelper('/insert_message', params.toJson(), 'postInsertChatMessage');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }

  Future<GlobalResponse> postInsertImageMessage({@required InsertImageMessageParam params}) async {
    try {
      final response = await ApiClient().httpPostHelper('/insert_image_message', params.toJson(), 'postInsertImageMessage');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }
}
