import 'package:flutter/material.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/ui/ui.dart';

class EmptyOrErrorData extends StatelessWidget {
  final StateCategory category;
  final VoidCallback? action;

  const EmptyOrErrorData({
    Key? key,
    required this.category,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            Images.emptyData,
            color: Palette.finnHubSecondary,
            height: 180.0,
            width: 180.0,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 15.0,
          ),
          if (category == StateCategory.empty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Oops, Data is empty",
                style: FontHelper.h5Regular(),
              ),
            ),
          ] else ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Oops, Error Get Data. Please Try Again",
                style: FontHelper.h5Regular(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          if (category == StateCategory.error) ...[
            const SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              onTap: () => action != null ? action!.call() : null,
              child: Text(
                "Try Again here",
                style: FontHelper.h6Bold(
                  color: Palette.finnHubSecondary,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
