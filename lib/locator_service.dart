import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_test_task/features/albums/data/datasources/album_local_data_sources.dart';
import 'package:users_test_task/features/albums/data/datasources/album_remote_data_sources.dart';
import 'package:users_test_task/features/albums/data/datasources/photo_local_data_sources.dart';
import 'package:users_test_task/features/albums/data/datasources/photo_remote_data_sources.dart';
import 'package:users_test_task/features/albums/data/repositories/album_repository.dart';
import 'package:users_test_task/features/albums/data/repositories/photo_repository.dart';
import 'package:users_test_task/features/albums/domain/repositories/album_repository.dart';
import 'package:users_test_task/features/albums/domain/repositories/photo_repository.dart';
import 'package:users_test_task/features/albums/domain/usecases/get_all_albums_for_user.dart';
import 'package:users_test_task/features/albums/domain/usecases/get_all_photos_for_album.dart';
import 'package:users_test_task/features/albums/presentation/bloc/albums_list_cubit/albums_list_cubit.dart';
import 'package:users_test_task/features/posts/data/datasources/post_local_data_sources.dart';
import 'package:users_test_task/features/posts/data/datasources/post_remote_data_sources.dart';
import 'package:users_test_task/features/posts/data/datasources/posts_comment_local_data_sources.dart';
import 'package:users_test_task/features/posts/data/datasources/posts_comment_remote_data_sources.dart';
import 'package:users_test_task/features/posts/data/repositories/post_repository.dart';
import 'package:users_test_task/features/posts/data/repositories/posts_comment_repository.dart';
import 'package:users_test_task/features/posts/domain/repositories/post_repository.dart';
import 'package:users_test_task/features/posts/domain/repositories/posts_comment_repository.dart';
import 'package:users_test_task/features/posts/domain/usecases/get_all_comments.dart';
import 'package:users_test_task/features/posts/domain/usecases/get_all_posts.dart';
import 'package:users_test_task/features/posts/domain/usecases/send_comment_for_post.dart';
import 'package:users_test_task/features/posts/presentation/bloc/posts_comments_list_cubit/posts_comments_list_cubit.dart';
import 'package:users_test_task/features/posts/presentation/bloc/posts_list_cubit/posts_list_cubit.dart';
import 'package:users_test_task/features/users/data/datasources/user_local_data_sources.dart';
import 'package:users_test_task/features/users/data/datasources/user_remote_data_sources.dart';
import 'package:users_test_task/features/users/data/repositories/user_repository.dart';
import 'package:users_test_task/features/users/domain/repositories/user_repository.dart';
import 'package:users_test_task/features/users/domain/usecases/get_all_users.dart';
import 'package:users_test_task/features/users/presentation/bloc/users_list_cubit/users_list_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BloC / Cubit
  sl.registerFactory(
    () => UsersListCubit(getAllUsers: sl()),
  );

  sl.registerFactory(
    () => PostsListCubit(getAllPosts: sl()),
  );

  sl.registerFactory(
    () => PostsCommentsListCubit(
        getAllCommentsForPosts: sl(), sendCommentsForPost: sl()),
  );

  sl.registerFactory(
    () => AlbumsListCubit(getAllAlbums: sl(), getAllPhotosForAlbum: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllUsers(sl()));

  sl.registerLazySingleton(() => GetAllPostsForUser(sl()));

  sl.registerLazySingleton(() => GetAllCommentsForPosts(sl()));

  sl.registerLazySingleton(() => SendCommentsForPost(sl()));

  sl.registerLazySingleton(() => GetAllAlbumsForUser(sl()));

  sl.registerLazySingleton(() => GetAllPhotosForAlbum(sl()));

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

  // Repository posts
  sl.registerLazySingleton<IPostRepository>(
    () => PostRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IPostRemoteDataSource>(
    () => PostRemoteDataSource(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<IPostLocalDataSource>(
    () => PostLocalDataSource(sharedPreferences: sl()),
  );

  // Repository posts comment
  sl.registerLazySingleton<IPostsCommentRepository>(
    () => PostsCommentRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IPostsCommentRemoteDataSource>(
    () => PostsCommentRemoteDataSource(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<IPostsCommentLocalDataSource>(
    () => PostsCommentLocalDataSource(sharedPreferences: sl()),
  );

  // Repository albums
  sl.registerLazySingleton<IAlbumRepository>(
    () => AlbumRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IAlbumRemoteDataSource>(
    () => AlbumRemoteDataSource(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<IAlbumLocalDataSource>(
    () => AlbumLocalDataSource(sharedPreferences: sl()),
  );

  // Repository photos
  sl.registerLazySingleton<IPhotoRepository>(
    () => PhotoRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IPhotoRemoteDataSource>(
    () => PhotoRemoteDataSource(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<IPhotoLocalDataSource>(
    () => PhotoLocalDataSource(sharedPreferences: sl()),
  );

  // Core

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
