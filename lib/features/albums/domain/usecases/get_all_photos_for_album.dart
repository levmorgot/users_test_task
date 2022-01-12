import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/core/usecases/usecase.dart';
import 'package:users_test_task/features/albums/domain/entities/photo_entity.dart';
import 'package:users_test_task/features/albums/domain/repositories/photo_repository.dart';

class GetAllPhotosForAlbum extends UseCase<List<PhotoEntity>, int> {
  final IPhotoRepository photoRepository;

  GetAllPhotosForAlbum(this.photoRepository);

  @override
  Future<Either<Failure, List<PhotoEntity>>> call(params) async {
    return await photoRepository.getAllPhotoForAlbum(params);
  }
}
