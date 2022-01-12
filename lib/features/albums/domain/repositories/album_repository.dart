import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/albums/domain/entities/album_entity.dart';

abstract class IAlbumRepository {
  Future<Either<Failure, List<AlbumEntity>>> getAllAlbumsForUser(int userId);
}
