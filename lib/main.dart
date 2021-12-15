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
  // final BaseProductRepository _productRepository = ProductRepository(
  //   baseUrl: _baseUrl,
  //   apiClient: _apiClient,
  // );

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
        // productRepository: _productRepository,
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
