// ignore_for_file: unused_field

import 'package:healthline/data/api/models/requests/file_request.dart';
import 'package:healthline/data/api/models/responses/file_response.dart';
import 'package:healthline/repository/base_repository.dart';
import 'package:healthline/data/api/services/file_service.dart';

class FileRepository extends BaseRepository {
  final FileService _fileService = FileService();

  Future<FileResponse> uploadFile(
      {required String path,
      required String publicId,}) async {
    FileRequest request = FileRequest(
        imagePath: path, publicId: publicId);
    return await _fileService.updateFile(request);
  }
  Future<String> downloadFile({required String url, required String filePath}) async{
    return await _fileService.downloadFile(filePath: filePath, url: url);
  }
}
