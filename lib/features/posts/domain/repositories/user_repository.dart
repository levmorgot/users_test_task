import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/posts/domain/entities/post_entity.dart';

abstract class IPostRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPostsForUser(int userId);
}
