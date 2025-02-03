import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/bloc/user_bloc.dart';
import 'package:balloon_puzzle_factory/ui_kit/animated_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../ui_kit/coins_container.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return SingleChildScrollView(
            child: SafeArea(
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
                      asset: 'assets/images/Achievements.webp',
                      width: getWidth(context, baseSize: 800),
                      fit: BoxFit.fitWidth,
                    ),
                    Gap(16),
                    ...List.generate(
                      state.achievements.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: AppButton(
                              isGrey: !state.user.achievements
                                  .contains(state.achievements[index].id),
                              onPressed: () {
                                showAlertDialog(context,
                                    state.achievements[index].description);
                              },
                              title: state.achievements[index].title),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

void showAlertDialog(BuildContext context, String title) {
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
              width: getWidth(context, baseSize: isIpad(context)? 800: 1024),
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
              width: getWidth(context, baseSize: isIpad(context)? 800: 1024) -
                  getWidth(context, baseSize: isIpad(context)? 200: 406),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Sabalon',
                  fontSize: isIpad(context)? 42: 26,
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
