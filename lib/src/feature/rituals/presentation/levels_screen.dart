import 'package:balloon_puzzle_factory/routes/go_router_config.dart';
import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:balloon_puzzle_factory/ui_kit/animated_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/app_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/chain_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/coins_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> balloonFactories = [
      'Galactic',
      'Steampunk',
      'Enchanted',
      'Cyber',
      'Underwater'
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getHeight(context, baseSize: 18),
              horizontal: getWidth(context, baseSize: 21)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: AppIcon(
                      asset: IconProvider.back.buildImageUrl(),
                      width: getWidth(
                        context,
                        baseSize: 76,
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const CoinsContainer(coinsCount: 10),
                ],
              ),
              Gap(16),
              AppIcon(
                asset: 'assets/images/Select Your Factory.webp',
                width: getWidth(context, baseSize: 999),
                fit: BoxFit.fitWidth,
              ),
              Gap(16),
              AppButton(
                onPressed: () {},
                title: 'CLASSIC',
              ),
              ...List.generate(balloonFactories.length, (index) {
                return ChainButton(
                    price: 100*(index+1),
                    title: balloonFactories[index].toUpperCase());
              },)
            ],
          ),
        ),
      ),
    );
  }
}
