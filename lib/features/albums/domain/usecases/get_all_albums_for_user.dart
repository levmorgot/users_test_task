import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/core/usecases/usecase.dart';
import 'package:users_test_task/features/albums/domain/entities/album_entity.dart';
import 'package:users_test_task/features/albums/domain/repositories/album_repository.dart';

class GetAllAlbumsForUser extends UseCase<List<AlbumEntity>, int> {
  final IAlbumRepository albumRepository;

  GetAllAlbumsForUser(this.albumRepository);

  @override
  Future<Either<Failure, List<AlbumEntity>>> call(params) async {
    return await albumRepository.getAllAlbumsForUser(params);
  }
}
