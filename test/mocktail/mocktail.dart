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

class MockSearchDataCubit extends MockCubit<BaseState>
    implements SearchDataCubit {}

class MockSearchActionCubit extends MockCubit<BaseState>
    implements SearchActionCubit {}

class MockSignInCubit extends MockCubit<BaseState> implements SignInCubit {}

///Fakes
class FakeBaseStateExampleData extends Fake implements BaseState<StocksSymbol> {
}

class FakeBaseState extends Fake implements BaseState {}
