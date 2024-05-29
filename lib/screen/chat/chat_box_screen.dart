// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubit_chat/chat_cubit.dart';
import 'package:healthline/data/api/models/responses/room_chat.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/chat/components/export.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class ChatBoxScreen extends StatefulWidget {
  const ChatBoxScreen({super.key, required this.detail});
  final RoomChat? detail;

  @override
  State<ChatBoxScreen> createState() => _ChatBoxScreenState();
}

class _ChatBoxScreenState extends State<ChatBoxScreen> {
  final TextEditingController _textController = TextEditingController();
  var _image;

  @override
  void initState() {
    if (!mounted) return;
    if (widget.detail == null || widget.detail?.id == null) return;
    if (widget.detail?.doctor?.avatar != null) {
      _image = NetworkImage(CloudinaryContext.cloudinary
          .image(widget.detail?.doctor?.avatar ?? '')
          .toString());
    } else {
      _image = AssetImage(DImages.placeholder);
    }
    context.read<ChatCubit>().fetchMessage(
          roomId: widget.detail!.id!,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is SendMessageState &&
            state.blocState == BlocState.Successed) {
          _textController.text = "";
        }
      },
      child: GestureDetector(
        onTap: () => KeyboardUtil.hideKeyboard(context),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: colorF2F5FF,
          extendBody: true,
          // bottomSheet: Container(color: color9D4B6C, height: dimensHeight()*10,),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.0), white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.fromLTRB(
                dimensWidth() * 2,
                0,
                dimensWidth() * 2,
                MediaQuery.of(context).viewInsets.bottom + dimensHeight() * 3),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth(), vertical: dimensWidth()),
              decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(dimensWidth() * 2)),
              child: TextFieldWidget(
                validate: (p0) => null,
                hint: translate(context, 'texting'),
                fillColor: white,
                filled: true,
                focusedBorderColor: colorF2F5FF,
                enabledBorderColor: colorF2F5FF,
                controller: _textController,
                onChanged: (p0) => setState(() {}),
                suffix: InkWell(
                  onTap: () {
                    if (_textController.text.trim().isNotEmpty) {
                      context
                          .read<ChatCubit>()
                          .sendMessage(text: _textController.text.trim());
                    }
                  },
                  child: FaIcon(
                    FontAwesomeIcons.solidPaperPlane,
                    color: primary,
                    size: dimensIcon() * 2 / 3,
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(widget.detail?.doctor!.fullName ??
                    translate(context, 'undefine')),
                SizedBox(
                  width: dimensWidth(),
                ),
                CircleAvatar(
                  backgroundColor: primary,
                  backgroundImage: _image,
                  radius: dimensHeight() * 2.5,
                  onBackgroundImageError: (exception, stackTrace) {
                    logPrint(exception);
                    setState(() {
                      _image = AssetImage(DImages.placeholder);
                    });
                  },
                ),
              ],
            ),
            backgroundColor: white,
            // backgroundColor: ,
            centerTitle: false,
          ),
          body: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth() * 3,
                ),
                reverse: true,
                shrinkWrap: false,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom +
                            dimensHeight() * 15),
                  ),
                  ...state.messages.map(
                    (e) {
                      if (AppController().authState ==
                          AuthState.PatientAuthorized) {
                        if (e.senderId == widget.detail?.doctor?.id) {
                          return MessageBoxReceiveMiddle(message: e);
                        } else {
                          return MessageBoxSendMiddle(message: e);
                        }
                      }else{
                        if (e.senderId != widget.detail?.doctor?.id) {
                          return MessageBoxReceiveMiddle(message: e);
                        } else {
                          return MessageBoxSendMiddle(message: e);
                        }
                      }
                    },
                  ),
                  // MessageBoxReceiveBottom(message: "MessageBoxReceiveBottom"),
                  // MessageBoxReceiveMiddle(message: "MessageBoxReceiveMiddle"),
                  // MessageBoxReceiveTop(message: "MessageBoxReceiveTop"),
                  // MessageBoxSendBottom(message: "MessageBoxSendBottom"),
                  // MessageBoxSendMiddle(message: "MessageBoxSendMiddle"),
                  // MessageBoxSendTop(message: "MessageBoxSendTop"),
                  // MessageBoxReceiveBottom(message: "MessageBoxReceiveBottom"),
                  // MessageBoxReceiveMiddle(message: "MessageBoxReceiveMiddle"),
                  // MessageBoxReceiveTop(message: "MessageBoxReceiveTop"),
                  // MessageBoxSendBottom(message: "MessageBoxSendBottom"),
                  // MessageBoxSendMiddle(message: "MessageBoxSendMiddle"),
                  // MessageBoxSendTop(message: "MessageBoxSendTop"),
                  // MessageBoxReceiveBottom(message: "MessageBoxReceiveBottom"),
                  // MessageBoxReceiveMiddle(message: "MessageBoxReceiveMiddle"),
                  // MessageBoxReceiveTop(message: "MessageBoxReceiveTop"),
                  // MessageBoxSendBottom(message: "MessageBoxSendBottom"),
                  // MessageBoxSendMiddle(message: "MessageBoxSendMiddle"),
                  // MessageBoxSendTop(message: "MessageBoxSendTop"),
                  // MessageBoxReceiveBottom(message: "MessageBoxReceiveBottom"),
                  // MessageBoxReceiveMiddle(message: "MessageBoxReceiveMiddle"),
                  // MessageBoxReceiveTop(message: "MessageBoxReceiveTop"),
                  // MessageBoxSendBottom(message: "MessageBoxSendBottom"),
                  // MessageBoxSendMiddle(message: "MessageBoxSendMiddle"),
                  // MessageBoxSendTop(message: "MessageBoxSendTop"),
                  // MessageBoxReceiveBottom(message: "MessageBoxReceiveBottom"),
                  // MessageBoxReceiveMiddle(message: "MessageBoxReceiveMiddle"),
                  // MessageBoxReceiveTop(message: "MessageBoxReceiveTop"),
                  // MessageBoxSendBottom(message: "MessageBoxSendBottom"),
                  // MessageBoxSendMiddle(message: "MessageBoxSendMiddle"),
                  // MessageBoxSendTop(message: "MessageBoxSendTop"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
