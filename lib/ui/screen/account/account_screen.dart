import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';
import 'package:stock_app/ui/ui.dart';

class AccountScreen extends StatelessWidget {
  final UserFinnhub? userData;

  const AccountScreen({
    Key? key,
    this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignInCubit, BaseState>(
        listener: (context, state) {
          if (state is ErrorState) {
            if (state.error.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Whoops. Something went wrong, try again later",
                  ),
                ),
              );
            }
          }

          if (state is SuccessState) {
            Navigator.pushNamed(
              context,
              RouteName.signInScreen,
            );
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: double.maxFinite,
                color: Palette.finnHubBackgroundDark,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (userData?.imageUrl != null) ...[
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Palette.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Palette.greyLighten1,
                            backgroundImage: NetworkImage(
                              '${userData?.imageUrl}',
                            ),
                          ),
                        ),
                      ] else ...[
                        const CircleAvatar(
                          radius: 55,
                          backgroundColor: Palette.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Palette.greyLighten1,
                            backgroundImage:
                                AssetImage(Images.personPlaceholder),
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        userData?.fullName ?? "-",
                        style: FontHelper.h5Bold(
                          color: Palette.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        userData?.email ?? "-",
                        style: FontHelper.h7Regular(
                          color: Palette.greyLighten2,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "UID: ${userData?.uid ?? '-'}",
                        style: FontHelper.h6Regular(
                          color: Palette.greyLighten1,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Last login on: ${userData?.lastSignIn ?? '-'}",
                        style: FontHelper.h6Regular(
                          color: Palette.greyLighten1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 300.0,
              ),
              if (state is LoadingState) ...[
                const Center(
                  child: CircularProgressIndicator(
                    color: Palette.finnHubSecondary,
                  ),
                ),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: ContainerSocialMediaButton(
                    title: 'Sign Out',
                    titleColor: Palette.white,
                    color: Palette.finnHubPrimary,
                    useIcon: false,
                    action: () async => context.read<SignInCubit>().signOut(),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
