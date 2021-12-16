import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';

part 'authentication_state.dart';

class AuthenticationDataCubit extends Cubit<BaseState<UserFinnhub>> {
  final AppSetupCubit appSetupCubit;
  final BaseFirebaseClient firebaseClient;
  final BaseLocalStorageClient localStorageClient;

  late StreamSubscription appSetupCubitSubs;

  AuthenticationDataCubit({
    required this.appSetupCubit,
    required this.firebaseClient,
    required this.localStorageClient,
  }) : super(InitializedState()) {
    appSetupCubitSubs = appSetupCubit.stream.listen((state) {
      if (state == AppSetupState.success) {
        initialize();
      }
    });
  }

  @override
  Future<void> close() {
    appSetupCubitSubs.cancel();
    return super.close();
  }

  void initialize() async {
    debugPrint("---> Enter initialize authDataCubit");
    String? _rawUserData;
    UserFinnhub? _userData;

    /// Get & Check Local UserData
    try {
      ///TODO: Get User Data
      _rawUserData = await localStorageClient.getByKey(
        SharedPrefKey.userData,
        SharedPrefType.string,
      );

      debugPrint('[$this - getUserData] - Result : $_rawUserData');

      if (_rawUserData == null) {
        emit(UnauthenticatedState());
        return;
      }
    } catch (e, s) {
      debugPrint("---> Masuk error e: $e");
      debugPrint("---> Masuk error s: $s");
      emit(UnauthenticatedState());
      return;
    }

    /// Parse Raw User Data To Model
    try {
      _userData = UserFinnhub.fromJson(jsonDecode(_rawUserData));
      debugPrint('[$this] - Get User Name : ${_userData.username}');

      if (_userData.email == null) {
        emit(UnauthenticatedState());
        return;
      }
    } catch (e, s) {
      debugPrint("---> Enter error e: $e");
      debugPrint("---> Enter error s: $s");
      emit(UnauthenticatedState());
      return;
    }

    /// All Passed
    emit(
      AuthenticatedState(
        data: _userData,
        timestamp: DateTime.now(),
      ),
    );
  }
}
