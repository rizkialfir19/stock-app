import 'package:dio/dio.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';

part 'search_repository.dart';

abstract class BaseSearchRepository {
  Future<List<StocksSymbol>> getSearchResultsStock({
    required String keyword,
  });
}
