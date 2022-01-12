import 'package:equatable/equatable.dart';
import 'package:users_test_task/features/albums/domain/entities/photo_entity.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object> get props => [];
}

class PhotoEmptyState extends PhotoState {
  @override
  List<Object> get props => [];
}

class PhotoLoadingState extends PhotoState {
  @override
  List<Object> get props => [];
}

class PhotoLoadedState extends PhotoState {
  final List<PhotoEntity> photosList;

  const PhotoLoadedState(this.photosList);

  @override
  List<Object> get props => [photosList];
}

class PhotoErrorState extends PhotoState {
  final String message;

  const PhotoErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
