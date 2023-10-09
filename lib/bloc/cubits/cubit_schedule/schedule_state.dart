part of 'schedule_cubit.dart';

class ScheduleState {
  List<ScheduleResponse> schedules;
  ScheduleState({
    required this.schedules,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'schedules': schedules.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ScheduleState.fromMap(Map<String, dynamic> map) {
    return ScheduleState(
      schedules: List<ScheduleResponse>.from(
          map['schedules']?.map((x) => ScheduleResponse.fromMap(x))),
    );
  }
}

final class ScheduleInitial extends ScheduleState {
  ScheduleInitial({required super.schedules});
}

abstract class FetchSchedule extends ScheduleState {
  FetchSchedule({required super.schedules});
}

class FetchScheduleLoading extends FetchSchedule {
  FetchScheduleLoading({required super.schedules});
}

class FetchScheduleSuccessfully extends FetchSchedule {
  FetchScheduleSuccessfully({required super.schedules});
}

class FetchScheduleError extends FetchSchedule {
  FetchScheduleError({required super.schedules, required this.message});
  final String message;
}
