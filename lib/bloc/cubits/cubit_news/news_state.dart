part of 'news_cubit.dart';

class NewsState {
  List<NewsResponse> news;
  final BlocState blocState;
  final String? error;
  NewsState({
    required this.news,
    required this.blocState,
    this.error,
  });
}

final class NewsInitial extends NewsState {
  NewsInitial({required super.news, required super.blocState, super.error});
}

final class SearchNewsState extends NewsState {
  SearchNewsState({required super.news, required super.blocState, super.error, required this.pageKey});
  int pageKey;
}