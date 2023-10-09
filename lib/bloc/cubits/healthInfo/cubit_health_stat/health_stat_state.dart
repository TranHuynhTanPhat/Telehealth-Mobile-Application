part of 'health_stat_cubit.dart';

class HealthStatState {
  final List<HealthStatResponse> stats;
  HealthStatState({
    required this.stats,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'stats': stats.map((x) => x.toMap()).toList()});

    return result;
  }

  factory HealthStatState.fromMap(Map<String, dynamic> map) {
    return HealthStatState(
      stats: List<HealthStatResponse>.from(
          map['stats']?.map((x) => HealthStatResponse.fromMap(x))),
    );
  }
}

final class HealthStatInitial extends HealthStatState {
  HealthStatInitial({required super.stats});
}

abstract class UpdateStat extends HealthStatState {
  UpdateStat({required super.stats});
}

final class HealthStatLoading extends HealthStatState {
  HealthStatLoading({required super.stats});
}

final class HealthStatError extends HealthStatState {
  HealthStatError({required super.stats, required this.message});
  final String message;
}

final class UpdateStatLoading extends UpdateStat {
  UpdateStatLoading({required super.stats});
}

final class UpdateStatSuccessfully extends UpdateStat {
  UpdateStatSuccessfully({required super.stats});
}

final class UpdateStatError extends UpdateStat {
  UpdateStatError({required super.stats, required this.message});
  final String message;
}
