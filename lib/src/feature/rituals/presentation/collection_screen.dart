import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/model/collection.dart';
import 'package:balloon_puzzle_factory/ui_kit/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';

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
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Scrollbar(
            // Добавляет ползунок
            thumbVisibility: true, // Ползунок всегда видим
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              child: GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Чтобы скроллился SingleChildScrollView
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.0,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: collections.length,
                itemBuilder: (context, index) {
                  final item = collections[index];
                  final user = state.user;

                  return AnimatedButton(
                    onPressed: () {},
                    child: AppIcon(
                      asset: item.image,
                      fit: BoxFit.cover,
                      blendMode: user.collection.contains(item.id)
                          ? BlendMode.luminosity
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
