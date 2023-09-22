part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.doctors,
  });
  final List<DoctorResponse> doctors;

  @override
  List<Object> get props => [doctors];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'doctors': doctors.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory HomeState.fromMap(Map<String, dynamic> map) {
    return HomeState(
      doctors: List<DoctorResponse>.from(map['doctors']?.map((x) => DoctorResponse.fromMap(x))),
    );
  }
}
