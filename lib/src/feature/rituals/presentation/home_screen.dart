import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/bloc/user_bloc.dart';
import 'package:balloon_puzzle_factory/ui_kit/coins_container.dart';
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
              ],
            ),
          ),
        );
      },
    );
  }
}
