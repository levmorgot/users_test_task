import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/albums/domain/entities/photo_entity.dart';

abstract class IPhotoRepository {
  Future<Either<Failure, List<PhotoEntity>>> getAllPhotoForAlbum(int albumId);
}
