import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test_task/common/app_colors.dart';
import 'package:users_test_task/features/posts/presentation/bloc/posts_comments_list_cubit/posts_comments_list_cubit.dart';
import 'package:users_test_task/features/posts/presentation/bloc/posts_list_cubit/posts_list_cubit.dart';
import 'package:users_test_task/features/users/presentation/bloc/users_list_cubit/users_list_cubit.dart';
import 'package:users_test_task/features/users/presentation/pages/users_screen.dart';
import 'package:users_test_task/locator_service.dart' as di;
import 'package:users_test_task/locator_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<UsersListCubit>(
              create: (context) => sl<UsersListCubit>()..loadUsers()),
          BlocProvider<PostsListCubit>(
              create: (context) => sl<PostsListCubit>()),

          BlocProvider<PostsCommentsListCubit>(
              create: (context) => sl<PostsCommentsListCubit>()),
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            backgroundColor: AppColors.mainBackground,
            scaffoldBackgroundColor: AppColors.mainBackground,
          ),
          home: const HomePage(),
        ));
  }
}
