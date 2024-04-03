part of 'doctor_cubit.dart';

class DoctorState {
  const DoctorState({
    required this.doctors,
    required this.blocState,
    this.recentDoctors = const <DoctorResponse>[],
    this.wishDoctors = const <DoctorResponse>[],
    this.error,
    required this.pageKey,
  });
  final List<DoctorResponse> doctors;
  final List<DoctorResponse> recentDoctors;
  final List<DoctorResponse> wishDoctors;
  final BlocState blocState;
  final String? error;
  final int pageKey;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    // result.addAll({'doctors': doctors.map((x) => x.toMap()).toList()});
    // if(recentDoctors!=[]) {
      result.addAll(
        {'recentDoctors': recentDoctors.map((x) => x.toMap()).toList()});
    // }
    // result.addAll({'wishDoctos': wishDoctors});
    // result.addAll({'blocState': blocState.toMap()});
    // if(error != null){
    //   result.addAll({'error': error});
    // }

    return result;
  }

  factory DoctorState.fromMap(Map<String, dynamic> map) {
    return DoctorState(
      doctors: [],
      recentDoctors: List<DoctorResponse>.from(
        map['recentDoctors']?.map(
          (x) => DoctorResponse.fromMap(x),
        ),
      ),
      wishDoctors: [],
      blocState: BlocState.Successed,
      error: null,
      pageKey: 0,
    );
  }
}

// final class DoctorInitial extends DoctorState {
//   DoctorInitial(
//       {required super.doctors,
//       required super.blocState,
//       super.error,});
// }

// final class SearchDoctorState extends DoctorState {
//   SearchDoctorState(
//       {required super.doctors,
//       required super.blocState,
//       required this.pageKey,
//       super.recentDoctors,
//       super.error,});
//   int pageKey;
// }
