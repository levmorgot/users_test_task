import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/core/usecases/usecase.dart';
import 'package:users_test_task/features/users/domain/entities/user_entity.dart';
import 'package:users_test_task/features/users/domain/repositories/user_repository.dart';

class GetAllUsers extends UseCase<List<UserEntity>, void> {
  final IUserRepository userRepository;

  GetAllUsers(this.userRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(params) async {
    return await userRepository.getAllUsers();
  }
}
