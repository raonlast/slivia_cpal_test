import 'dart:math';
import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const CardPage(),
    );
  }

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final int totalCards = 10;
  List<Offset> cardPositions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    generateCardPositions();
  }

  bool isOverlapping(Offset newPosition) {
    const double cardWidth = 100;
    const double cardHeight = 100;

    for (var position in cardPositions) {
      if ((newPosition.dx - position.dx).abs() < cardWidth &&
          (newPosition.dy - position.dy).abs() < cardHeight) {
        return true;
      }
    }
    return false;
  }

  void generateCardPositions() {
    final random = Random();
    cardPositions.clear();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const double cardWidth = 60;
    const double cardHeight = 60;

    for (int i = 0; i < totalCards; i++) {
      Offset position;
      do {
        final x = random.nextDouble() * (screenWidth - cardWidth);
        final y = random.nextDouble() * (screenHeight - cardHeight);
        position = Offset(x, y);
      } while (isOverlapping(position));

      cardPositions.add(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    for (int i = 0; i < totalCards; i++) {
      cards.add(Positioned(
        left: cardPositions[i].dx,
        top: cardPositions[i].dy,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ));
    }

    final centralCard = Align(
      alignment: Alignment.center,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.favorite,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Random Cards')),
      body: Stack(
        children: [
          centralCard,
          ...cards,
        ],
      ),
    );
  }
}
