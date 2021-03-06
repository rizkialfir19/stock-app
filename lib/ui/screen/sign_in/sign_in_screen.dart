import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/core/core.dart';
import 'package:stock_app/ui/ui.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInCubit, BaseState>(
        listener: (context, state) {
          UserFinnhub? user;

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
            user = state.data;

            Navigator.pushNamed(
              context,
              RouteName.landingScreen,
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
        },
        child: SafeArea(
          child: Container(
            width: double.maxFinite,
            color: Palette.finnHubBackgroundDark,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Image.asset(
                    Images.iconFinnhub,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 100.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Text(
                      "See what's happening\nin the world right now.",
                      style: FontHelper.h4Bold(
                        color: Palette.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 100.0,
                  ),
                  _sectionSocialMedia(context),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _sectionTermsPolicy(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionSocialMedia(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        children: [
          ContainerSocialMediaButton(
            title: 'Continue with Google',
            action: () async => context.read<SignInCubit>().signInWithGoogle(),
          ),
        ],
      ),
    );
  }

  Widget _sectionDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 1.0,
            width: MediaQuery.of(context).size.width / 2.9,
            color: Palette.white,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Text(
            "Or",
            style: FontHelper.h7Regular(
              color: Palette.white,
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          Container(
            height: 1.0,
            width: MediaQuery.of(context).size.width / 2.9,
            color: Palette.white,
          ),
        ],
      ),
    );
  }

  Widget _sectionTermsPolicy(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'By signing up, you agree to our',
              style: FontHelper.h7Regular(
                color: Palette.greyLighten1,
              ),
            ),
            TextSpan(
              text: ' Terms, Privacy, Policy',
              style: FontHelper.h7Regular(
                color: Palette.finnHubSecondary,
              ),
            ),
            TextSpan(
              text: ' and',
              style: FontHelper.h7Regular(
                color: Palette.greyLighten1,
              ),
            ),
            TextSpan(
              text: ' Cookies Use.',
              style: FontHelper.h7Regular(
                color: Palette.finnHubSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
