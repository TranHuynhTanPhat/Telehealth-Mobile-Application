// ignore_for_file: unused_field

import 'package:healthline/data/api/models/requests/file_request.dart';
import 'package:healthline/data/api/models/responses/file_response.dart';
import 'package:healthline/repository/base_repository.dart';
import 'package:healthline/data/api/services/file_service.dart';

class FileRepository extends BaseRepository {
  final FileService _fileService = FileService();

  Future<FileResponse> uploadAvatarUser({
    required String path,
    required String publicId,
  }) async {
    FileRequest request = FileRequest(imagePath: path, publicId: publicId);
    return await _fileService.uploadAvatarUser(request);
  }

  Future<FileResponse> uploadAvatarDoctor({
    required String path,
  }) async {
    FileRequest request = FileRequest(imagePath: path);
    return await _fileService.uploadAvatarDoctor(request);
  }

  Future<String> downloadFile(
      {required String url, required String filePath}) async {
    return await _fileService.downloadFile(filePath: filePath, url: url);
  }
}
