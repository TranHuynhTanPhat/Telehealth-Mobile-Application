// ignore_for_file: unused_field

import 'package:healthline/data/api/models/requests/image_request.dart';
import 'package:healthline/data/api/models/responses/image_response.dart';
import 'package:healthline/data/api/repositories/base_repository.dart';
import 'package:healthline/data/api/services/file_service.dart';

class FileRepository extends BaseRepository {
  final FileService _fileService = FileService();

  Future<ImageResponse> uploadImage(
      {required String path,
      required String uploadPreset,
      required String publicId, required String folder}) async {
    ImageRequest request = ImageRequest(
        imagePath: path, uploadPreset: uploadPreset, publicId: publicId, folder: folder);
    return await _fileService.uploadImage(request);
  }
}
