import 'package:balloon_puzzle_factory/routes/route_value.dart';
import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/bloc/user_bloc.dart';
import 'package:balloon_puzzle_factory/ui_kit/alert_dialog.dart';
import 'package:balloon_puzzle_factory/ui_kit/animated_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/app_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/coins_container.dart';
import 'package:balloon_puzzle_factory/ui_kit/gradient_text.dart';
import 'package:balloon_puzzle_factory/ui_kit/sound_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      playMusic();
  }
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
                    child: CoinsContainer(coinsCount: state.user.coins)),
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
                            state.user.record.toString(),
                            style: TextStyle(fontSize: 32),
                          )),
                    )
                  ],
                ),
                Spacer(),
                AppButton(
                  onPressed: () {
                    context.push(
                        '${RouteValue.home.path}/${RouteValue.select.path}');
                  },
                  title: 'START',
                  fontSize: 42,
                ),
                Gap(8),
                AppButton(
                  onPressed: () {
                    context.push(
                        '${RouteValue.home.path}/${RouteValue.achievements.path}');
                  },
                  title: 'ACHIEVEMENTS',
                ),
                Gap(8),
                AppButton(
                  onPressed: () {
                    context.push(
                        '${RouteValue.home.path}/${RouteValue.collection.path}');
                  },
                  title: 'COLLECTION',
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(
                          asset: IconProvider.gift.buildImageUrl(),
                          width: getWidth(context, baseSize: 298),
                          fit: BoxFit.fitWidth,
                        ),
                        TextWithBorder(
                          text: '1 Day',
                          borderColor: Colors.white,
                          fontSize: 15,
                          color: const Color(0xFFC30E14),
                        ),
                        Gap(2),
                        AnimatedButton(
                          onPressed: () {

                          },
                          child: CoinsContainer(
                            coinsCount: 10,
                            text: '+ 10',
                            width: 186,
                            paddingSize: 0,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(
                          asset: IconProvider.giftGrey.buildImageUrl(),
                          width: getWidth(context, baseSize: 298),
                          fit: BoxFit.fitWidth,
                        ),
                        TextWithBorder(
                          text: '2 Day',
                          borderColor: Colors.white,
                          fontSize: 15,
                          color: const Color(0xFFC30E14),
                        ),
                        Gap(2),
                        CoinsContainer(
                          coinsCount: 10,
                          text: '+ 15',
                          width: 186,
                          paddingSize: 0,
                          fontSize: 16,
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(
                          asset: IconProvider.giftGrey.buildImageUrl(),
                          width: getWidth(context, baseSize: 298),
                          fit: BoxFit.fitWidth,
                        ),
                        TextWithBorder(
                          text: '3 Day',
                          borderColor: Colors.white,
                          fontSize: 15,
                          color: const Color(0xFFC30E14),
                        ),
                        Gap(2),
                        CoinsContainer(
                          coinsCount: 10,
                          text: '+ 20',
                          width: 186,
                          paddingSize: 0,
                          fontSize: 16,
                        )
                      ],
                    ),
                  ],
                ),
                Spacer()
              ],
            ),
          ),
        );
      },
    );
  }
}
