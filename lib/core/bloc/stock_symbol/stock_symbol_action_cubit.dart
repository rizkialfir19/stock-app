import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';

class StockSymbolActionCubit extends Cubit<BaseState> {
  final BaseLocalStorageClient localStorageClient;

  StockSymbolActionCubit({
    required this.localStorageClient,
  }) : super(InitializedState());
  // final BaseProductRepository productRepository;

  void addToWatchList({
    required StocksSymbol? stock,
  }) async {
    /// Add to watch list with API from BE
    emit(LoadingState());

    print("----> enter");
    print("----> enter stocks $stock");
    print("----> enter stocks1 ${stock?.description}");
    print("----> enter stocks2 ${stock?.symbol}");

    await Future.delayed(const Duration(seconds: 2));

    List<StocksSymbol> _stocksData = [];
    String? _rawStocksData;

    _rawStocksData = await localStorageClient.getByKey(
      SharedPrefKey.watchStockData,
      SharedPrefType.string,
    );

    if (_rawStocksData != null) {
      _stocksData.add(jsonDecode(_rawStocksData) as StocksSymbol);
      // _stocksData.add(StocksSymbol.fromJson(jsonDecode(_rawStocksData)));
      print("----> stocks before: $_stocksData");
    }

    if (stock != null) {
      _stocksData.add(stock);
      print("----> stocks after: $_stocksData");
      await localStorageClient.saveByKey(
        jsonEncode(_stocksData.toString()),
        SharedPrefKey.watchStockData,
        SharedPrefType.string,
      );
    }

    emit(LoadedState());
  }
}
