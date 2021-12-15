import 'package:flutter/material.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/ui/ui.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        width: double.maxFinite,
        color: Palette.finnHubBackgroundDark,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 55,
                backgroundColor: Palette.white,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Palette.greyLighten1,
                  backgroundImage: AssetImage(
                    Images.personPlaceholder,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "Rizki Alfi Ramdhani",
                style: FontHelper.h5Bold(
                  color: Palette.white,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                "rizkialfi.r@gmail.com",
                style: FontHelper.h7Regular(
                  color: Palette.greyLighten2,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "Last login on: 2021-12-12",
                style: FontHelper.h6Regular(
                  color: Palette.greyLighten1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
