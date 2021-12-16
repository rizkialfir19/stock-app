import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stock_app/core/bloc/bloc.dart';
import 'package:stock_app/ui/ui.dart';

import '../../../mocktail/mocktail.dart' as mocktail;

void main() {
  late mocktail.MockStockSymbolDataCubit stockSymbolDataCubit;
  late mocktail.MockStockSymbolActionCubit stockSymbolActionCubit;

  setUpAll(() {
    registerFallbackValue(mocktail.FakeBaseState());

    stockSymbolDataCubit = mocktail.MockStockSymbolDataCubit();
    stockSymbolActionCubit = mocktail.MockStockSymbolActionCubit();
  });

  Future pumpScreenWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<StockSymbolDataCubit>.value(
            value: stockSymbolDataCubit,
          ),
          BlocProvider<StockSymbolActionCubit>.value(
            value: stockSymbolActionCubit,
          ),
        ],
        child: const MaterialApp(
          home: StockView(),
        ),
      ),
    );
  }

  group("stock_screen.dart", () {
    group("Given: Example - No Exception", () {
      testWidgets('When: Render StockScreen - Then: Success',
          (WidgetTester tester) async {
        // when(() => stockSymbolDataCubit.state).thenReturn(
        //   LoadedState(),
        // );
        //
        // when(() => stockSymbolActionCubit.state).thenReturn(
        //   LoadedState(),
        // );

        await pumpScreenWidget(tester);

        await expectLater(
          find.byType(StockView),
          findsOneWidget,
        );
      });
    });
  });
}
