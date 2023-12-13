part of 'doctor_schedule_cubit.dart';

class DoctorScheduleState {
  final List<ScheduleResponse> schedules;
  final String? scheduleId;
  final BlocState blocState;
  final String? error;
  DoctorScheduleState({
    required this.schedules,
    required this.scheduleId,
    required this.blocState,
    this.error,
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
        scheduleId: map['scheduleId'],
        blocState: BlocState.Successed);
  }
}

final class DoctorScheduleInitial extends DoctorScheduleState {
  DoctorScheduleInitial(
      {required super.schedules,
      required super.scheduleId,
      required super.blocState});
}

class FetchScheduleState extends DoctorScheduleState {
  FetchScheduleState(
      {required super.schedules,
      required super.scheduleId,
      required super.blocState,
      super.error});
}

// abstract class CronScheduleState extends DoctorScheduleState {
//   CronScheduleState({required super.schedules, required super.scheduleId});
// }

// final class FetchScheduleLoading extends FetchScheduleState {
//   FetchScheduleLoading({required super.schedules, required super.scheduleId});
// }

// final class FetchScheduleSuccessfully extends FetchScheduleState {
//   FetchScheduleSuccessfully(
//       {required super.schedules, required super.scheduleId});
// }

// final class FetchScheduleError extends FetchScheduleState {
//   FetchScheduleError(
//       {required super.schedules,
//       required this.message,
//       required super.scheduleId});
//   final String message;
// }

// final class CronScheduleLoading extends CronScheduleState {
//   CronScheduleLoading({required super.schedules, required super.scheduleId});
// }

// final class CronScheduleSuccessfully extends CronScheduleState {
//   CronScheduleSuccessfully(
//       {required super.schedules, required super.scheduleId});
// }

// final class CronScheduleError extends CronScheduleState {
//   CronScheduleError(
//       {required super.schedules,
//       required this.message,
//       required super.scheduleId});
//   final String message;
// }

class UpdateScheduleByDayState extends DoctorScheduleState {
  UpdateScheduleByDayState(
      {required super.schedules,
      required super.scheduleId,
      required super.blocState,
      super.error});
}

// final class ScheduleByDayUpdating extends ScheduleByDayUpdateState {
//   ScheduleByDayUpdating({required super.schedules, required super.scheduleId});
// }

// final class ScheduleByDayUpdateSuccessfully extends ScheduleByDayUpdateState {
//   ScheduleByDayUpdateSuccessfully(
//       {required super.schedules, required super.scheduleId});
// }

// final class ScheduleByDayUpdateError extends ScheduleByDayUpdateState {
//   ScheduleByDayUpdateError(
//       {required super.schedules,
//       required super.scheduleId,
//       required this.message});
//   final String message;
// }

/// Fixed schedule
class FetchFixedScheduleState extends DoctorScheduleState {
  FetchFixedScheduleState(
      {required super.schedules,
      required super.scheduleId,
      required super.blocState,
      super.error});
}

class UpdateFixedScheduleState extends DoctorScheduleState {
  UpdateFixedScheduleState(
      {required super.schedules,
      required super.scheduleId,
      required super.blocState,
      super.error});
}

// final class FixedScheduleUpdating extends FixedScheduleUpdateState {
//   FixedScheduleUpdating({required super.schedules, required super.scheduleId});
// }

// final class FixedScheduleUpdateSuccessfully extends FixedScheduleUpdateState {
//   FixedScheduleUpdateSuccessfully(
//       {required super.schedules, required super.scheduleId});
// }

// final class FixedScheduleUpdateError extends FixedScheduleUpdateState {
//   FixedScheduleUpdateError(
//       {required super.schedules,
//       required this.message,
//       required super.scheduleId});
//   final String message;
// }
