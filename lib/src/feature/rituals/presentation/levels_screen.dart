import 'package:balloon_puzzle_factory/routes/go_router_config.dart';
import 'package:balloon_puzzle_factory/routes/route_value.dart';
import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/bloc/user_bloc.dart';
import 'package:balloon_puzzle_factory/ui_kit/animated_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/app_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/chain_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/coins_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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
                       CoinsContainer(coinsCount: state.user.coins),
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
                    onPressed: () {
                      showADialog(context);
                    },
                    title: 'CLASSIC',
                  ),
                  ...List.generate(
                    balloonFactories.length,
                    (index) {
                      return ChainButton(
                          price: 380 * (index + 1),
                          title: balloonFactories[index].toUpperCase());
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void showADialog(BuildContext context) {
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
              width: getWidth(context, percent: 1),
              fit: BoxFit.fitWidth,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(getHeight(context, baseSize: 8)),
                AppButton(
                  width: 700,
                  onPressed: () {
                    context.pop();
                    context.push(
                        '${RouteValue.home.path}/${RouteValue.select.path}/${RouteValue.game.path}',
                        extra: 1);
                  },
                  title: 'EASY',
                ),
                Gap(8),
                AppButton(
                  width: 700,
                  onPressed: () {
                    context.pop();
                    context.push(
                        '${RouteValue.home.path}/${RouteValue.select.path}/${RouteValue.game.path}',
                        extra: 2);
                  },
                  title: 'MEDIUM',
                ),
                Gap(8),
                AppButton(
                  width: 700,
                  onPressed: () {
                    {
                      context.pop();
                      context.push(
                          '${RouteValue.home.path}/${RouteValue.select.path}/${RouteValue.game.path}',
                          extra: 3);
                    }
                  },
                  title: 'HARD',
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
