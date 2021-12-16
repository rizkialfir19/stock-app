part of 'base_search_repository.dart';

class SearchRepository extends BaseSearchRepository {
  final BaseApiClient apiClient;
  final String baseUrl;

  SearchRepository({
    required this.apiClient,
    required this.baseUrl,
  });

  @override
  Future<List<StocksSymbol>> getSearchResultsStock({
    required String keyword,
  }) async {
    List<StocksSymbol> _results = [];

    Response fetchData = await apiClient.get(
      baseUrl + Url.searchStocksRepository + "?q=$keyword",
      headers: {
        "X-Finnhub-Token": EnvConfig.OPEN_API_KEY,
      },
    );

    if (fetchData.data != null) {
      List _rawData = fetchData.data['result'];
      for (Map singleData in _rawData) {
        _results.add(
          StocksSymbol.fromJson(
            Map<String, dynamic>.from(
              singleData,
            ),
          ),
        );
      }
    }

    return _results;
  }
}
