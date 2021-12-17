import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';

class WatchListCubit extends Cubit<BaseState> {
  final BaseLocalStorageClient localStorageClient;

  WatchListCubit({
    required this.localStorageClient,
  }) : super(InitializedState());

  /// Get watch list from local
  void getWatchList() async {
    emit(LoadingState());

    await Future.delayed(const Duration(seconds: 2));

    List<StocksSymbol> _stocksData = [];
    String? _rawStocksData;

    /// Get from shared preference
    try {
      _rawStocksData = await localStorageClient.getByKey(
        SharedPrefKey.watchStockData,
        SharedPrefType.string,
      );

      if (_rawStocksData != null) {
        _stocksData = StocksSymbol.decode(_rawStocksData);
      }
    } catch (e) {
      debugPrint("===> Error $e");
      emit(
        ErrorState(
          error: '$this - Get Watch List Data] - Error : $e',
          timestamp: DateTime.now(),
        ),
      );
      return;
    }

    /// All validate pass
    emit(LoadedState(
      data: _stocksData,
      timestamp: DateTime.now(),
    ));
  }
}
