import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:silvia_cpal_test/features/cpal/providers/cpal_provider.dart';
import 'package:silvia_cpal_test/themes/colors/color_theme.dart';

class ImageCard extends StatefulWidget {
  final String imageAssetUrl;
  final bool isAnswerCard;
  final bool isWrong;

  const ImageCard({
    super.key,
    required this.imageAssetUrl,
    this.isAnswerCard = false,
    this.isWrong = false,
  });

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  late CpalProvider _cpalProvider;
  bool _isAnswer = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 3.14).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _cpalProvider = context.watch<CpalProvider>();

    if (_cpalProvider.isShowAnswer) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isAnswerCard ||
            _cpalProvider.isShowAnswer ||
            !_cpalProvider.isStarted) return;

        _controller.forward();

        if (_controller.isCompleted) {
          _controller.reverse();
        } else {
          _controller.forward();
          if (_cpalProvider.answerImage == widget.imageAssetUrl) {
            setState(() {
              _isAnswer = true;
            });
            _cpalProvider.onCorrect();
            Future.delayed(const Duration(seconds: 3), () {
              setState(() {
                _isAnswer = false;
              });
              _controller.reverse();
              _cpalProvider.getAnswerImage();
            });
          } else {
            Future.delayed(const Duration(seconds: 1), () {
              _controller.reverse();
            });
          }
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.rotationY(_flipAnimation.value),
            alignment: Alignment.center,
            child: Container(
                decoration: BoxDecoration(
                  color: _cpalProvider.isShowAnswer
                      ? ColorTheme.of(context).background.normal.normal
                      : null,
                  borderRadius: BorderRadius.circular(4),
                  border: widget.isAnswerCard || _isAnswer
                      ? Border.all(
                          color: ColorTheme.of(context)
                              .primary
                              .normal
                              .withOpacity(0.7),
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color:
                          ColorTheme.of(context).static.black.withOpacity(0.1),
                      offset: const Offset(0, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: _flipAnimation.value > 1.57 || widget.isAnswerCard
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/Card_front.svg',
                            width: 80,
                            height: 100,
                          ),
                          Transform.flip(
                            flipX: widget.isAnswerCard,
                            child: SvgPicture.asset(
                              widget.imageAssetUrl,
                              width: 68,
                              height: 68,
                            ),
                          )
                        ],
                      )
                    : SvgPicture.asset(
                        'assets/icons/Card_back.svg',
                        width: 80,
                        height: 100,
                      )),
          );
        },
      ),
    );
  }
}
