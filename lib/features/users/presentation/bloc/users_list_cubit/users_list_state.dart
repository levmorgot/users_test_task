import 'package:equatable/equatable.dart';
import 'package:users_test_task/features/users/domain/entities/user_entity.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserEmptyState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  final List<UserEntity> usersList;

  const UserLoadedState(this.usersList);

  @override
  List<Object> get props => [usersList];
}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
