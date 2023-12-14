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
      required String content}) async {
    PostRequest request = PostRequest(
        files: files,
        dto: PostResponse(
          id: idPost,
          description: content,
        ));
    return await _forumService.editPost(request);
  }

  Future<int?> likePost({
    required String idPost,
  }) async {
    return await _forumService.likePost(idPost);
  }

  Future<int?> unlikePost({
    required String idPost,
  }) async {
    return await _forumService.unlikePost(idPost);
  }

  Future<int?> deletePost({
    required String idPost,
  }) async {
    return await _forumService.deletePost(idPost);
  }
}
