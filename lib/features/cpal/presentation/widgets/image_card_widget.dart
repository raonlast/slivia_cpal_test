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
  bool _isWrong = false;

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
        if (widget.isAnswerCard || _cpalProvider.canFlip()) return;

        _cpalProvider.onFlipCard(true);

        if (_cpalProvider.answerImage == widget.imageAssetUrl) {
          _controller.forward().then((_) {
            setState(() {
              _isAnswer = true;
            });
          });

          _cpalProvider.onCorrect();
          Future.delayed(const Duration(seconds: 3), () {
            _cpalProvider.getAnswerImage();
            _cpalProvider.onFlipCard(false);
            _controller.reverse();

            setState(() {
              _isAnswer = false;
            });
          });
        } else {
          _controller.forward().then((_) {
            setState(() {
              _isWrong = true;
            });
          });

          _cpalProvider.onWrong();
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              _isWrong = false;
            });
            _controller.reverse().then((_) {
              _cpalProvider.onFlipCard(false);
            });
          });
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
                  border: widget.isAnswerCard || _isAnswer || _isWrong
                      ? Border.all(
                          color: _isWrong
                              ? ColorTheme.of(context).status.destructive
                              : ColorTheme.of(context)
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
