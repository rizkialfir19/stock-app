import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/ui/ui.dart';

void main() {
  Future pumpScreenWidget(WidgetTester tester) async {
    StocksSymbol _dummyData = StocksSymbol(
      currency: "IDR",
      description: "BANK WOORI SAUDARA INDONESIA",
      displaySymbol: "SDRA.JK",
      figi: "BBG000LDYZ84",
      mic: "XIDX",
      symbol: "SDRA.JK",
      type: "Common Stock",
    );

    await tester.pumpWidget(
      MaterialApp(
        home: ContainerStock(
          stocks: _dummyData,
        ),
      ),
    );
  }

  group("container_stock.dart", () {
    group("Given: Example - No Exception", () {
      testWidgets('When: Render ContainerStock - Then: Success',
          (WidgetTester tester) async {
        await pumpScreenWidget(tester);

        await expectLater(
          find.byType(ContainerStock),
          findsOneWidget,
        );
      });
    });
  });
}
