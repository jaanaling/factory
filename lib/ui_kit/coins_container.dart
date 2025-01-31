import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CoinsContainer extends StatelessWidget {
  final int coinsCount;
  final String? text;
  final double? width;
  final double? paddingSize;
  final double? fontSize;
  const CoinsContainer({
    super.key,
    required this.coinsCount,
    this.text,
    this.width,
    this.paddingSize,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AppIcon(
          asset: IconProvider.buttonA.buildImageUrl(),
          width: getWidth(
            context,
            baseSize: 240,
          ),
          fit: BoxFit.fitWidth,
        ),
        SizedBox(
          width: getWidth(
                context,
                baseSize: width ?? 240,
              ) -
              getWidth(
                context,
                baseSize: paddingSize ?? 83,
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(text ?? coinsCount.toString(), style: TextStyle(fontSize: fontSize),),
              ),
              AppIcon(
                asset: IconProvider.coins.buildImageUrl(),
                width: getWidth(
                  context,
                  baseSize: 44,
                ),
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
