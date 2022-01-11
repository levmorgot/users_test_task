import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_test_task/features/users/data/datasources/user_local_data_sources.dart';
import 'package:users_test_task/features/users/data/repositories/user_repository.dart';
import 'package:users_test_task/features/users/domain/usecases/get_all_users.dart';
import 'package:users_test_task/features/users/presentation/bloc/users_list_cubit/users_list_cubit.dart';

import 'features/users/data/datasources/user_remote_data_sources.dart';
import 'features/users/domain/repositories/user_repository.dart';

import 'package:http/http.dart' as http;


final sl = GetIt.instance;

Future<void> init() async {
  // BloC / Cubit
  sl.registerFactory(
    () => UsersListCubit(getAllUsers: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllUsers(sl()));

  // Repository users
  sl.registerLazySingleton<IUserRepository>(
    () => UserRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IUserRemoteDataSource>(
    () => UserRemoteDataSource(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<IUserLocalDataSource>(
    () => UserLocalDataSource(sharedPreferences: sl()),
  );

  // Core


  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
