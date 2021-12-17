import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/bloc/bloc.dart';
import 'package:stock_app/core/core.dart';
import 'package:stock_app/ui/styles/palette.dart';
import 'package:stock_app/ui/ui.dart';

class SearchResultScreen extends StatelessWidget {
  SearchResultScreen({Key? key}) : super(key: key);

  String? keyword;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments is String) {
      keyword = ModalRoute.of(context)!.settings.arguments as String;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchDataCubit(
            searchRepository: context.read<BaseSearchRepository>(),
            localStorageClient: context.read<BaseLocalStorageClient>(),
          )..getSearchResult(
              keyword: keyword ?? "",
            ),
        ),
        BlocProvider(
          create: (context) => SearchActionCubit(
            localStorageClient: context.read<BaseLocalStorageClient>(),
          ),
        ),
      ],
      child: SearchResultView(
        keyword: keyword,
      ),
    );
  }
}

class SearchResultView extends StatelessWidget {
  final String? keyword;

  const SearchResultView({
    Key? key,
    this.keyword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.finnHubSecondary,
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<SearchDataCubit>().getSearchResult(
              keyword: keyword ?? "",
            ),
        child: ListView(
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
                    "Search Result",
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
            _sectionResult(
              context,
              keyword: keyword,
            ),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionResult(
    BuildContext context, {
    String? keyword,
  }) {
    return BlocBuilder<SearchDataCubit, BaseState>(
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
            action: () async => context.read<SearchDataCubit>()
              ..getSearchResult(
                keyword: keyword ?? "",
              ),
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
              action: () async =>
                  context.read<SearchActionCubit>().addToWatchList(
                        stock: _resultsData?[index],
                      ),
            );
          },
        );
      },
    );
  }
}
