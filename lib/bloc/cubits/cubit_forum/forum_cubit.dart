import 'dart:convert';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/repositories/forum_repository.dart';
import 'package:meilisearch/meilisearch.dart';

import 'package:healthline/data/api/meilisearch_manager.dart';
import 'package:healthline/data/api/models/responses/comment_response.dart';
import 'package:healthline/data/api/models/responses/post_response.dart';
import 'package:healthline/data/api/socket_manager.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';

part 'forum_state.dart';

class ForumCubit extends Cubit<ForumState> {
  ForumCubit()
      : super(ForumInitial(
            blocState: BlocState.Successed, comments: [], currentPost: null));
  final MeiliSearchManager meiliSearchManager = MeiliSearchManager.instance;
  final ForumRepository _forumRepository = ForumRepository();

  Future<void> searchPost(
      {required String key,
      SearchQuery? searchQuery,
      required int pageKey,
      required Function(List<PostResponse>) callback}) async {
    emit(
      SearchPostState(
          blocState: BlocState.Pending,
          pageKey: pageKey,
          comments: [],
          currentPost: null),
    );
    try {
      meiliSearchManager.index(uid: 'post');
      var result = await meiliSearchManager.search(key, searchQuery);
      List<PostResponse> posts = List<PostResponse>.from(
        result.hits.map(
          (e) => PostResponse.fromMap(e),
        ),
      );
      List<String> ids = [];
      for (var element in posts) {
        try {
          ids.add(element.id!);
        } catch (e) {
          logPrint(e);
        }
      }
      posts = await _forumRepository.fetchPostIds(
          ids: ids,
          isDoctor: AppController().authState == AuthState.DoctorAuthorized);
      callback(posts);
      emit(
        SearchPostState(
            blocState: BlocState.Successed,
            pageKey: pageKey,
            comments: state.comments,
            currentPost: state.currentPost),
      );
    } catch (error) {
      logPrint(error);
      emit(
        SearchPostState(
            error: error.toString(),
            blocState: BlocState.Failed,
            pageKey: pageKey,
            comments: state.comments,
            currentPost: state.currentPost),
      );
    }
  }

  Future<void> fetchPostPage(
      {required int pageKey,
      required int limit,
      required Function(List<PostResponse>) callback}) async {
    emit(
      FetchPostState(
          blocState: BlocState.Pending,
          pageKey: pageKey,
          comments: [],
          currentPost: null),
    );
    try {
      List<PostResponse> posts = await _forumRepository.fetchPostPage(
          pageKey: pageKey,
          limit: limit,
          isDoctor: AppController().authState == AuthState.DoctorAuthorized);
      callback(posts);
      emit(
        FetchPostState(
            blocState: BlocState.Successed,
            pageKey: pageKey,
            comments: state.comments,
            currentPost: state.currentPost),
      );
    } catch (error) {
      logPrint(error);
      emit(
        FetchPostState(
            error: error.toString(),
            blocState: BlocState.Failed,
            pageKey: pageKey,
            comments: state.comments,
            currentPost: state.currentPost),
      );
    }
  }

  Future<void> fetchComment({
    required String idPost,
    // required Function(List<CommentResponse>) callback,
  }) async {
    if (idPost != state.currentPost) {
      emit(
        FetchCommentState(
            blocState: BlocState.Pending, comments: [], currentPost: idPost),
      );
      try {
        SocketManager.instance.addListener(
            event: 'comment',
            listener: (data) {
              if (idPost == state.currentPost) {
                CommentResponse response = CommentResponse.fromMap(data);
                List<CommentResponse> comments = List.from(state.comments);
                if (comments
                    .where((element) => element.id == response.id)
                    .isEmpty) {
                  comments.add(response);
                }
                emit(CreateCommentState(
                    blocState: BlocState.Successed,
                    comments: comments,
                    currentPost: state.currentPost));
              }
            });
        SocketManager.instance.sendDataWithAck(
            data: idPost,
            event: "findAll",
            listen: (data) {
              // if (data != 'medical_record_not_found') {
              List<CommentResponse> comments = data
                  .map<CommentResponse>((e) => CommentResponse.fromMap(e))
                  .toList();
              emit(FetchCommentState(
                  blocState: BlocState.Successed,
                  comments: comments,
                  currentPost: idPost));
              // } else {
              //   emit(FetchCommentState(
              //       blocState: BlocState.Successed,
              //       comments: [],
              //       currentPost: idPost));
              // }
            });
      } catch (error) {
        logPrint(error);
        emit(
          FetchCommentState(
            error: error.toString(),
            blocState: BlocState.Failed,
            comments: [],
            currentPost: idPost,
          ),
        );
      }
    }
  }

  Future<void> createComment({required String idPost, required String content
      // required Function(List<CommentResponse>) callback,
      }) async {
    emit(
      CreateCommentState(
          blocState: BlocState.Pending,
          comments: state.comments,
          currentPost: idPost),
    );
    try {
      // listen(data) {
      //   if (idPost == state.currentPost) {
      //     CommentResponse response = CommentResponse.fromMap(data);
      //     List<CommentResponse> comments = List.from(state.comments);
      //     if (comments.where((element) => element.id == response.id).isEmpty) {
      //       comments.add(response);
      //     }
      //     emit(CreateCommentState(
      //         blocState: BlocState.Successed,
      //         comments: comments,
      //         currentPost: state.currentPost));
      //   }
      // }

      // SocketManager.instance.addListener(event: 'comment', listener: listen);
      SocketManager.instance.sendDataWithAck(
          data: jsonEncode({"postId": idPost, "text": content}),
          event: "create",
          listen: (data) {
            if (idPost == state.currentPost) {
              CommentResponse response = CommentResponse.fromMap(data);
              List<CommentResponse> comments = List.from(state.comments);
              if (comments
                  .where((element) => element.id == response.id)
                  .isEmpty) {
                comments.add(response);
              }
              emit(CreateCommentState(
                  blocState: BlocState.Successed,
                  comments: comments,
                  currentPost: state.currentPost));
            }
          });
      emit(CreateCommentState(
          blocState: BlocState.Successed,
          comments: state.comments,
          currentPost: state.currentPost));
    } catch (error) {
      logPrint(error);
      emit(
        CreateCommentState(
          error: error.toString(),
          blocState: BlocState.Failed,
          comments: state.comments,
          currentPost: idPost,
        ),
      );
    }
  }

  Future<void> editPost(
      {String? idPost,
      required List<File?> files,
      required String content}) async {
    emit(
      EditPostState(
          blocState: BlocState.Pending,
          currentPost: state.currentPost,
          comments: state.comments),
    );
    try {
      // files.forEach((element) {print(element?.path);});
      int? code = await _forumRepository.editPost(
          idPost: idPost,
          content: content,
          files: files,
          isDoctor: AppController().authState == AuthState.DoctorAuthorized);
      if (code == 200 || code == 201) {
        
        emit(
          EditPostState(
              blocState: BlocState.Successed,
              currentPost: state.currentPost,
              comments: state.comments),
        );
      } else {
        throw "failure";
      }
    } catch (error) {
      emit(
        EditPostState(
            blocState: BlocState.Failed,
            currentPost: state.currentPost,
            error: error.toString(),
            comments: state.comments),
      );
    }
  }

  Future<void> likePost({
    required String idPost,
  }) async {
    emit(
      LikePostState(
          blocState: BlocState.Pending,
          currentPost: state.currentPost,
          comments: state.comments),
    );
    try {
      int? code = await _forumRepository.likePost(
          idPost: idPost,
          isDoctor: AppController().authState == AuthState.DoctorAuthorized);
      if (code == 200 || code == 201) {
        emit(
          LikePostState(
              blocState: BlocState.Successed,
              currentPost: state.currentPost,
              comments: state.comments),
        );
      } else {
        throw "failure";
      }
    } on DioException catch (e) {
      emit(
        LikePostState(
            blocState: BlocState.Failed,
            error: e.response!.data['message'].toString(),
            currentPost: state.currentPost,
            comments: state.comments),
      );
    } catch (error) {
      emit(
        LikePostState(
            blocState: BlocState.Failed,
            error: error.toString(),
            currentPost: state.currentPost,
            comments: state.comments),
      );
    }
  }

  Future<void> unlikePost({
    required String idPost,
  }) async {
    emit(
      UnlikePostState(
          blocState: BlocState.Pending,
          currentPost: state.currentPost,
          comments: state.comments),
    );
    try {
      int? code = await _forumRepository.unlikePost(
          idPost: idPost,
          isDoctor: AppController().authState == AuthState.DoctorAuthorized);
      if (code == 200 || code == 201) {
        emit(
          UnlikePostState(
              blocState: BlocState.Successed,
              currentPost: state.currentPost,
              comments: state.comments),
        );
      } else {
        throw "failure";
      }
    } on DioException catch (e) {
      emit(
        UnlikePostState(
            blocState: BlocState.Failed,
            error: e.response!.data['message'].toString(),
            currentPost: state.currentPost,
            comments: state.comments),
      );
    } catch (error) {
      emit(
        UnlikePostState(
            blocState: BlocState.Failed,
            error: error.toString(),
            currentPost: state.currentPost,
            comments: state.comments),
      );
    }
  }

  Future<void> deletePost({
    required String idPost,
  }) async {
    emit(
      DeletePostState(
          blocState: BlocState.Pending,
          currentPost: state.currentPost,
          comments: state.comments),
    );
    try {
      int? code = await _forumRepository.deletePost(
          idPost: idPost,
          isDoctor: AppController().authState == AuthState.DoctorAuthorized);
      if (code == 200 || code == 201) {
        emit(
          DeletePostState(
              blocState: BlocState.Successed,
              currentPost: state.currentPost,
              comments: state.comments),
        );
      } else {
        throw "failure";
      }
    } on DioException catch (e) {
      emit(
        DeletePostState(
            blocState: BlocState.Failed,
            error: e.response!.data['message'].toString(),
            currentPost: state.currentPost,
            comments: state.comments),
      );
    } catch (error) {
      emit(
        DeletePostState(
            blocState: BlocState.Failed,
            error: error.toString(),
            currentPost: state.currentPost,
            comments: state.comments),
      );
    }
  }
}
