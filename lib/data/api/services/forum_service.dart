import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/post_request.dart';
import 'package:healthline/data/api/models/responses/post_response.dart';
import 'package:healthline/data/api/services/base_service.dart';
import 'package:healthline/utils/log_data.dart';

class ForumService extends BaseService {
  Future<int?> editPost(
      {required PostRequest request, bool isDoctor = false}) async {
    List<MultipartFile> files = [];

    for (var e in request.files) {
      try {
        files.add(await MultipartFile.fromFile(e!.path));
      } catch (e) {
        logPrint(e);
      }
    }

    // request.files.map((e) async {
    //   try {
    //     print(e?.path);
    //     files.add(await MultipartFile.fromFile(e!.path));
    //     // formData.files.addAll([
    //     //   MapEntry("files", await MultipartFile.fromFile(e!.path)),
    //     // ]);
    //   } catch (e) {
    //     print(e);
    //   }
    // });

    FormData formData = FormData.fromMap({
      "files": files,
      // await MultipartFile.fromFile(
      //   request.files!,
      // ),
      "dto": request.dto.toJson(),
    });

    // FormData.fromMap({
    //   "files":
    //       request.files.map((e) async => await MultipartFile.fromFile(e!.path)),
    //   // await MultipartFile.fromFile(
    //   //   request.files!,
    //   // ),
    //   "dto": request.dto.toJson(),
    // });
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
        isDoctor: isDoctor);
    return response.code;
  }

  Future<int?> deletePost(
      {required String idPost, bool isDoctor = false}) async {
    final response =
        await delete('${ApiConstants.FORUM_POST}/$idPost', isDoctor: isDoctor);
    return response.code;
  }

  Future<List<PostResponse>> fetchPostIds(
      {required List<String> ids, bool isDoctor = false}) async {
    var jsonRequest = json.encode({
      "ids": ids,
    });
    final response = await get(ApiConstants.FORUM_POST,
        data: jsonRequest, isDoctor: isDoctor);
    return List<PostResponse>.from(
      response.data.map(
        (e) => PostResponse.fromMap(e),
      ),
    );
  }

  Future<List<PostResponse>> fetchPostPage(
      {required int pageKey, required int limit, bool isDoctor = false}) async {
    final response = await get("${ApiConstants.FORUM_POST}/$pageKey/$limit",
        isDoctor: isDoctor);
    return List<PostResponse>.from(
      response.data.map(
        (e) => PostResponse.fromMap(e),
      ),
    );
  }
}
