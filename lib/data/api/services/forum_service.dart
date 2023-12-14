import 'package:dio/dio.dart';
import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/post_request.dart';
import 'package:healthline/data/api/services/base_service.dart';

class ForumService extends BaseService {
  Future<int?> editPost(PostRequest request) async {
    FormData formData = FormData.fromMap({
      "files":
          request.files.map((e) async => await MultipartFile.fromFile(e!.path)),
      // await MultipartFile.fromFile(
      //   request.files!,
      // ),
      "dto": request.dto.toJson(),
    });
    final response =
        await putUpload(ApiConstants.UPLOAD_POST, formData: formData);
    return response.code;
  }

  Future<int?> likePost(String idPost) async {
    final response = await patch('${ApiConstants.FORUM_POST}/$idPost/like');
    return response.code;
  }
  Future<int?> unlikePost(String idPost) async {
    final response = await patch('${ApiConstants.FORUM_POST}/$idPost/unlike');
    return response.code;
  }
  Future<int?> deletePost(String idPost) async {
    final response = await delete('${ApiConstants.FORUM_POST}/$idPost');
    return response.code;
  }
}
