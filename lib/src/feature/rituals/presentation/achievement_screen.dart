import 'package:balloon_puzzle_factory/src/feature/rituals/bloc/user_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';


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
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    Gap(15),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AppIconButton(
                          child:
                              AppIcon(asset: IconProvider.back.buildImageUrl()),
                          onPressed: () {
                            context.pop();
                          }),
                    ),
                    Gap(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AppIcon(
                              asset: IconProvider.titleBack.buildImageUrl()),
                          Text(
                            'Achievments',
                            style: TextStyle(
                              color: Color(0xFF13092A),
                              fontSize: 22,
                              fontFamily: 'Gunterz',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(29),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: state.achievements.map((achievement) {
                        return AnimatedButton(
                          onPressed: () {
                            _showDialog(context, achievement.description,
                                achievement.title);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipOval(
                                child: AppIcon(
                                  asset: IconProvider.mainBall.buildImageUrl(),
                                  width: 106,
                                  height: 106,
                                  color: state.user.achievements
                                          .contains(achievement.id)
                                      ? const Color(0xFF12fc06)
                                      : null,
                                  blendMode: BlendMode.color,
                                ),
                              ),
                              SizedBox(
                                width: 106,
                                height: 106,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 11, vertical: 6),
                                    child: Text(
                                      achievement.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF00FB),
            ),
          );
        }
      },
    );
  }
}

void _showDialog(BuildContext context, String text, String title) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => SizedBox(
      height: 224,
      child: Stack(
        children: [
          ColoredBox(
            color: Color(0xFF1F004C),
            child: SizedBox(height: 224, width: 343),
          ),
          Positioned(
            bottom: -224,
            child: AppIcon(
              asset: IconProvider.alertDialogBack.buildImageUrl(),
              width: 343,
              height: 448,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 224,
            width: 343,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16, // Larger font size for selected
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0), // Смещение тени
                              color: Color(
                                  0x80000000), // Цвет тени с прозрачностью
                              blurRadius: 4.0, // Радиус размытия тени
                            ),
                          ],
                        ),
                      ),
                      Gap(30),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 12, // Larger font size for selected
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0), // Смещение тени
                              color: Color(
                                  0x80000000), // Цвет тени с прозрачностью
                              blurRadius: 4.0, // Радиус размытия тени
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    ),
  );
}
