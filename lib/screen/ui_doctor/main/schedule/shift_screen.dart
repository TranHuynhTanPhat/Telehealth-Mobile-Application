import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/bases/base_gridview.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({super.key});

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  late DateTime _currentDate;
  @override
  void initState() {
    _currentDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResCubit(),
      child: BlocBuilder<ResCubit, ResState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: white,
            appBar: AppBar(
              title: Text(
                translate(context, 'your_shift'),
              ),
            ),
            body: SafeArea(
              child: ListView(
                padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                    child: Text(
                      formatyMMMMd(context, DateTime.now()),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: color1F1F1F.withOpacity(.3),
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                    child: Text(
                      translate(context, 'today'),
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  CalendarDatePicker(
                    initialDate: _currentDate,
                    firstDate: DateTime.now(), // Ngày tạo tk cho bác sĩ
                    lastDate: DateTime(2025),
                    currentDate: _currentDate,
                    onDateChanged: (value) {
                      setState(() {
                        _currentDate = value;
                      });
                    },
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 3,
                        vertical: dimensHeight()),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 10,
                                backgroundColor: colorCDDEFF,
                              ),
                              Text(
                                translate(context, 'available'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 10,
                                backgroundColor: colorDF9F1E,
                              ),
                              Text(
                                translate(context, 'booked'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const CircleAvatar(
                                radius: 10,
                                backgroundColor: colorCDDEFF,
                                child: CircleAvatar(
                                  radius: 9,
                                  backgroundColor: white,
                                ),
                              ),
                              Text(
                                translate(context, 'empty'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 3,
                        vertical: dimensHeight()),
                    child: const BaseGridview(radio: 3.2, children: [
                      ValidShift(time: '09:00'),
                      InvalidShift(
                        time: '09:30',
                      ),
                      BookedShift(
                        time: '10:00',
                      ),
                    ]),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BookedShift extends StatelessWidget {
  const BookedShift({
    super.key,
    required this.time,
  });
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: dimensWidth(),
      padding: EdgeInsets.all(
        dimensWidth(),
      ),
      decoration: BoxDecoration(
          color: colorDF9F1E,
          borderRadius: BorderRadius.circular(dimensWidth())),
      alignment: Alignment.center,
      child: Text(
        time,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

class InvalidShift extends StatelessWidget {
  const InvalidShift({
    super.key,
    required this.time,
  });
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: dimensWidth() * 3,
      padding: EdgeInsets.all(
        dimensWidth(),
      ),
      decoration: BoxDecoration(
          border: Border.all(width: .5, color: colorCDDEFF),
          color: white,
          borderRadius: BorderRadius.circular(dimensWidth())),
      alignment: Alignment.center,
      child: Text(
        time,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: color1F1F1F.withOpacity(.3)),
      ),
    );
  }
}

class ValidShift extends StatelessWidget {
  const ValidShift({
    super.key,
    required this.time,
  });
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: dimensWidth() * 3,
      padding: EdgeInsets.all(
        dimensWidth(),
      ),
      decoration: BoxDecoration(
          color: colorCDDEFF,
          borderRadius: BorderRadius.circular(dimensWidth())),
      alignment: Alignment.center,
      child: Text(
        time,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
