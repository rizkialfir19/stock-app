import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_app/ui/ui.dart';

void main() {
  Future pumpScreenWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ContainerSocialMediaButton(
          title: "Continue With Google",
        ),
      ),
    );
  }

  group("container_social_media_button_stock.dart", () {
    group("Given: Example - No Exception", () {
      testWidgets('When: Render ContainerSocialMediaButton - Then: Success',
          (WidgetTester tester) async {
        await pumpScreenWidget(tester);

        await expectLater(
          find.byType(ContainerSocialMediaButton),
          findsOneWidget,
        );
      });
    });
  });
}
