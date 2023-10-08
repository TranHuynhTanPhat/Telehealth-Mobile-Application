// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';

import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class SubUserCard extends StatefulWidget {
  const SubUserCard({
    super.key,
    required this.subUser,
    required this.index,
  });
  final UserResponse subUser;
  final int index;

  @override
  State<SubUserCard> createState() => _SubUserCardState();
}

class _SubUserCardState extends State<SubUserCard> {
  var _image;
  @override
  void initState() {
    _image = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _image = _image ??
        NetworkImage(
          CloudinaryContext.cloudinary
              .image(widget.subUser.avatar ?? '')
              .toString(),
        );
    return BlocBuilder<SubUserCubit, SubUserState>(
      builder: (context, state) {
        return InkWell(
          splashColor: transparent,
          highlightColor: transparent,
          onTap: () =>
              context.read<SubUserCubit>().updateIndex(widget.index),
          child: Padding(
            padding: EdgeInsets.all(
                state.currentUser == widget.index ? 0 : dimensWidth()*.5),
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: dimensWidth(), horizontal: dimensWidth()*.5),
              alignment: Alignment.bottomCenter,
              width:
                  dimensWidth() * (state.currentUser == widget.index ? 10 : 9),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(dimensWidth() * 2),
                  image: DecorationImage(
                      onError: (exception, stackTrace) {
                        setState(() {
                          _image = AssetImage(DImages.placeholder);
                        });
                      },
                      image: _image,
                      fit: BoxFit.cover)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth(),
                  vertical: dimensHeight() * .5,
                ),
                width: dimensWidth() * 10,
                // height: dimensWidth() * 4,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.0), white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(dimensWidth() * 2),
                        bottomRight: Radius.circular(dimensWidth() * 2))),
                child: Text(
                  widget.subUser.fullName != null
                      ? widget.subUser.fullName!.split(' ').last
                      : translate(context, 'undefine'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
