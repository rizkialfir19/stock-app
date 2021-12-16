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
    required StocksSymbol stock,
  }) async {
    /// Add to watch list with API from BE
    emit(LoadingState());

    await Future.delayed(const Duration(seconds: 2));

    emit(LoadedState());
  }
}
