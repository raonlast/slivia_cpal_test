import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silvia_cpal_test/features/cpal/providers/cpal_provider.dart';
import 'package:silvia_cpal_test/themes/colors/color_theme.dart';

class CustomProgressBar extends StatefulWidget {
  const CustomProgressBar({super.key});

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late CpalProvider _cpalProvider;

  @override
  void didChangeDependencies() {
    _cpalProvider = context.watch<CpalProvider>();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _cpalProvider.showAnswerSecond),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cpalProvider.isShowAnswer) {
      _controller.forward();
    }

    return SizedBox(
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return LinearProgressIndicator(
            backgroundColor: ColorTheme.of(context).fill.normal,
            color: ColorTheme.of(context).primary.normal,
            value: _animation.value,
            minHeight: 4,
          );
        },
      ),
    );
  }
}
