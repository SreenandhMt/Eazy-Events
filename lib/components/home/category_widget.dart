import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/colors.dart';
import '../../utils/dark_check.dart';
import '../../utils/navigation_utils.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (screenSize.width < 1105) {
      // listview for mobile screen
      return LimitedBox(
          maxWidth: screenSize.width * 0.9,
          maxHeight: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              9,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      AppNavigation.showEventCategoryList(
                          context, index.toString());
                    },
                    child: CircleAvatar(
                      radius: 53,
                      backgroundColor: Colors.grey.shade400,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColor.secondaryColor(context),
                        child: Image.asset(
                            ImageAssets.categoryImage(
                                index + 1, isDarkTheme(context)),
                            width: 40),
                      ),
                    )),
              ),
            ),
          ));
    }
    // row center for desktop screen
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        9,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () => AppNavigation.showEventCategoryList(
                  context, index.toString()),
              child: CircleAvatar(
                radius: 53,
                backgroundColor: Colors.grey.shade400,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColor.secondaryColor(context),
                  // images
                  child: Image.asset(
                      ImageAssets.categoryImage(
                          index + 1, isDarkTheme(context)),
                      width: 40),
                ),
              )),
        ),
      ),
    );
  }
}
