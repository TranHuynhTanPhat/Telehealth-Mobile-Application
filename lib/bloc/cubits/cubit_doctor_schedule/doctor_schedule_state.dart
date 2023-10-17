part of 'doctor_schedule_cubit.dart';

class DoctorScheduleState {
  final List<ScheduleResponse> schedules;
  final String? scheduleId;
  DoctorScheduleState({
    required this.schedules,
    required this.scheduleId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'schedules': schedules.map((x) => x.toMap()).toList()});
    result.addAll({'scheduleId': scheduleId});

    return result;
  }

  factory DoctorScheduleState.fromMap(Map<String, dynamic> map) {
    return DoctorScheduleState(
        schedules: List<ScheduleResponse>.from(
            map['schedules']?.map((x) => ScheduleResponse.fromMap(x))),
        scheduleId: map['scheduleId']);
  }
}

final class DoctorScheduleInitial extends DoctorScheduleState {
  DoctorScheduleInitial({required super.schedules, required super.scheduleId});
}

abstract class FetchScheduleState extends DoctorScheduleState {
  FetchScheduleState({required super.schedules, required super.scheduleId});
}

abstract class CronScheduleState extends DoctorScheduleState {
  CronScheduleState({required super.schedules, required super.scheduleId});
}

final class FetchScheduleLoading extends FetchScheduleState {
  FetchScheduleLoading({required super.schedules, required super.scheduleId});
}

final class FetchScheduleSuccessfully extends FetchScheduleState {
  FetchScheduleSuccessfully(
      {required super.schedules, required super.scheduleId});
}

final class FetchScheduleError extends FetchScheduleState {
  FetchScheduleError(
      {required super.schedules,
      required this.message,
      required super.scheduleId});
  final String message;
}

final class CronScheduleLoading extends CronScheduleState {
  CronScheduleLoading({required super.schedules, required super.scheduleId});
}

final class CronScheduleSuccessfully extends CronScheduleState {
  CronScheduleSuccessfully(
      {required super.schedules, required super.scheduleId});
}

final class CronScheduleError extends CronScheduleState {
  CronScheduleError(
      {required super.schedules,
      required this.message,
      required super.scheduleId});
  final String message;
}

abstract class ScheduleByDayUpdateState extends DoctorScheduleState {
  ScheduleByDayUpdateState(
      {required super.schedules, required super.scheduleId});
}

final class ScheduleByDayUpdating extends ScheduleByDayUpdateState {
  ScheduleByDayUpdating({required super.schedules, required super.scheduleId});
}

final class ScheduleByDayUpdateSuccessfully extends ScheduleByDayUpdateState {
  ScheduleByDayUpdateSuccessfully(
      {required super.schedules, required super.scheduleId});
}

final class ScheduleByDayUpdateError extends ScheduleByDayUpdateState {
  ScheduleByDayUpdateError(
      {required super.schedules,
      required super.scheduleId,
      required this.message});
  final String message;
}

/// Fixed schedule
abstract class FixedScheduleState extends DoctorScheduleState {
  FixedScheduleState({required super.schedules, required super.scheduleId});
}

abstract class FixedScheduleUpdateState extends FixedScheduleState {
  FixedScheduleUpdateState(
      {required super.schedules, required super.scheduleId});
}

final class FixedScheduleUpdating extends FixedScheduleUpdateState {
  FixedScheduleUpdating({required super.schedules, required super.scheduleId});
}

final class FixedScheduleUpdateSuccessfully extends FixedScheduleUpdateState {
  FixedScheduleUpdateSuccessfully(
      {required super.schedules, required super.scheduleId});
}

final class FixedScheduleUpdateError extends FixedScheduleUpdateState {
  FixedScheduleUpdateError(
      {required super.schedules,
      required this.message,
      required super.scheduleId});
  final String message;
}
