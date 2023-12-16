import 'package:dio/dio.dart';
import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/post_request.dart';
import 'package:healthline/data/api/services/base_service.dart';

class ForumService extends BaseService {
  Future<int?> editPost(
      {required PostRequest request, bool isDoctor = false}) async {
    FormData formData = FormData.fromMap({
      "files":
          request.files.map((e) async => await MultipartFile.fromFile(e!.path)),
      // await MultipartFile.fromFile(
      //   request.files!,
      // ),
      "dto": request.dto.toJson(),
    });
    final response = await putUpload(ApiConstants.UPLOAD_POST,
        formData: formData, isDoctor: isDoctor);
    return response.code;
  }

  Future<int?> likePost({required String idPost, bool isDoctor = false}) async {
    final response = await patch('${ApiConstants.FORUM_POST}/$idPost/like',
        isDoctor: isDoctor);
    return response.code;
  }

  Future<int?> unlikePost(
      {required String idPost, bool isDoctor = false}) async {
    final response = await patch('${ApiConstants.FORUM_POST}/$idPost/unlike',
        isDoctor: true);
    return response.code;
  }

  Future<int?> deletePost(
      {required String idPost, bool isDoctor = false}) async {
    final response =
        await delete('${ApiConstants.FORUM_POST}/$idPost', isDoctor: isDoctor);
    return response.code;
  }
}
