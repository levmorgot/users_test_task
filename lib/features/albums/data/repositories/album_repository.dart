import 'package:dartz/dartz.dart';
import 'package:users_test_task/core/error/exception.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/albums/data/datasources/album_local_data_sources.dart';
import 'package:users_test_task/features/albums/data/datasources/album_remote_data_sources.dart';
import 'package:users_test_task/features/albums/data/models/album_model.dart';
import 'package:users_test_task/features/albums/domain/entities/album_entity.dart';
import 'package:users_test_task/features/albums/domain/repositories/album_repository.dart';

class AlbumRepository implements IAlbumRepository {
  final IAlbumRemoteDataSource remoteDataSource;
  final IAlbumLocalDataSource localDataSource;

  AlbumRepository(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<AlbumEntity>>> getAllAlbumsForUser(
      int userId) async {
    final allAlbums = await _getAlbums(userId, () {
      return remoteDataSource.getAllAlbumsForUser(userId);
    });
    return allAlbums.fold(
        (failure) => Left(failure), (albums) => Right(albums));
  }

  Future<Either<Failure, String>> _getLastEdit(int userId) async {
    try {
      final lastEdit = await localDataSource.getLastEdit(userId);
      return Right(lastEdit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, List<AlbumModel>>> _getAlbums(
      int userId, Future<List<AlbumModel>> Function() getAlbums) async {
    final lastEdit = await _getLastEdit(userId);
    return lastEdit.fold((failure) => Left(failure), (date) async {
      if (date != DateTime.now().toString().substring(0, 10)) {
        try {
          final remoteAlbums = await getAlbums();
          localDataSource.lastEditToCache(
              userId, DateTime.now().toString().substring(0, 10));
          localDataSource.albumForUserToCache(userId, remoteAlbums);
          return Right(remoteAlbums);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        try {
          final localFilials =
              await localDataSource.getLastAlbumsForUserFromCache(userId);
          return Right(localFilials);
        } on CacheException {
          return Left(CacheFailure());
        }
      }
    });
  }
}
