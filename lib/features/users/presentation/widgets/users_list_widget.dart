import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test_task/common/widgets/error_message_widget.dart';
import 'package:users_test_task/common/widgets/loading_indicator_widget.dart';
import 'package:users_test_task/features/users/domain/entities/user_entity.dart';
import 'package:users_test_task/features/users/presentation/bloc/users_list_cubit/users_list_cubit.dart';
import 'package:users_test_task/features/users/presentation/bloc/users_list_cubit/users_list_state.dart';
import 'package:users_test_task/features/users/presentation/widgets/users_card_widget.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersListCubit, UserState>(builder: (context, state) {
      List<UserEntity> users = [];
      if (state is UserLoadingState) {
        return const LoadingIndicator();
      } else if (state is UserErrorState) {
        return ErrorMessage(
          message: state.message,
        );
      } else if (state is UserLoadedState) {
        users = state.usersList;
      }
      return ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return UserCard(user: users[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: users.length,
      );
    });
  }
}
