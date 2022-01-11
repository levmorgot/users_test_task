import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/core/usecases/usecase.dart';
import 'package:users_test_task/features/posts/domain/entities/posts_comment_entity.dart';
import 'package:users_test_task/features/posts/domain/repositories/posts_comment_repository.dart';

class GetAllCommentsForPosts extends UseCase<List<PostsCommentEntity>, int> {
  final IPostsCommentRepository postsCommentRepository;

  GetAllCommentsForPosts(this.postsCommentRepository);

  @override
  Future<Either<Failure, List<PostsCommentEntity>>> call(params) async {
    return await postsCommentRepository.getAllCommentsForPost(params);
  }
}
