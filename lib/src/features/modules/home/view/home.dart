import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/home_styles/home_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/home_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BirdsHome extends StatelessWidget with HomeWidgets, ImagePath {
  const BirdsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, home, __) => Scaffold(
        body: home.screens.elementAt(home.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: home.selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            home.onItemClick = index;
          },
          elevation: 1,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    ImagePath.activeHome,
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    ImagePath.homeIcon,
                  ),
                ),
                label: HomeText.homeText),
            BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    ImagePath.activeCart,
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    ImagePath.cartIcon,
                  ),
                ),
                label: HomeText.cartText),
            BottomNavigationBarItem(
                activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SvgPicture.asset(
                      ImagePath.activeCourse,
                    )),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    ImagePath.courseIcon,
                  ),
                ),
                label: HomeText.myCourse),
            BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    ImagePath.activeAcount,
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    ImagePath.accountIcon,
                  ),
                ),
                label: HomeText.accountText),
          ],
          selectedItemColor: blackSolid,
          unselectedItemColor: blackSolid,
          selectedIconTheme:
              const IconThemeData(color: blackSolid, size: 23, weight: 2),
          unselectedIconTheme:
              const IconThemeData(color: white, size: 20, weight: 1),
          selectedLabelStyle: HomeStyles.navLabelStyle,
          unselectedLabelStyle: HomeStyles.navLabelStyle,
        ),
      ),
    );
  }
}
