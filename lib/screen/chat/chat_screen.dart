// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubit_chat/chat_cubit.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';

import 'package:healthline/data/api/models/responses/room_chat.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/data/storage/data_constants.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/chat/components/export.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  // final SocketManager _socketManager = SocketManager(port: PortSocket.chat);
  String? medicalId;

  @override
  void initState() {
    if (!mounted) return;
    if (AppController().authState == AuthState.PatientAuthorized) {
      context.read<MedicalRecordCubit>().fetchMedicalRecord();
      if (context.read<MedicalRecordCubit>().state.currentId != null) {
        medicalId = context.read<MedicalRecordCubit>().state.currentId;
        context.read<ChatCubit>().fetchRoomChat(
              medicalId: medicalId!,
            );
      }
    } else {
      context.read<ChatCubit>().fetchRoomChatDoctor();
    }
    // logPrint(AppController().authState);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (AppController().authState == AuthState.DoctorAuthorized) {
          var user = LoginResponse.fromJson(
              AppStorage().getString(key: DataConstants.DOCTOR)!);
          if (user.id != null) {
            context
                .read<ChatCubit>()
                .socketManager
                .stopEvent(event: "room.doctor.${user.id}");
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        backgroundColor: white,
        appBar: AppBar(
          surfaceTintColor: transparent,
          scrolledUnderElevation: 0,
          backgroundColor: white,
          title: Padding(
            padding: EdgeInsets.only(left: dimensWidth()),
            child: Text(
              translate(context, 'message'),
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: color1F1F1F, fontWeight: FontWeight.w900),
            ),
          ),
          centerTitle: false,
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            List<RoomChat> rooms = state.rooms;
            return ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth() * 3, vertical: dimensHeight()),
              shrinkWrap: true,
              children: [
                if (AppController().authState == AuthState.PatientAuthorized)
                  BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
                    builder: (context, state) {
                      return SizedBox(
                        height: dimensHeight() * 18,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            ...state.subUsers.map(
                              (e) => Padding(
                                padding:
                                    EdgeInsets.only(right: dimensWidth() * 2),
                                child: InkWell(
                                  splashColor: transparent,
                                  hoverColor: transparent,
                                  highlightColor: transparent,
                                  onTap: () {
                                    if (e.id != null && medicalId != e.id) {
                                      context.read<ChatCubit>().fetchRoomChat(
                                            medicalId: e.id!,
                                          );
                                      medicalId = e.id;
                                    }
                                  },
                                  child: SubUser(
                                      user: e, choosed: e.id == medicalId),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                TextFieldWidget(
                  // focusNode: _focus,
                  validate: (p0) => null,
                  hint: translate(context, 'search'),
                  fillColor: colorF2F5FF,
                  filled: true,
                  focusedBorderColor: colorF2F5FF,
                  enabledBorderColor: colorF2F5FF,
                  controller: _searchController,
                  onChanged: (value) {
                    // roomChats.where((element) =>
                    //     element.doctor?.fullName == _searchController.text);
                  },
                  prefixIcon: IconButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
                    onPressed: () {},
                    icon: InkWell(
                      splashColor: transparent,
                      highlightColor: transparent,
                      onTap: () {},
                      child: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: color6A6E83,
                        size: dimensIcon() * .8,
                      ),
                    ),
                  ),
                  suffixIcon: IconButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
                    onPressed: () {},
                    icon: InkWell(
                      splashColor: transparent,
                      highlightColor: transparent,
                      onTap: () {
                        // if (_searchController.text.isNotEmpty) {
                        //   _searchController.text = '';
                        //   _pagingController.refresh();
                        // } else {
                        //   KeyboardUtil.hideKeyboard(context);
                        //   _checkFocus();
                        // }
                      },
                      child: FaIcon(
                        FontAwesomeIcons.solidCircleXmark,
                        color: color6A6E83,
                        size: dimensIcon() * .5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: dimensHeight() * 3,
                ),
                if (AppController().authState == AuthState.PatientAuthorized)
                  ...rooms.map(
                    (e) {
                      return RoomChatPatient(detail: e);
                    },
                  ),
                if (AppController().authState == AuthState.DoctorAuthorized)
                  ...rooms.map(
                    (e) {
                      return RoomChatDoctor(detail: e);
                    },
                  ),
              ],
            );
          },
        ),
        // },
        // ),
      ),
    );
  }
}

class SubUser extends StatefulWidget {
  const SubUser({
    super.key,
    required this.user,
    required this.choosed,
  });
  final UserResponse user;
  final bool choosed;

  @override
  State<SubUser> createState() => _SubUserState();
}

class _SubUserState extends State<SubUser> {
  var _image;

  @override
  Widget build(BuildContext context) {
    try {
      if (widget.user.avatar != null &&
          widget.user.avatar != 'default' &&
          widget.user.avatar != '') {
        _image = _image ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(widget.user.avatar ?? '')
                  .toString(),
            );
      } else {
        _image = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      _image = AssetImage(DImages.placeholder);
    }
    return SizedBox(
      width: dimensWidth() * 8,
      child: Column(
        children: [
          Container(
            width: dimensWidth() * 8,
            height: dimensWidth() * 8,
            decoration: BoxDecoration(
              border: widget.choosed
                  ? Border.all(
                      width: 5,
                      color: primary,
                      strokeAlign: BorderSide.strokeAlignCenter)
                  : null,
              borderRadius: BorderRadius.circular(360),
              image: DecorationImage(
                  image: _image,
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    setState(() {
                      _image = AssetImage(DImages.placeholder);
                    });
                  }),
            ),
          ),
          SizedBox(
            height: dimensHeight(),
          ),
          Expanded(
            child: Text(
              widget.user.fullName ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
