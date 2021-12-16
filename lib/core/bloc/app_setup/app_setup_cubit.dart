import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';

class AppSetupCubit extends Cubit<AppSetupState> {
  final BaseFirebaseClient firebaseClient;

  AppSetupCubit({
    required this.firebaseClient,
  }) : super(AppSetupState.uninitialized);

  /// Initialize all setups that required by the application
  void initialize() async {
    try {
      await firebaseClient.initializeApp();
      await firebaseClient.initializeAuth();

      await Future.delayed(const Duration(seconds: 2));

      emit(AppSetupState.success);
    } catch (e) {
      emit(AppSetupState.failed);
    }
  }
}
