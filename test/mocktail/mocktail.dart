import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';

///Cubits
class MockStockSymbolDataCubit extends MockCubit<BaseState>
    implements StockSymbolDataCubit {}

class MockStockSymbolActionCubit extends MockCubit<BaseState>
    implements StockSymbolActionCubit {}

///Fakes
class FakeBaseStateExampleData extends Fake implements BaseState<StocksSymbol> {
}

class FakeBaseState extends Fake implements BaseState {}
