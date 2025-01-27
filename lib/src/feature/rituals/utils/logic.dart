import 'package:balloon_puzzle_factory/src/feature/rituals/bloc/user_bloc.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/model/achievement.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void unlockAchievementIfNeeded({
  required List<Achievement> achievementsData,
  required BuildContext context,
  required User user,
  required int achievementId,
  required bool condition,
}) {
  if (condition && !user.achievements.contains(achievementId)) {
    final achievement = achievementsData.firstWhere(
      (a) => a.id == achievementId,
    );

    user.achievements.add(achievementId);
    user.coins += achievement.reward;

    context.read<UserBloc>().add(UserAchievementEarned(user));
  }
}

void checkAchievements({
  required List<Achievement> achievementsData,
  required User user,
  required int boxesSent,
  required int timeForLastBox,
  required bool containsCollector,
  required bool noColorPenalty,
  required int boosterUsesTotal,
  required int timeLeft,
  required bool isBoxFull,
  required int distinctHolidaysUsed,
  required int giantPlacedCount,
  required int currentScore,
  required BuildContext context,
}) {
  // 1) First Steps
  unlockAchievementIfNeeded(
    user: user,
    achievementId: 1,
    condition: (boxesSent >= 1),
    achievementsData: achievementsData,
    context: context,
  );

  // 2) Punctual Player
  unlockAchievementIfNeeded(
    user: user,
    achievementId: 2,
    condition: (timeForLastBox < 30),
    achievementsData: achievementsData,
    context: context,
  );

  // 3) Collector’s Eye
  unlockAchievementIfNeeded(
    user: user,
    achievementId: 3,
    condition: containsCollector,
    achievementsData: achievementsData,
    context: context,
  );

  // 4) Color Master
  unlockAchievementIfNeeded(
    user: user,
    achievementId: 4,
    condition: noColorPenalty,
    achievementsData: achievementsData,
    context: context,
  );

  // 5) Buster Booster
  unlockAchievementIfNeeded(
    user: user,
    achievementId: 5,
    condition: (boosterUsesTotal >= 5),
    achievementsData: achievementsData,
    context: context,
  );

  // 6) Speedy Sender
  unlockAchievementIfNeeded(
    user: user,
    achievementId: 6,
    condition: (boxesSent >= 5 && timeLeft > 60),
    achievementsData: achievementsData,
    context: context,
  );

  // 7) Perfect Packer
  unlockAchievementIfNeeded(
    user: user,
    achievementId: 7,
    condition: isBoxFull,
    achievementsData: achievementsData,
    context: context,
  );

  // 8) Versatile Player
  unlockAchievementIfNeeded(
    user: user,
    achievementId: 8,
    condition: (distinctHolidaysUsed >= 3),
    achievementsData: achievementsData,
    context: context,
  );

  // 9) Giant Tamer
  unlockAchievementIfNeeded(
    user: user,
    achievementId: 9,
    condition: (giantPlacedCount >= 3),
    achievementsData: achievementsData,
    context: context,
  );

  // 10) Balloon Baron
  unlockAchievementIfNeeded(
    user: user,
    achievementId: 10,
    condition: (currentScore >= 1000),
    achievementsData: achievementsData,
    context: context,
  );
}
