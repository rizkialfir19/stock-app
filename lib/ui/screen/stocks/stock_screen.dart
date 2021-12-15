import 'package:flutter/material.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/ui/styles/font_helper.dart';
import 'package:stock_app/ui/styles/palette.dart';
import 'package:stock_app/ui/ui.dart';

class StocksScreen extends StatelessWidget {
  const StocksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _sectionHeader(),
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
          _sectionContent(),
          const SizedBox(
            height: 15.0,
          ),
        ],
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

  Widget _sectionContent() {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return const ContainerStock();
      },
    );
  }
}
