import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:balloon_puzzle_factory/src/core/dependency_injection.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/model/achievement.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/model/user.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final userRepository = locator<UserRepository>();

  UserBloc() : super(const UserLoading()) {
    on<UserLoadData>(_onUserLoadData);
    on<UserPuzzleSolved>(_onPuzzleSolved);
    on<UserAchievementEarned>(_onAchievementEarned);
  }

  Future<void> _onUserLoadData(
    UserLoadData event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    try {
      final user = await userRepository.load() ?? User.initial;
      final achievements = await userRepository.loadAchievements();

      emit(
        UserLoaded(
          user: user,
          achievements: achievements,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при загрузке: $e'));
    }
  }

  void _onPuzzleSolved(UserPuzzleSolved event, Emitter<UserState> emit) {
    if (state is! UserLoaded) return;
    final current = state as UserLoaded;

    userRepository.update(event.user);
    emit(current.copyWith(user: event.user));
  }

  void _onAchievementEarned(
    UserAchievementEarned event,
    Emitter<UserState> emit,
  ) {
    if (state is! UserLoaded) return;
    final current = state as UserLoaded;

    userRepository.update(event.user);

    emit(current.copyWith(user: event.user));
  }
}
