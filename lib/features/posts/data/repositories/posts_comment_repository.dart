import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/exception.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/posts/data/datasources/posts_comment_local_data_sources.dart';
import 'package:users_test_task/features/posts/data/datasources/posts_comment_remote_data_sources.dart';
import 'package:users_test_task/features/posts/data/models/posts_comment_model.dart';
import 'package:users_test_task/features/posts/domain/entities/posts_comment_entity.dart';
import 'package:users_test_task/features/posts/domain/repositories/posts_comment_repository.dart';

class PostsCommentRepository implements IPostsCommentRepository {
  final IPostsCommentRemoteDataSource remoteDataSource;
  final IPostsCommentLocalDataSource localDataSource;

  PostsCommentRepository(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<PostsCommentEntity>>> getAllCommentsForPost(
      int postId) async {
    final allComments = await _getComments(postId, () {
      return remoteDataSource.getAllCommentsForPosts(postId);
    });
    return allComments.fold(
        (failure) => Left(failure), (comments) => Right(comments));
  }

  Future<Either<Failure, String>> _getLastEdit(int postId) async {
    try {
      final lastEdit = await localDataSource.getLastEdit(postId);
      return Right(lastEdit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, List<PostsCommentModel>>> _getComments(
      int postId, Future<List<PostsCommentModel>> Function() getComments) async {
    final lastEdit = await _getLastEdit(postId);
    return lastEdit.fold((failure) => Left(failure), (date) async {
      if (date != DateTime.now().toString().substring(0, 10)) {
        try {
          final remoteComments = await getComments();
          localDataSource.lastEditToCache(
              postId, DateTime.now().toString().substring(0, 10));
          localDataSource.commentsForPostToCache(postId, remoteComments);
          return Right(remoteComments);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        try {
          final localComments =
              await localDataSource.getLastCommentsForPostsFromCache(postId);
          return Right(localComments);
        } on CacheException {
          return Left(CacheFailure());
        }
      }
    });
  }

  @override
  Future<Either<Failure, PostsCommentEntity>> sendCommentForPost(
      int postId, String name, String email, String text) async {
    try {
      final newComment =
          await remoteDataSource.sendCommentForPost(postId, name, email, text);
      await localDataSource.addNewCommentForPostToCache(postId, newComment);
      return Right(newComment);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
