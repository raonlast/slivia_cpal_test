import 'package:flutter/material.dart';
import 'package:silvia_cpal_test/utils/random.dart';

class RandomTestPage extends StatefulWidget {
  const RandomTestPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const RandomTestPage(),
    );
  }

  @override
  State<RandomTestPage> createState() => _RandomTestPageState();
}

class _RandomTestPageState extends State<RandomTestPage> {
  final int _totalCount = 5;
  final double _cardWidth = 40;
  final double _cardHeight = 40;

  final List<Widget> _cardWidgetList = [];

  // bool isOverlapping(Offset newPosition) {
  //   for (var position in cardPositions) {
  //     if ((newPosition.dx - position.dx).abs() < _cardWidth &&
  //         (newPosition.dy - position.dy).abs() < _cardHeight) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  void generateCardWidget() {
    List<Widget> positionWidgetList = [];

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safePadding = MediaQuery.of(context).padding;

    final safeWidth = screenWidth - safePadding.left - safePadding.right;
    final safeHeight = screenHeight - safePadding.top - safePadding.bottom;

    for (int i = 0; i < _totalCount; i++) {
      Offset position;

      double xRandom = randomInRange(0.1, 0.9);
      double yRandom = randomInRange(0.2, 0.7);

      final x = xRandom * (safeWidth - _cardWidth);
      final y = yRandom * (safeHeight - _cardHeight);
      position = Offset(x, y);

      positionWidgetList.add(
        Positioned(
          left: position.dx,
          top: position.dy,
          child: Container(
            width: _cardWidth,
            height: _cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.orange,
            ),
          ),
        ),
      );
    }

    setState(() {
      _cardWidgetList.clear();
      _cardWidgetList.addAll(positionWidgetList);
    });
  }

  @override
  void didChangeDependencies() {
    generateCardWidget();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              generateCardWidget();
            },
            icon: Icon(
              Icons.refresh_rounded,
            ),
          )
        ],
      ),
      body: Stack(
        children: _cardWidgetList,
      ),
    );
  }
}
