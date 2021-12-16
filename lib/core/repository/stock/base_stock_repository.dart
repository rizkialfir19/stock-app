import 'package:dio/dio.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';

part 'stock_repository.dart';

abstract class BaseStockRepository {
  Future<List<StocksSymbol>> getStockSymbolList({
    required String exchange,
  });
}
