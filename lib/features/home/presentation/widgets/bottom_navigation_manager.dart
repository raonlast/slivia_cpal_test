import 'package:flutter/material.dart';

enum BottomNavigationItemType { home, mission, test, statistics, myPage }

class BottomNavigationManager {
  final String title;
  final String imageAsset;
  final Widget page;
  final int index;

  BottomNavigationManager({
    required this.title,
    required this.imageAsset,
    required this.page,
    required this.index,
  });
}
