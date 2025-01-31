import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/model/collection.dart';
import 'package:balloon_puzzle_factory/ui_kit/animated_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/coins_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/size_utils.dart';
import '../bloc/user_bloc.dart';
import 'achievement_screen.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController =
        ScrollController(); // Контроллер прокрутки

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scrollbar(
          // Добавляет ползунок
          thumbVisibility: true, // Ползунок всегда видим
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Gap(getHeight(context, baseSize: 18)),
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
                      asset: 'assets/images/Collection.webp',
                      width: getWidth(context, baseSize: 600),
                      fit: BoxFit.fitWidth,
                    ),
                    Gap(16),
                    Wrap(
                      spacing: 16.0, // Горизонтальные отступы между элементами
                      runSpacing: 16.0, // Вертикальные отступы между рядами
                      children: collections.map((item) {
                        final user = state.user;
                        return AnimatedButton(
                          onPressed: () {
                            showAlertDialog(context, item.name);
                          },
                          child: user.collection.contains(item.id)
                              ? AppIcon(
                                  asset: item.image,
                                  width: getWidth(context, percent: 0.4),
                                  height: getWidth(context, percent: 0.5),
                                )
                              : ColorFiltered(
                                  colorFilter:
                                      const ColorFilter.matrix(<double>[
                                    0.2126,
                                    0.7152,
                                    0.0722,
                                    0,
                                    0,
                                    0.2126,
                                    0.7152,
                                    0.0722,
                                    0,
                                    0,
                                    0.2126,
                                    0.7152,
                                    0.0722,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    1,
                                    0,
                                  ]),
                                  child: AppIcon(
                                    asset: item.image,
                                    width: getWidth(context, percent: 0.4),
                                    height: getWidth(context, percent: 0.5),
                                  ),
                                ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
