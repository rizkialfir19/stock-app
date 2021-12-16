import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/app_router.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';

class App extends StatelessWidget {
  final BaseLocalStorageClient localStorageClient;
  final BaseApiClient apiClient;
  final BaseFirebaseClient firebaseClient;
  final BaseStockRepository stockRepository;
  final BaseSearchRepository searchRepository;
  final BaseAuthenticationRepository authRepository;

  const App({
    Key? key,
    required this.localStorageClient,
    required this.apiClient,
    required this.firebaseClient,
    required this.stockRepository,
    required this.searchRepository,
    required this.authRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => localStorageClient,
        ),
        RepositoryProvider(
          create: (context) => apiClient,
        ),
        RepositoryProvider(
          create: (context) => firebaseClient,
        ),
        RepositoryProvider(
          create: (context) => stockRepository,
        ),
        RepositoryProvider(
          create: (context) => searchRepository,
        ),
        RepositoryProvider(
          create: (context) => authRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppSetupCubit(
              firebaseClient: firebaseClient,
            )..initialize(),
          ),
          BlocProvider(
            create: (context) => TabCubit(),
          ),
          BlocProvider(
            create: (context) => AuthenticationDataCubit(
              appSetupCubit: context.read<AppSetupCubit>(),
              localStorageClient: localStorageClient,
              firebaseClient: firebaseClient,
            ),
          ),
          BlocProvider(
            create: (context) => SignInCubit(
              localStorageClient: localStorageClient,
              authenticationRepository:
                  context.read<BaseAuthenticationRepository>(),
            ),
          ),
        ],
        child: const FinnhubApp(),
      ),
    );
  }
}

class FinnhubApp extends StatefulWidget {
  const FinnhubApp({Key? key}) : super(key: key);

  @override
  State<FinnhubApp> createState() => _FinnhubAppState();
}

class _FinnhubAppState extends State<FinnhubApp> {
  final AppRouter _appRouter = AppRouter();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  DateTime? _lastUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: _appRouter.onGenerateRoute,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationDataCubit, BaseState>(
                listener: (context, state) {
                  UserFinnhub? user;

                  if (state is AuthenticatedState) {
                    if (_lastUser == null) {
                      _lastUser = state.timestamp;
                      user = state.data;
                      // Trigger Patch Change Tab
                      context.read<TabCubit>().changeTab(tab: AppTab.account);
                      _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        RouteName.landingScreen,
                        (route) => false,
                        arguments: ScreenArgument(
                          data: UserFinnhub(
                            email: user?.email,
                            username: user?.fullName,
                            fullName: user?.fullName,
                            imageUrl: user?.imageUrl,
                            uid: user?.uid,
                            accessToken: user?.accessToken,
                            lastSignIn: user?.lastSignIn,
                          ),
                        ),
                      );
                    }
                  }

                  if (state is UnauthenticatedState) {
                    _lastUser = null;
                    // Can navigate to login/register screen if needed
                    _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                      RouteName.signInScreen,
                      (route) => false,
                    );
                  }
                },
              ),
            ],
            child: child!,
          ),
        );
      },
    );
  }
}
