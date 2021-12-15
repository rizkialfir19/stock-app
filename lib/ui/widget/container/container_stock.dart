import 'package:flutter/material.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/ui/ui.dart';

class ContainerStock extends StatelessWidget {
  const ContainerStock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          border: Border.all(
            color: Palette.greyLighten1.withOpacity(0.4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      Images.stocksPlaceholder,
                      height: 40.0,
                      width: 40.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "BAKRIE & BROTHERS PT",
                        style: FontHelper.h7Bold(),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Common Stock",
                        style: FontHelper.h9Regular(
                          color: Palette.greyDarken1,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        size: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 0.7,
                color: Palette.greyLighten1.withOpacity(0.4),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Symbol/Code",
                        style: FontHelper.h8Regular(
                          color: Palette.greyDarken1,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "BNBR.JK",
                        style: FontHelper.h8Bold(),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Currency",
                        style: FontHelper.h8Regular(
                          color: Palette.greyDarken1,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "IDR",
                        style: FontHelper.h8Bold(),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                      color: Palette.finnHubSecondary,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      "+ Watch List",
                      style: FontHelper.h8Bold(
                        color: Palette.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
