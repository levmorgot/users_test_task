import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/users/domain/entities/user_entity.dart';

abstract class IUserRepository {
  Future<Either<Failure, List<UserEntity>>> getAllUsers();
}
