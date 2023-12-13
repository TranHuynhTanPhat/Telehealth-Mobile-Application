part of 'forum_cubit.dart';

sealed class ForumState {
  const ForumState({
    required this.posts,
    required this.blocState,
    this.error,
  });
  final List<PostResponse> posts;
  final BlocState blocState;
  final String? error;
}

final class ForumInitial extends ForumState {
  ForumInitial({required super.posts, required super.blocState, super.error});
}

final class SearchPostState extends ForumState {
  SearchPostState(
      {required super.posts,
      required super.blocState,
      super.error,
      required this.pageKey});
  int pageKey;
}

final class FetchCommentState extends ForumState {
  FetchCommentState(
      {required super.posts,
      required super.blocState,
      super.error,
      required this.comments,
      required this.idPost});
  final String idPost;
  final List<CommentResponse> comments;
}
