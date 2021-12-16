import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';

class SignInCubit extends Cubit<BaseState> {
  final BaseLocalStorageClient localStorageClient;
  final BaseAuthenticationRepository authenticationRepository;

  SignInCubit({
    required this.localStorageClient,
    required this.authenticationRepository,
  }) : super(InitializedState());

  /// Get User Google Data
  Future<void> signInWithGoogle() async {
    emit(LoadingState());

    await Future.delayed(const Duration(seconds: 2));

    User? _firebaseUser;
    UserFinnhub? _userData;

    /// Get google data from repository
    try {
      _firebaseUser = await authenticationRepository.signInGoogle();

      _userData = UserFinnhub(
        email: _firebaseUser?.email,
        username: _firebaseUser?.displayName,
        fullName: _firebaseUser?.displayName,
        imageUrl: _firebaseUser?.photoURL,
        uid: _firebaseUser?.uid,
        accessToken: _firebaseUser?.refreshToken,
        lastSignIn: _firebaseUser?.metadata.lastSignInTime.toString(),
      );
    } catch (e, s) {
      debugPrint("----> e: $e");
      debugPrint("----> s: $s");
      emit(
        ErrorState(
          error: 'Sign in Failure Exception',
        ),
      );
      return;
    }

    /// Save googleData to shared preference
    try {
      await localStorageClient.saveByKey(
        jsonEncode(
          _userData.toJson(),
        ),
        SharedPrefKey.userData,
        SharedPrefType.string,
      );
    } catch (e, s) {
      debugPrint("----> e: $e");
      debugPrint("----> s: $s");
      emit(
        ErrorState(
          error: 'Terjadi Kesalahan, silahkan coba lagi!',
        ),
      );
      return;
    }

    /// All validate pass
    emit(
      SuccessState(
        data: _userData,
        timestamp: DateTime.now(),
      ),
    );
  }

  Future<void> signOut() async {
    emit(LoadingState());

    await Future.delayed(const Duration(seconds: 2));

    try {
      await authenticationRepository.signOut();

      await localStorageClient.deleteByKey(
        SharedPrefKey.userData,
      );
    } catch (e) {
      debugPrint("----> e: $e");
      emit(
        ErrorState(
          error: 'Terjadi Kesalahan, silahkan coba lagi!',
        ),
      );
      return;
    }

    /// All Validate Pass
    emit(
      SuccessState(
        timestamp: DateTime.now(),
      ),
    );
  }
}
