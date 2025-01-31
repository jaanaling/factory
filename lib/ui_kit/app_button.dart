import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:balloon_puzzle_factory/ui_kit/animated_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/gradient_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double fontSize;
  final bool isGrey;
  final double width;
  const AppButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.fontSize = 25,
      this.width = 830,
      this.isGrey = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AppIcon(
            asset: isGrey
                ? IconProvider.buttonGrey.buildImageUrl()
                : IconProvider.button.buildImageUrl(),
            width: getWidth(context, baseSize: width),
            fit: BoxFit.fitWidth,
          ),
          TextWithBorder(
            text: title,
            borderColor: Colors.white,
            fontSize: fontSize,
            color: isGrey ? const Color(0xFFA0A0A0) : const Color(0xFFC30E14),
          ),
        ],
      ),
    );
  }
}
