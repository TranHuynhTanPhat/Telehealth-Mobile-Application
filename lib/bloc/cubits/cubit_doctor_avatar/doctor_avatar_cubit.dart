// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/image_response.dart';
import 'package:healthline/repository/doctor_repository.dart';
import 'package:healthline/repository/file_repository.dart';

part 'doctor_avatar_state.dart';

class DoctorAvatarCubit extends Cubit<DoctorAvatarState> {
  DoctorAvatarCubit() : super(DoctorAvatarInitial());
  final FileRepository _fileRepository = FileRepository();
  final DoctorRepository _doctorRepository = DoctorRepository();

  Future<void> updateAvatar(String path, String doctorId) async {
    emit(DoctorAvatarUpdating());
    try {
      ImageResponse imageResponse = await _fileRepository.uploadImage(
          path: path,
          uploadPreset: dotenv.get('UPLOAD_PRESETS'),
          publicId: doctorId,
          folder: 'healthline/avatar/subusers');
      DataResponse response =
          await _doctorRepository.updateAvatar(imageResponse.publicId!);
      if (response.success) {
        emit(DoctorAvatarSuccessfully());
      }
    } catch (e) {
      DioException er = e as DioException;
      emit(
        DoctorAvatarError(
          message: er.message.toString(),
        ),
      );
    }
  }
}
