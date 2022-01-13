import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/exception.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/posts/data/datasources/post_local_data_sources.dart';
import 'package:users_test_task/features/posts/data/datasources/post_remote_data_sources.dart';
import 'package:users_test_task/features/posts/data/models/post_model.dart';
import 'package:users_test_task/features/posts/domain/entities/post_entity.dart';
import 'package:users_test_task/features/posts/domain/repositories/post_repository.dart';

class PostRepository implements IPostRepository {
  final IPostRemoteDataSource remoteDataSource;
  final IPostLocalDataSource localDataSource;

  PostRepository(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPostsForUser(
      int userId) async {
    final allPosts = await _getPosts(userId, () {
      return remoteDataSource.getAllPostsForUser(userId);
    });
    return allPosts.fold((failure) => Left(failure), (posts) => Right(posts));
  }

  Future<Either<Failure, String>> _getLastEdit(int userId) async {
    try {
      final lastEdit = await localDataSource.getLastEdit(userId);
      return Right(lastEdit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, List<PostModel>>> _getPosts(
      int userId, Future<List<PostModel>> Function() getPosts) async {
    final lastEdit = await _getLastEdit(userId);
    return lastEdit.fold((failure) => Left(failure), (date) async {
      if (date != DateTime.now().toString().substring(0, 10)) {
        try {
          final remotePosts = await getPosts();
          localDataSource.lastEditToCache(
              userId, DateTime.now().toString().substring(0, 10));
          localDataSource.postForUserToCache(userId, remotePosts);
          return Right(remotePosts);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        try {
          final localFPosts =
              await localDataSource.getLastPostsForUserFromCache(userId);
          return Right(localFPosts);
        } on CacheException {
          return Left(CacheFailure());
        }
      }
    });
  }
}
