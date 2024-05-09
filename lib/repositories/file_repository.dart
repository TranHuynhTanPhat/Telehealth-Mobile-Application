// ignore_for_file: unused_field

import 'dart:io';

import 'package:healthline/data/api/models/requests/file_request.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/file_response.dart';
import 'package:healthline/repositories/base_repository.dart';
import 'package:healthline/data/api/services/file_service.dart';

class FileRepository extends BaseRepository {
  final FileService _fileService = FileService();

  Future<FileResponse> uploadAvatarPatient({
    required String path,
    required String publicId,
  }) async {
    FileRequest request = FileRequest(path: path, publicId: publicId);
    return await _fileService.uploadAvatarPatient(request);
  }

  Future<FileResponse> uploadAvatarDoctor({
    required String path,
  }) async {
    FileRequest request = FileRequest(path: path);
    return await _fileService.uploadAvatarDoctor(request);
  }

  Future<FileResponse> uploadRecordPatient({
    required String medicalId,
    required String path,
    required String folder,
  }) async {
    FileRequest request = FileRequest(path: path, folder: folder);
    return await _fileService.uploadRecordPatient(medicalId, request);
  }

  Future<DataResponse> deleteRecordPatient({
    required String publicId,
    required String folder,
  }) async {
    FileRequest request = FileRequest(publicId: publicId, folder: folder);
    return await _fileService.deleteRecordPatient(request);
  }

  Future<DataResponse> deleteFolderPatient({
    required String medicalId,
    required String folderName,
  }) async {
    return await _fileService.deleteFolderPatient(medicalId, folderName);
  }

  Future<String> downloadFile(
      {required String url, required String filePath}) async {
    return await _fileService.downloadFile(filePath: filePath, url: url);
  }

  Future<List<String>> uploadImageSpecialty(
      {required List<File?> images, required String phone}) async {
    DataResponse response =
        await _fileService.uploadImageSpecialty(images: images, phone: phone);
        List<String> result = List<String>.from(response.data);
    return result;
  }
}
