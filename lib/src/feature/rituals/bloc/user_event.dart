part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserPuzzleSolved extends UserEvent {
  final User user;

  const UserPuzzleSolved({
    required this.user,
  });

  @override
  List<Object> get props => [
        user,
      ];
}

class UserAchievementEarned extends UserEvent {
  final User user;

  const UserAchievementEarned(this.user);

  @override
  List<Object> get props => [user];
}

class UserLoadData extends UserEvent {
  const UserLoadData();
}
