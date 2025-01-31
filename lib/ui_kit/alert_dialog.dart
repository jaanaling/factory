import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'animated_button.dart';
import 'gradient_text.dart';

void showEndAlertDialog(BuildContext context, bool isRecord, int score) {
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(8),
                AppIcon(
                  asset: 'assets/images/your score.webp',
                  width: getWidth(context, baseSize: 650),
                  fit: BoxFit.fitWidth,
                ),
                Text(
                  score.toString(),
                  style: const TextStyle(
                      fontFamily: 'Atop',
                      color: Color(0xFFC30E14),
                      fontSize: 32),
                ),
                if (isRecord)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: AppIcon(
                      asset: 'assets/images/RECORD!.webp',
                      width: getWidth(context, baseSize: 650),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                Gap(8),
                AnimatedButton(
                  onPressed: () {},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AppIcon(
                        asset: IconProvider.button.buildImageUrl(),
                        width: getWidth(context, baseSize: 593),
                        fit: BoxFit.fitWidth,
                      ),
                      const TextWithBorder(
                        text: 'NEW GAME',
                        borderColor: Colors.white,
                        fontSize: 20,
                        color: Color(0xFFC30E14),
                      ),
                    ],
                  ),
                ),
                Gap(6),
                AnimatedButton(
                  onPressed: () {},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AppIcon(
                        asset: IconProvider.button.buildImageUrl(),
                        width: getWidth(context, baseSize: 593),
                        fit: BoxFit.fitWidth,
                      ),
                      const TextWithBorder(
                        text: 'MAIN MENU',
                        borderColor: Colors.white,
                        fontSize: 20,
                        color: Color(0xFFC30E14),
                      ),
                    ],
                  ),
                ),
              ],
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
          ],
        ),
      );
    },
  );
}
