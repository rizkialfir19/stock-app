import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';

class SearchDataCubit extends Cubit<BaseState> {
  final BaseLocalStorageClient localStorageClient;
  final BaseSearchRepository searchRepository;

  SearchDataCubit({
    required this.localStorageClient,
    required this.searchRepository,
  }) : super(InitializedState());

  /// Get Search Result
  void getSearchResult({
    required String keyword,
  }) async {
    emit(LoadingState());

    List<StocksSymbol> _results = [];

    /// Get search result from repository
    try {
      _results = await searchRepository.getSearchResultsStock(keyword: keyword);

      if (_results.isEmpty) {
        emit(EmptyState());
        return;
      }
    } catch (e, s) {
      debugPrint("===> Error $e");
      debugPrint("===> Error $s");
      emit(
        ErrorState(
          error: '$this - Get Search Stocks Data] - Error : $e',
          timestamp: DateTime.now(),
        ),
      );
      return;
    }

    /// All validate pass
    emit(
      LoadedState(
        data: _results,
        timestamp: DateTime.now(),
      ),
    );
  }
}
