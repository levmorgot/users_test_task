import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/core/usecases/usecase.dart';
import 'package:users_test_task/features/posts/domain/entities/post_entity.dart';
import 'package:users_test_task/features/posts/domain/repositories/post_repository.dart';

class GetAllPostsForUser extends UseCase<List<PostEntity>, int> {
  final IPostRepository postRepository;

  GetAllPostsForUser(this.postRepository);

  @override
  Future<Either<Failure, List<PostEntity>>> call(params) async {
    return await postRepository.getAllPostsForUser(params);
  }
}
