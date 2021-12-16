import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stock_app/core/core.dart';
import 'package:stock_app/ui/screen/account/account_screen.dart';

import '../../../mocktail/mocktail.dart' as mocktail;

void main() {
  late mocktail.MockSignInCubit signInCubit;

  setUpAll(() {
    registerFallbackValue(mocktail.FakeBaseState());

    signInCubit = mocktail.MockSignInCubit();
  });

  Future pumpScreenWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<SignInCubit>.value(
        value: signInCubit,
        child: const MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
  }

  group("account_screen.dart", () {
    group("Given: Example - No Exception", () {
      testWidgets('When: Render AccoungtScreen - Then: Success',
          (WidgetTester tester) async {
        when(() => signInCubit.state).thenReturn(
          SuccessState(),
        );

        await pumpScreenWidget(tester);

        await expectLater(
          find.byType(AccountScreen),
          findsOneWidget,
        );
      });
    });
  });
}
