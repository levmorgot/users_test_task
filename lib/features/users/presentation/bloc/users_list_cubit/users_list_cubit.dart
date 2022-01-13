import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/users/domain/usecases/get_all_users.dart';
import 'package:users_test_task/features/users/presentation/bloc/users_list_cubit/users_list_state.dart';

class UsersListCubit extends Cubit<UserState> {
  final GetAllUsers getAllUsers;

  UsersListCubit({required this.getAllUsers}) : super(UserEmptyState());

  void loadUsers() async {
    if (state is UserLoadingState) return;

    emit(UserLoadingState());

    final failureOrUsers = await getAllUsers(null);

    emit(failureOrUsers.fold(
        (failure) => UserErrorState(message: _mapFailureMessage(failure)),
        (filials) => UserLoadedState(filials)));
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server failure';
      case CacheFailure:
        return 'Cache failure';
      default:
        return 'Unexpected Error';
    }
  }
}
