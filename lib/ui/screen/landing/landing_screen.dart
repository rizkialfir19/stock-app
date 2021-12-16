import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';
import 'package:stock_app/ui/screen/account/account_screen.dart';
import 'package:stock_app/ui/screen/screen.dart';
import 'package:stock_app/ui/ui.dart';

// ignore: must_be_immutable
class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

  UserFinnhub? userData;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments is UserFinnhub) {
      userData = ModalRoute.of(context)!.settings.arguments as UserFinnhub;
    }

    return BlocBuilder<TabCubit, AppTab>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Palette.transparent,
          extendBody: true,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Palette.finnHubBackgroundDark,
            selectedItemColor: Palette.finnHubPrimary,
            unselectedItemColor: Palette.grey,
            selectedLabelStyle: FontHelper.h9Regular(
              color: Palette.finnHubPrimary,
            ),
            unselectedLabelStyle: FontHelper.h9Regular(
              color: Palette.grey,
            ),
            showUnselectedLabels: true,
            onTap: (index) => context.read<TabCubit>().changeTab(
                  tab: AppTab.values[index],
                ),
            currentIndex: AppTab.values.indexOf(state),
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: Palette.greyLighten1,
                      ),
                    ),
                  ),
                ),
                activeIcon: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Palette.finnHubPrimary,
                    ),
                  ),
                ),
                label: 'Account',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: const Icon(
                        Icons.home_outlined,
                        color: Palette.greyLighten1,
                      ),
                    ),
                  ),
                ),
                activeIcon: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: const Icon(
                      Icons.home_rounded,
                      color: Palette.finnHubPrimary,
                    ),
                  ),
                ),
                label: 'Stocks',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: const Icon(
                        Icons.watch_later_outlined,
                        color: Palette.greyLighten1,
                      ),
                    ),
                  ),
                ),
                activeIcon: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: const Icon(
                      Icons.watch_later_rounded,
                      color: Palette.finnHubPrimary,
                    ),
                  ),
                ),
                label: 'Watch',
              ),
            ],
          ),
          body: _buildContent(
            state,
            userData: userData,
          ),
        );
      },
    );
  }

  Widget _buildContent(
    AppTab state, {
    UserFinnhub? userData,
  }) {
    if (state == AppTab.account) {
      return SafeArea(
        child: AccountScreen(
          userData: userData,
        ),
      );
    }
    if (state == AppTab.stocks) {
      return const SafeArea(
        child: StocksScreen(),
      );
    }
    if (state == AppTab.watch) {
      return const SafeArea(
        child: WatchScreen(),
      );
    }

    return Container();
  }
}
