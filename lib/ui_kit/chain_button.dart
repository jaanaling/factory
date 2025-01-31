import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:balloon_puzzle_factory/ui_kit/coins_container.dart';
import 'package:balloon_puzzle_factory/ui_kit/gradient_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'animated_button.dart';

class ChainButton extends StatelessWidget {
  final int price;
  final String title;
  const ChainButton({super.key, required this.price, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AppIcon(
            asset: IconProvider.buttonGrey.buildImageUrl(),
            width: getWidth(context, baseSize: 830),
            fit: BoxFit.fitWidth,
          ),
          TextWithBorder(
            text: title,
            borderColor: Colors.white,
            fontSize: 25,
            color: const Color(0xFFA0A0A0),
          ),
          AppIcon(
            asset: IconProvider.chain.buildImageUrl(),
            width: getWidth(context, baseSize: 830),
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            right: 10,
            child: AnimatedButton(
              child: CoinsContainer(
                coinsCount: price,
                width: 186,
                paddingSize: 0,
              ),
              onPressed: () {
                _showAlertDialog(context, title);
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showAlertDialog(BuildContext context, String factory) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Stack(
          alignment: Alignment.center,
          children: [
            AppIcon(
              asset: IconProvider.alertDialog.buildImageUrl(),
              width: getWidth(context, baseSize: 1024),
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: AnimatedButton(
                child: AppIcon(
                  asset: IconProvider.close.buildImageUrl(),
                  width: getWidth(context, baseSize: 163),
                  fit: BoxFit.fitWidth,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            SizedBox(
              width: getWidth(context, baseSize: 1024) -
                  getWidth(context, baseSize: 406),
              child: Text(
                "You don't have enough coins to unlock the ${factory.toLowerCase()} factory!",
                style: const TextStyle(
                  fontFamily: 'Sabalon',
                  fontSize: 26,
                  color: Color(0xFFC30E14),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
