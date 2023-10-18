import 'package:dio/dio.dart';
import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/file_request.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/file_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class FileService extends BaseService {
  Future<FileResponse> uploadAvatarPatient(FileRequest request) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        request.path!,
      ),
      "public_id": request.publicId!,
    });
    final response =
        await putUpload(ApiConstants.UPLOAD_AVATAR_USER, formData: formData);
    return FileResponse.fromMap(response.data);
  }

  Future<FileResponse> uploadAvatarDoctor(FileRequest request) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        request.path!,
      ),
    });
    final response = await putUpload(ApiConstants.UPLOAD_AVATAR_DOCTOR,
        formData: formData, isDoctor: true);
    return FileResponse.fromMap(response.data);
  }

  Future<FileResponse> uploadRecordPatient(FileRequest request) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        request.path!,
      ),
      "folder": request.folder
    });
    final response = await putUpload(ApiConstants.UPLOAD_RECORD,
        formData: formData, isDoctor: true);
    return FileResponse.fromMap(response.data);
  }

  Future<DataResponse> deleteRecordPatient(FileRequest request) async {
    final response = await delete(
        '${ApiConstants.UPLOAD_RECORD}/${request.folder}/${request.publicId}',
        isDoctor: true);
    return response;
  }

  Future<DataResponse> deleteFolderPatient(FileRequest request) async {
    final response = await delete(
        '${ApiConstants.UPLOAD_RECORD}/${request.folder}',
        isDoctor: true);
    return response;
  }

  Future<String> downloadFile(
      {required String filePath, required String url}) async {
    final response = await download(filePath: filePath, url: url);
    return response;
  }
}
