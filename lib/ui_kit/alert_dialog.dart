import 'package:balloon_puzzle_factory/routes/route_value.dart';
import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'animated_button.dart';
import 'gradient_text.dart';

void showEndAlertDialog(
    BuildContext context, bool isRecord, int score, int difficulty) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Stack(
          alignment: Alignment.center,
          children: [
            AppIcon(
              asset: IconProvider.alertDialog.buildImageUrl(),
              width: getWidth(context, baseSize: isIpad(context)? 800: 1024),
              fit: BoxFit.fitWidth,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(8),
                AppIcon(
                  asset: 'assets/images/your score.webp',
                  width: getWidth(context, baseSize:isIpad(context)?500: 650),
                  fit: BoxFit.fitWidth,
                ),
                Text(
                  score.toString(),
                  style: TextStyle(
                      fontFamily: 'Atop',
                      color: Color(0xFFC30E14),
                      fontSize: isIpad(context)?50:32),
                ),
                if (isRecord)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: AppIcon(
                      asset: 'assets/images/RECORD!.webp',
                      width: getWidth(context, baseSize: isIpad(context)?500: 650),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                Gap(8),
                AnimatedButton(
                  onPressed: () {
                    context.pop();
                    context.pop();
                    context.pop();
                    context.pushReplacement(
                        '${RouteValue.home.path}/${RouteValue.select.path}/${RouteValue.game.path}',
                        extra: difficulty);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AppIcon(
                        asset: IconProvider.button.buildImageUrl(),
                        width: getWidth(context, baseSize: 593),
                        fit: BoxFit.fitWidth,
                      ),
                      TextWithBorder(
                        text: 'NEW GAME',
                        borderColor: Colors.white,
                        fontSize:isIpad(context)?30: 20,
                        color: Color(0xFFC30E14),
                      ),
                    ],
                  ),
                ),
                Gap(6),
                AnimatedButton(
                  onPressed: () {
                    context.pop();
                    context.pop();
                    context.pop();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AppIcon(
                        asset: IconProvider.button.buildImageUrl(),
                        width: getWidth(context, baseSize: 593),
                        fit: BoxFit.fitWidth,
                      ),
                       TextWithBorder(
                        text: 'MAIN MENU',
                        borderColor: Colors.white,
                        fontSize: isIpad(context)?30:20,
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
                  context.pop();
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
