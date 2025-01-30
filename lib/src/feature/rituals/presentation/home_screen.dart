import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/bloc/user_bloc.dart';
import 'package:balloon_puzzle_factory/ui_kit/app_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/coins_container.dart';
import 'package:balloon_puzzle_factory/ui_kit/gradient_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: getHeight(context, baseSize: 18),
                horizontal: getWidth(context, baseSize: 21)),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: CoinsContainer(coinsCount: 10)),
                AppIcon(
                  asset: IconProvider.logoHome.buildImageUrl(),
                  width: getWidth(context, percent: 1),
                  fit: BoxFit.fitWidth,
                ),
                AppIcon(
                  asset: 'assets/images/YOUR RECORD!.webp',
                  width: getWidth(context, baseSize: 693),
                  fit: BoxFit.fitWidth,
                ),
                Gap(10),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AppIcon(
                      asset: IconProvider.buttonA.buildImageUrl(),
                      width: getWidth(
                        context,
                        baseSize: 371,
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      width: getWidth(
                            context,
                            baseSize: 371,
                          ) -
                          getWidth(
                            context,
                            baseSize: 83,
                          ),
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(
                            '1000',
                            style: TextStyle(fontSize: 32),
                          )),
                    )
                  ],
                ),
                Spacer(),
                AppButton(onPressed: (){}, title: 'START', fontSize: 42,),
                Gap(8),
                AppButton(onPressed: (){}, title: 'ACHIEVEMENTS',),
                Gap(8),
                AppButton(onPressed: (){}, title: 'COLLECTION',),
                Spacer()
              ],
            ),
          ),
        );
      },
    );
  }
}
