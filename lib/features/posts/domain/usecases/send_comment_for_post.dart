import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/core/usecases/usecase.dart';
import 'package:users_test_task/features/posts/domain/entities/posts_comment_entity.dart';
import 'package:users_test_task/features/posts/domain/repositories/posts_comment_repository.dart';
import 'package:users_test_task/features/posts/domain/usecases/params/posts_comment_params.dart';

class SendCommentsForPost extends UseCase<PostsCommentEntity, PostsCommentParams> {
  final IPostsCommentRepository postsCommentRepository;

  SendCommentsForPost(this.postsCommentRepository);

  @override
  Future<Either<Failure, PostsCommentEntity>> call(PostsCommentParams params) async {
    return await postsCommentRepository.sendCommentForPost(params.postId, params.name, params.email, params.text);
  }
}
