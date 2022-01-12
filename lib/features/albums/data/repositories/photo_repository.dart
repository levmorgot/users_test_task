import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/exception.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/albums/data/datasources/photo_local_data_sources.dart';
import 'package:users_test_task/features/albums/data/datasources/photo_remote_data_sources.dart';
import 'package:users_test_task/features/albums/data/models/photo_model.dart';
import 'package:users_test_task/features/albums/domain/entities/photo_entity.dart';
import 'package:users_test_task/features/albums/domain/repositories/photo_repository.dart';

class PhotoRepository implements IPhotoRepository {
  final IPhotoRemoteDataSource remoteDataSource;
  final IPhotoLocalDataSource localDataSource;

  PhotoRepository(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<PhotoEntity>>> getAllPhotoForAlbum(
      int albumId) async {
    final allPhotos = await _getPhotos(albumId, () {
      return remoteDataSource.getAllPhotosForAlbum(albumId);
    });
    return allPhotos.fold(
        (failure) => Left(failure), (photos) => Right(photos));
  }

  Future<Either<Failure, String>> _getLastEdit(int albumId) async {
    try {
      final lastEdit = await localDataSource.getLastEdit(albumId);
      return Right(lastEdit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, List<PhotoModel>>> _getPhotos(
      int albumId, Future<List<PhotoModel>> Function() getPhotos) async {
    final lastEdit = await _getLastEdit(albumId);
    return lastEdit.fold((failure) => Left(failure), (date) async {
      if (date != DateTime.now().toString().substring(0, 10)) {
        print('Get photos from server');
        try {
          final remotePhotos = await getPhotos();
          localDataSource.lastEditToCache(
              albumId, DateTime.now().toString().substring(0, 10));
          localDataSource.photosForAlbumToCache(albumId, remotePhotos);
          return Right(remotePhotos);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        print('Get photos from cache');
        try {
          final localFilials =
              await localDataSource.getLastPhotosForAlbumFromCache(albumId);
          return Right(localFilials);
        } on CacheException {
          return Left(CacheFailure());
        }
      }
    });
  }
}
