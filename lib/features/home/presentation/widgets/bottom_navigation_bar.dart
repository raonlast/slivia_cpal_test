import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:silvia_cpal_test/features/home/presentation/widgets/bottom_navigation_manager.dart';
import 'package:silvia_cpal_test/themes/colors/color_theme.dart';
import 'package:silvia_cpal_test/themes/texts/text_style.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationManager> bottomNavigationItemList;
  final int selectedIndex;
  final Function(int)? onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.bottomNavigationItemList,
    required this.selectedIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onTap,
          backgroundColor: ColorTheme.of(context).background.normal.normal,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: ColorTheme.of(context).primary.normal,
          selectedIconTheme: const IconThemeData(size: 24),
          selectedLabelStyle: CustomTextStyle.of().caption,
          unselectedItemColor: ColorTheme.of(context).label.assistive,
          unselectedIconTheme: const IconThemeData(size: 24),
          unselectedLabelStyle: CustomTextStyle.of().caption,
          items: [
            ...bottomNavigationItemList.map(
              (item) {
                bool isSelected = item.index == selectedIndex;
                Color selectedColor = isSelected
                    ? ColorTheme.of(context).primary.normal
                    : ColorTheme.of(context).label.assistive;

                return BottomNavigationBarItem(
                  label: item.title,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: SvgPicture.asset(
                      item.imageAsset,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        selectedColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
