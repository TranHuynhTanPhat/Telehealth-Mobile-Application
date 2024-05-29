part of 'chat_cubit.dart';

sealed class ChatState {
  ChatState({required this.messages, required this.blocState, required this.rooms, required this.currentRoomId});
  final List<MessageResponse> messages;
  final String? currentRoomId;
  final BlocState blocState;
  final List<RoomChat> rooms;
}

final class ChatInitial extends ChatState {
  ChatInitial({required super.messages, required super.blocState, required super.rooms, required super.currentRoomId});
}

final class FetchMessageState extends ChatState {
  FetchMessageState({required super.messages, required super.blocState, required super.rooms, required super.currentRoomId});
}

final class SendMessageState extends ChatState {
  SendMessageState({required super.messages, required super.blocState, required super.rooms, required super.currentRoomId});
}
final class FetchRoomChatState extends ChatState {
  FetchRoomChatState({required super.messages, required super.blocState, required super.rooms, required super.currentRoomId});
}
