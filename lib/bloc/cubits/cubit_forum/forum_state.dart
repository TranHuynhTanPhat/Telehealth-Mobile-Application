part of 'forum_cubit.dart';

sealed class ForumState {
  const ForumState(
      {
      // required this.posts,
      required this.blocState,
      this.error,
      required this.comments,
      required this.currentPost});
  // final List<PostResponse> posts;
  final BlocState blocState;
  final String? error;
  final List<CommentResponse> comments;
  final String? currentPost;
}

final class ForumInitial extends ForumState {
  ForumInitial(
      {required super.blocState,
      super.error,
      required super.comments,
      required super.currentPost});
}

final class SearchPostState extends ForumState {
  SearchPostState(
      {required super.blocState,
      super.error,
      required this.pageKey,
      required super.comments,
      required super.currentPost});
  int pageKey;
}
final class FetchPostState extends ForumState {
  FetchPostState(
      {required super.blocState,
      super.error,
      required this.pageKey,
      required super.comments,
      required super.currentPost});
  int pageKey;
}

final class FetchCommentState extends ForumState {
  FetchCommentState(
      {required super.blocState,
      super.error,
      required super.comments,
      required super.currentPost});
}
final class CreateCommentState extends ForumState {
  CreateCommentState(
      {required super.blocState,
      super.error,
      required super.comments,
      required super.currentPost});
}

final class EditPostState extends ForumState {
  EditPostState(
      {required super.blocState,
      super.error,
      required super.comments,
      required super.currentPost});
}

final class LikePostState extends ForumState {
  LikePostState(
      {required super.blocState,
      super.error,
      required super.currentPost,
      required super.comments});
}

final class UnlikePostState extends ForumState {
  UnlikePostState(
      {required super.blocState,
      super.error,
      required super.comments,
      required super.currentPost});
}

final class DeletePostState extends ForumState {
  DeletePostState(
      {required super.blocState,
      super.error,
      required super.comments,
      required super.currentPost});
}
