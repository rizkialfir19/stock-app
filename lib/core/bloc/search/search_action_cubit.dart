import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';

class SearchActionCubit extends Cubit<BaseState> {
  final BaseLocalStorageClient localStorageClient;

  SearchActionCubit({
    required this.localStorageClient,
  }) : super(InitializedState());

  void addToWatchList({
    required StocksSymbol? stock,
  }) async {
    /// Add to watch list with API from BE
    emit(LoadingState());

    await Future.delayed(const Duration(seconds: 2));

    List<StocksSymbol> _stocksData = [];
    String? _rawStocksData;

    _rawStocksData = await localStorageClient.getByKey(
      SharedPrefKey.watchStockData,
      SharedPrefType.string,
    );

    if (_rawStocksData != null) {
      _stocksData = StocksSymbol.decode(_rawStocksData);
    }

    if (stock != null) {
      for (var element in _stocksData) {
        if (element.symbol == stock.symbol) {
          return emit(
            ErrorState(error: "Stocks already in your watch list."),
          );
        }
      }
      _stocksData.add(stock);

      await localStorageClient.saveByKey(
        StocksSymbol.encode(_stocksData),
        SharedPrefKey.watchStockData,
        SharedPrefType.string,
      );
    }

    emit(SuccessState(
      data: stock,
      timestamp: DateTime.now(),
    ));
  }
}
