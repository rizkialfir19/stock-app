import 'package:flutter/material.dart';
import 'package:stock_app/common/common.dart';
import 'package:stock_app/ui/styles/palette.dart';
import 'package:stock_app/ui/ui.dart';

class ContainerSearchBar extends StatelessWidget {
  const ContainerSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          onChanged: (value) {},
          onFieldSubmitted: (String? value) => Navigator.pushNamed(
            context,
            RouteName.searchResultScreen,
            arguments: ScreenArgument(
              data: value,
            ),
          ),
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Palette.greyLighten2.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Palette.greyLighten2.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Palette.greyLighten2.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Palette.greyLighten2.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: "Type something",
            hintStyle: FontHelper.h6Regular(
              color: Colors.grey,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
