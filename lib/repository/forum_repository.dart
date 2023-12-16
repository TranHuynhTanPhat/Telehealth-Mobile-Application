// ignore_for_file: unused_field
import 'dart:io';

import 'package:healthline/data/api/models/requests/post_request.dart';
import 'package:healthline/data/api/models/responses/post_response.dart';
import 'package:healthline/data/api/services/forum_service.dart';
import 'package:healthline/repository/base_repository.dart';

class ForumRepository extends BaseRepository {
  final ForumService _forumService = ForumService();

  Future<int?> editPost(
      {required List<File?> files,
      String? idPost,
      required String content,
      bool isDoctor = false}) async {
    PostRequest request = PostRequest(
        files: files,
        dto: PostResponse(
          id: idPost,
          description: content,
        ));
    return await _forumService.editPost(request: request, isDoctor: isDoctor);
  }

  Future<int?> likePost({required String idPost, bool isDoctor = false}) async {
    return await _forumService.likePost(idPost: idPost, isDoctor: isDoctor);
  }

  Future<int?> unlikePost({
    required String idPost,
bool isDoctor =false
  }) async {
    return await _forumService.unlikePost(idPost:idPost, isDoctor:isDoctor);
  }

  Future<int?> deletePost({
    required String idPost,
    bool isDoctor = false
  }) async {
    return await _forumService.deletePost(idPost:idPost, isDoctor:isDoctor);
  }
}
