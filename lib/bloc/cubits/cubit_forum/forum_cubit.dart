// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:healthline/data/api/models/responses/comment_response.dart';
import 'package:healthline/data/api/socket_manager.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:meilisearch/meilisearch.dart';

import 'package:healthline/data/api/meilisearch_manager.dart';
import 'package:healthline/data/api/models/responses/post_response.dart';
import 'package:healthline/res/enum.dart';

part 'forum_state.dart';

class ForumCubit extends Cubit<ForumState> {
  ForumCubit() : super(ForumInitial(posts: [], blocState: BlocState.Successed));
  final MeiliSearchManager meiliSearchManager = MeiliSearchManager.instance;

  Future<void> searchPost(
      {required String key,
      SearchQuery? searchQuery,
      required int pageKey,
      required Function(List<PostResponse>) callback}) async {
    emit(
      SearchPostState(
          posts: state.posts, blocState: BlocState.Pending, pageKey: pageKey),
    );
    try {
      meiliSearchManager.index(uid: 'post');
      var result = await meiliSearchManager.search(key, searchQuery);
      List<PostResponse> doctors = List<PostResponse>.from(
        result.hits.map(
          (e) => PostResponse.fromMap(e),
        ),
      );
      callback(doctors);
      emit(
        SearchPostState(
            posts: doctors, blocState: BlocState.Successed, pageKey: pageKey),
      );
    } catch (error) {
      logPrint(error);
      emit(
        SearchPostState(
            error: error.toString(),
            posts: state.posts,
            blocState: BlocState.Failed,
            pageKey: pageKey),
      );
    }
  }

  Future<void> fetchComment({
    required String id,
    // required Function(List<CommentResponse>) callback,
  }) async {
    emit(
      FetchCommentState(
          posts: state.posts,
          blocState: BlocState.Pending,
          comments: [],
          idPost: id),
    );
    try {
      listen(data) {
        if (data == 'medical_record_not_found') {
          emit(
            FetchCommentState(
              error: 'medical_record_not_found',
              posts: state.posts,
              blocState: BlocState.Failed,
              comments: [],
              idPost: id,
            ),
          );
        } else {
          List<CommentResponse> comments = data
              .map<CommentResponse>((e) => CommentResponse.fromMap(e))
              .toList();
          emit(FetchCommentState(
              posts: state.posts,
              blocState: BlocState.Successed,
              comments: comments,
              idPost: id));
        }
      }

      SocketManager.instance.addListener(event: 'findAll', listener: listen);
      SocketManager.instance.sendDataWithAck(
          data: id, event: "findAll", listen: listen);
    } catch (error) {
      logPrint(error);
      emit(
        FetchCommentState(
          error: error.toString(),
          posts: state.posts,
          blocState: BlocState.Failed,
          comments: [],
          idPost: id,
        ),
      );
    }
  }
}
