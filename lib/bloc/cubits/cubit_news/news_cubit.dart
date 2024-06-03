// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:healthline/data/api/meilisearch_manager.dart';
import 'package:healthline/data/api/models/responses/news_response.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:meilisearch/meilisearch.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit()
      : super(
          NewsInitial(
            news: [],
            blocState: BlocState.Successed,
          ),
        );

  final MeiliSearchManager meiliSearchManager = MeiliSearchManager.instance;

  Future<void> searchNews(
      {required String key,
      SearchQuery? searchQuery,
      required int pageKey,
      required Function(List<NewsResponse>) callback}) async {
    emit(
      SearchNewsState(
          news: state.news, blocState: BlocState.Pending, pageKey: pageKey),
    );
    try {
      meiliSearchManager.index(uid: 'blog');
      var result = await meiliSearchManager.search(key, searchQuery);
      List<NewsResponse> news = List<NewsResponse>.from(
        result.hits.map(
          (e) => NewsResponse.fromMap(e),
        ),
      );
      callback(news);
      emit(
        SearchNewsState(
            news: news, blocState: BlocState.Successed, pageKey: pageKey),
      );
    } catch (error) {
      logPrint(error);
      emit(
        SearchNewsState(
            error: error.toString(),
            news: state.news,
            blocState: BlocState.Failed,
            pageKey: pageKey),
      );
    }
  }
}
