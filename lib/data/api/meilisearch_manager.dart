import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meilisearch/meilisearch.dart';

class MeiliSearchManager {
  static final MeiliSearchManager instance = MeiliSearchManager._internal();
  factory MeiliSearchManager() {
    return instance;
  }
  MeiliSearchManager._internal();

  late MeiliSearchClient _client;
  late MeiliSearchIndex _index;

  void init() {
    _client = MeiliSearchClient(dotenv.get('MEILI_SEARCH_HOST', fallback: ''),
        dotenv.get('MEILI_SEARCH_KEY', fallback: ''));
  }

  void index({required String uid}) {
    _index = _client.index(uid);
  }

  Future<Searcheable> search(String text, SearchQuery? searchQuery) async {
    var result = await _index.search(text, searchQuery);
    return result;
  }
}
