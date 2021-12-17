import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/bloc/bloc.dart';
import 'package:stock_app/core/core.dart';
import 'package:stock_app/ui/ui.dart';

class WatchScreen extends StatelessWidget {
  const WatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchListCubit(
        localStorageClient: context.read<BaseLocalStorageClient>(),
      )..getWatchList(),
      child: const WatchView(),
    );
  }
}

class WatchView extends StatelessWidget {
  const WatchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Watch List",
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
        ],
      ),
    );
  }

  Widget _sectionContent(BuildContext context) {
    return BlocBuilder<WatchListCubit, BaseState>(
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
            action: () async => context.read<WatchListCubit>()..getWatchList(),
          );
        }

        if (state is LoadedState) {
          _resultsData = state.data;
        }

        return ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: _resultsData?.length,
          itemBuilder: (context, index) {
            return ContainerStock(
              stocks: _resultsData?[index],
              isWatchList: true,
            );
          },
        );
      },
    );
  }
}
