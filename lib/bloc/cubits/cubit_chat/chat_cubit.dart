import 'package:bloc/bloc.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/models/responses/message_response.dart';
import 'package:healthline/data/api/models/responses/room_chat.dart';
import 'package:healthline/data/api/socket_manager.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/data/storage/data_constants.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.socketManager})
      : super(ChatInitial(
            messages: [],
            blocState: BlocState.Pending,
            rooms: [],
            currentRoomId: null));
  final SocketManager socketManager;

  @override
  void onChange(Change<ChatState> change) {
    super.onChange(change);
    logPrint(
        "$change ${change.currentState.blocState.name} ${change.nextState.blocState.name}");
  }

  Future<void> fetchMessage({required String roomId}) async {
    emit(
      FetchMessageState(
        blocState: BlocState.Pending,
        messages: [],
        rooms: state.rooms,
        currentRoomId: state.currentRoomId,
      ),
    );
    try {
      if (state.currentRoomId != null) {
        socketManager.stopEvent(event: 'messages.${state.currentRoomId}');
      }
      socketManager.addListener(
          event: 'messages.$roomId',
          listener: (data) {
            List<MessageResponse> messages = data
                .map<MessageResponse>((e) => MessageResponse.fromMap(e))
                .toList();
            List<MessageResponse> lastMessage = state.messages.toList();
            for (var element in messages) {
              lastMessage.firstWhere((e) => e.id == element.id, orElse: () {
                lastMessage.add(element);
                return element;
              });
            }
            lastMessage.sort((a, b) {
              DateTime? aTime = convertStringToDateTime(a.updatedAt);
              DateTime? bTime = convertStringToDateTime(b.updatedAt);
              if (aTime != null && bTime != null) {
                return aTime.compareTo(bTime);
              } else {
                return aTime == null ? -1 : 1;
              }
            });
            lastMessage = lastMessage.reversed.toList();
            emit(
              FetchMessageState(
                blocState: BlocState.Successed,
                messages: lastMessage,
                rooms: state.rooms,
                currentRoomId: state.currentRoomId,
              ),
            );
          });
      socketManager.sendEventData(event: "allMessage", data: roomId);
      // socket.sendDataWithAck(
      //     data: idPost,
      //     event: "findAll",
      //     listen: (data) {
      //       // if (data != 'medical_record_not_found') {
      //       List<CommentResponse> comments = data
      //           .map<CommentResponse>((e) => CommentResponse.fromMap(e))
      //           .toList();
      //       emit(FetchCommentState(
      //           blocState: BlocState.Successed,
      //           comments: comments,
      //           currentPost: idPost));
      //       // } else {
      //       //   emit(FetchCommentState(
      //       //       blocState: BlocState.Successed,
      //       //       comments: [],
      //       //       currentPost: idPost));
      //       // }
      //     });
      emit(FetchMessageState(
          messages: state.messages,
          blocState: BlocState.Successed,
          rooms: state.rooms,
          currentRoomId: roomId));
    } catch (error) {
      emit(
        FetchMessageState(
          blocState: BlocState.Failed,
          messages: state.messages,
          rooms: state.rooms,
          currentRoomId: state.currentRoomId,
        ),
      );
    }
  }

  Future<void> sendMessage({required String text}) async {
    emit(
      SendMessageState(
        blocState: BlocState.Pending,
        messages: state.messages,
        rooms: state.rooms,
        currentRoomId: state.currentRoomId,
      ),
    );
    try {
      socketManager.sendEventData(
          event: "addMessage",
          data: {"room_id": state.currentRoomId, "text": text, "type": "text"});
      emit(
        SendMessageState(
          blocState: BlocState.Successed,
          messages: state.messages,
          rooms: state.rooms,
          currentRoomId: state.currentRoomId,
        ),
      );
    } catch (error) {
      emit(
        SendMessageState(
          blocState: BlocState.Failed,
          messages: state.messages,
          rooms: state.rooms,
          currentRoomId: state.currentRoomId,
        ),
      );
    }
  }

  Future<void> fetchRoomChat({required String medicalId}) async {
    emit(
      FetchRoomChatState(
        blocState: BlocState.Pending,
        messages: state.messages,
        rooms: [],
        currentRoomId: state.currentRoomId,
      ),
    );
    try {
      if (state.currentRoomId != null) {
        socketManager.stopEvent(event: "room.${state.currentRoomId}");
      }
      
      socketManager.stopEvent(event: "room.$medicalId");

      socketManager.addListener(
          event: "room.$medicalId",
          listener: (data) {
            List<RoomChat> rooms =
                List<RoomChat>.from(data.map((e) => RoomChat.fromMap(e)));
            emit(FetchRoomChatState(
                messages: state.messages,
                blocState: BlocState.Successed,
                rooms: rooms,
                currentRoomId: medicalId));
          });
      socketManager.sendEventData(event: "getRoom", data: medicalId);
      // socketManager.sendData(data: medicalId);
    } catch (error) {
      emit(
        FetchRoomChatState(
          blocState: BlocState.Failed,
          messages: [],
          rooms: state.rooms,
          currentRoomId: state.currentRoomId,
        ),
      );
    }
  }

  Future<void> fetchRoomChatDoctor() async {
    emit(
      FetchRoomChatState(
        blocState: BlocState.Pending,
        messages: state.messages,
        rooms: [],
        currentRoomId: state.currentRoomId,
      ),
    );
    try {
      socketManager.stopEvent(event: "room.${state.currentRoomId}");

      var user = LoginResponse.fromJson(
          AppStorage().getString(key: DataConstants.DOCTOR)!);
      if (user.id == null) throw "failure";
      // logPrint(user.toJson());
      socketManager.stopEvent(event: "room.doctor.${user.id}");
      // logPrint("room.doctor.${user.id}");
      socketManager.addListener(
          event: "room.doctor.${user.id}",
          listener: (data) {
            List<RoomChat> rooms =
                List<RoomChat>.from(data.map((e) => RoomChat.fromMap(e)));
            emit(FetchRoomChatState(
                messages: state.messages,
                blocState: BlocState.Successed,
                rooms: rooms,
                currentRoomId: state.currentRoomId));
          });
      socketManager.sendEvent(event: "getRoomDoctor");
      // logPrint(user.toJson());

      // socketManager.sendData(data: medicalId);
    } catch (error) {
      emit(
        FetchRoomChatState(
          blocState: BlocState.Failed,
          messages: [],
          rooms: state.rooms,
          currentRoomId: state.currentRoomId,
        ),
      );
    }
  }
}
