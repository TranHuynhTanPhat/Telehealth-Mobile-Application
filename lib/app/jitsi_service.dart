import 'package:healthline/utils/log_data.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class JitsiService {
  bool audioMuted = true;
  bool videoMuted = true;
  bool screenShareOn = false;
  List<String> participants = [];
  final _jitsiMeetPlugin = JitsiMeet();

  // singleton
  static final JitsiService instance = JitsiService._internal();

  factory JitsiService() {
    return instance;
  }

  JitsiService._internal();

  join(
      {required String token,
      required String? roomName,
      required String? displayName,
      required String? urlAvatar,
      required String? email}) async {
    var options = JitsiMeetConferenceOptions(
      serverURL: "https://8x8.vc",
      token: token,
      room: roomName ?? 'Healthline',
      configOverrides: {
        "startWithAudioMuted": false,
        "startWithVideoMuted": false,
        "subject": "HealthLine",
      },
      featureFlags: {
        "unsaferoomwarning.enabled": false,
        "ios.screensharing.enabled": true
      },
      userInfo: JitsiMeetUserInfo(
          displayName: displayName, avatar: urlAvatar, email: email),
    );

    var listener = JitsiMeetEventListener(
      conferenceJoined: (url) {
        logPrint("conferenceJoined: url: $url");
      },
      conferenceTerminated: (url, error) {
        logPrint("conferenceTerminated: url: $url, error: $error");
      },
      conferenceWillJoin: (url) {
        logPrint("conferenceWillJoin: url: $url");
      },
      participantJoined: (email, name, role, participantId) {
        logPrint(
          "participantJoined: email: $email, name: $name, role: $role, "
          "participantId: $participantId",
        );
        participants.add(participantId!);
      },
      participantLeft: (participantId) {
        logPrint("participantLeft: participantId: $participantId");
      },
      audioMutedChanged: (muted) {
        logPrint("audioMutedChanged: isMuted: $muted");
      },
      videoMutedChanged: (muted) {
        logPrint("videoMutedChanged: isMuted: $muted");
      },
      endpointTextMessageReceived: (senderId, message) {
        logPrint(
            "endpointTextMessageReceived: senderId: $senderId, message: $message");
      },
      screenShareToggled: (participantId, sharing) {
        logPrint(
          "screenShareToggled: participantId: $participantId, "
          "isSharing: $sharing",
        );
      },
      chatMessageReceived: (senderId, message, isPrivate, timestamp) {
        logPrint(
          "chatMessageReceived: senderId: $senderId, message: $message, "
          "isPrivate: $isPrivate, timestamp: $timestamp",
        );
      },
      chatToggled: (isOpen) => logPrint("chatToggled: isOpen: $isOpen"),
      participantsInfoRetrieved: (participantsInfo) {
        logPrint(
            "participantsInfoRetrieved: participantsInfo: $participantsInfo, ");
      },
      readyToClose: () {
        logPrint("readyToClose");
      },
    );
    return await _jitsiMeetPlugin.join(options, listener);
  }

  // hangUp() async {
  //   await _jitsiMeetPlugin.hangUp();
  // }

  // setAudioMuted(bool? muted) async {
  //   var a = await _jitsiMeetPlugin.setAudioMuted(muted!);
  //   logPrint("$a");
  //   setState(() {
  //     audioMuted = muted;
  //   });
  // }

  // setVideoMuted(bool? muted) async {
  //   var a = await _jitsiMeetPlugin.setVideoMuted(muted!);
  //   logPrint("$a");
  //   setState(() {
  //     videoMuted = muted;
  //   });
  // }

  // sendEndpointTextMessage() async {
  //   var a = await _jitsiMeetPlugin.sendEndpointTextMessage(message: "HEY");
  //   logPrint("$a");

  //   for (var p in participants) {
  //     var b =
  //         await _jitsiMeetPlugin.sendEndpointTextMessage(to: p, message: "HEY");
  //     logPrint("$b");
  //   }
  // }

  // toggleScreenShare(bool? enabled) async {
  //   await _jitsiMeetPlugin.toggleScreenShare(enabled!);

  //   setState(() {
  //     screenShareOn = enabled;
  //   });
  // }

  // openChat() async {
  //   await _jitsiMeetPlugin.openChat();
  // }

  // sendChatMessage() async {
  //   var a = await _jitsiMeetPlugin.sendChatMessage(message: "HEY1");
  //   logPrint("$a");

  //   for (var p in participants) {
  //     a = await _jitsiMeetPlugin.sendChatMessage(to: p, message: "HEY2");
  //     logPrint("$a");
  //   }
  // }

  // closeChat() async {
  //   await _jitsiMeetPlugin.closeChat();
  // }

  // retrieveParticipantsInfo() async {
  //   var a = await _jitsiMeetPlugin.retrieveParticipantsInfo();
  //   logPrint("$a");
  // }
}
