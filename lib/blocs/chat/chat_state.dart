part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<ChatLobbyResponse> chatLobbyResponseList;
  final ChatLobbyResponse currentChatLobbyResponse;
  final List<RoomMessageResponse> messagesResponseList;
  final List<String> messageStringList;
  final String userId;

  const ChatState({
    this.chatLobbyResponseList,
    this.currentChatLobbyResponse,
    this.messagesResponseList,
    this.messageStringList,
    this.userId,
  });

  factory ChatState.initial() => ChatState(
        chatLobbyResponseList: [],
        currentChatLobbyResponse: ChatLobbyResponse(),
        messagesResponseList: [],
        messageStringList: [],
        userId: '',
      );

  ChatState copyWith({
    List<ChatLobbyResponse> chatLobbyResponseList,
    ChatLobbyResponse chatLobcurrentChatLobbyResponsebyResponseList,
    ChatLobbyResponse currentChatLobbyResponse,
    List<RoomMessageResponse> messagesResponseList,
    List<String> messageStringList,
    String userId,
  }) =>
      ChatState(
        chatLobbyResponseList: chatLobbyResponseList ?? this.chatLobbyResponseList,
        currentChatLobbyResponse: currentChatLobbyResponse ?? this.currentChatLobbyResponse,
        messagesResponseList: messagesResponseList ?? this.messagesResponseList,
        messageStringList: messageStringList ?? this.messageStringList,
        userId: userId ?? this.userId,
      );

  @override
  List<Object> get props => [
        chatLobbyResponseList,
        currentChatLobbyResponse,
        messagesResponseList,
        messageStringList,
        userId,
      ];

  @override
  String toString() {
    return '''ChatState {
        chatLobbyResponseList: $chatLobbyResponseList,
        currentChatLobbyResponse: $currentChatLobbyResponse,
        messagesResponseList: $messagesResponseList,
        messageStringList: $messageStringList,
        userId: $userId,
    }''';
  }
}

enum ChatStatus { none, process, done, failed }
