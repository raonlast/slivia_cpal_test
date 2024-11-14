import 'package:flutter/material.dart';
import 'package:silvia_cpal_test/features/home/presentation/pages/record_page.dart';
import 'package:silvia_cpal_test/features/home/presentation/pages/home_page.dart';
import 'package:silvia_cpal_test/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:silvia_cpal_test/features/home/presentation/widgets/bottom_navigation_manager.dart';
import 'package:silvia_cpal_test/themes/colors/color_theme.dart';
import 'package:silvia_cpal_test/themes/texts/text_style.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedBottomIndex = 0;

  final List<BottomNavigationManager> _bottomNavigationItemList = [
    BottomNavigationManager(
      title: "홈",
      imageAsset: "assets/icons/home.svg",
      page: const HomePage(),
      index: 0,
    ),
    BottomNavigationManager(
      title: "기록",
      imageAsset: "assets/icons/chart.svg",
      page: const RecordPage(),
      index: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    BottomNavigationManager selectedItem =
        _bottomNavigationItemList[_selectedBottomIndex];

    return Scaffold(
      backgroundColor: ColorTheme.of(context).background.normal.alternative,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: ColorTheme.of(context).background.normal.alternative,
        backgroundColor: ColorTheme.of(context).background.normal.alternative,
        scrolledUnderElevation: 0,
        title: Text(
          selectedItem.title,
          style: CustomTextStyle.of().title,
        ),
      ),
      body: selectedItem.page,
      bottomNavigationBar: CustomBottomNavigationBar(
        bottomNavigationItemList: _bottomNavigationItemList,
        selectedIndex: _selectedBottomIndex,
        onTap: (int index) {
          setState(() {
            _selectedBottomIndex = index;
          });
        },
      ),
    );
  }
}
