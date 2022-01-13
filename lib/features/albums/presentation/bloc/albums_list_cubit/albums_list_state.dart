import 'package:equatable/equatable.dart';
import 'package:users_test_task/features/albums/domain/entities/album_entity.dart';
import 'package:users_test_task/features/albums/domain/entities/photo_entity.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumEmptyState extends AlbumState {
  @override
  List<Object> get props => [];
}

class AlbumLoadingState extends AlbumState {
  @override
  List<Object> get props => [];
}

class AlbumLoadedState extends AlbumState {
  final List<AlbumEntity> albumsList;
  final List<PhotoEntity> allPhotos;

  const AlbumLoadedState(this.albumsList, this.allPhotos);

  @override
  List<Object> get props => [albumsList];
}

class AlbumErrorState extends AlbumState {
  final String message;

  const AlbumErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
