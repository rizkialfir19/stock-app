import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';
import 'package:stock_app/ui/styles/font_helper.dart';
import 'package:stock_app/ui/styles/palette.dart';
import 'package:stock_app/ui/ui.dart';

class StocksScreen extends StatelessWidget {
  const StocksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StockSymbolDataCubit(
            stockRepository: context.read<BaseStockRepository>(),
            localStorageClient: context.read<BaseLocalStorageClient>(),
          )..getData(
              exchange: "JK",
            ),
        ),
        BlocProvider(
          create: (context) => StockSymbolActionCubit(
            // stockRepository: context.read<BaseStockRepository>(),
            localStorageClient: context.read<BaseLocalStorageClient>(),
          ),
        ),
      ],
      child: const StockView(),
    );
  }
}

class StockView extends StatelessWidget {
  const StockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => context.read<StockSymbolDataCubit>()
          ..getData(
            exchange: "JK",
          ),
        child: ListView(
          children: [
            _sectionHeader(),
            const SizedBox(
              height: 15.0,
            ),
            const ContainerSearchBar(),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Stocks",
                    style: FontHelper.custom(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Palette.finnHubSecondary,
                    size: 30.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            _sectionContent(context),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader() {
    return Container(
      height: 100.0,
      width: double.maxFinite,
      color: Palette.finnHubBackgroundDark,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Image.asset(
          Images.iconFinnhub,
          height: 200.0,
          width: 200.0,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _sectionContent(BuildContext context) {
    return BlocBuilder<StockSymbolDataCubit, BaseState>(
      builder: (context, state) {
        List<StocksSymbol>? _resultsData;

        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Palette.finnHubSecondary,
            ),
          );
        }

        if (state is EmptyState) {
          return const EmptyOrErrorData(
            category: StateCategory.empty,
          );
        }

        if (state is ErrorState) {
          return EmptyOrErrorData(
            category: StateCategory.error,
            action: () async => context.read<StockSymbolDataCubit>()
              ..getData(
                exchange: "JK",
              ),
          );
        }

        if (state is LoadedState) {
          _resultsData = state.data;
        }

        return BlocListener<StockSymbolActionCubit, BaseState>(
          listener: (context, actionState) {
            StocksSymbol _data;

            if (actionState is LoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: SizedBox(
                    height: 100.0,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Palette.finnHubSecondary,
                      ),
                    ),
                  ),
                ),
              );
            }

            if (actionState is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    actionState.error,
                  ),
                ),
              );
            }

            if (actionState is SuccessState) {
              _data = actionState.data;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Successfully add ${_data.symbol} to watch list.',
                  ),
                ),
              );
            }
          },
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _resultsData?.length,
            itemBuilder: (context, index) {
              return ContainerStock(
                stocks: _resultsData?[index],
                action: () async =>
                    context.read<StockSymbolActionCubit>().addToWatchList(
                          stock: _resultsData?[index],
                        ),
              );
            },
          ),
        );
      },
    );
  }
}
