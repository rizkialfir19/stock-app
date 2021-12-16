import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_app/app.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Clients instantiation
  final BaseLocalStorageClient _localStorageClient =
      SharedPreferenceClient.instance;
  final BaseApiClient _apiClient = DioClient.instance;
  final BaseFirebaseClient _firebaseClient = FirebaseClient.instance;

  /// Change Base Url Here
  final String _baseUrl = EnvConfig.BASE_PROD_URL;

  // Repositories instantiation
  final BaseStockRepository _stockRepository = StockRepository(
    baseUrl: _baseUrl,
    apiClient: _apiClient,
  );
  final BaseSearchRepository _searchRepository = SearchRepository(
    baseUrl: _baseUrl,
    apiClient: _apiClient,
  );
  final BaseAuthenticationRepository _authRepository = AuthenticationRepository(
    firebaseClient: _firebaseClient,
  );

  // Disable Landscape Mode
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runZonedGuarded(
    () => runApp(
      App(
        //Client
        apiClient: _apiClient,
        localStorageClient: _localStorageClient,
        firebaseClient: _firebaseClient,
        //Repository
        stockRepository: _stockRepository,
        searchRepository: _searchRepository,
        authRepository: _authRepository,
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
