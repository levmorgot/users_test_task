import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/albums/domain/usecases/get_all_photos_for_album.dart';
import 'package:users_test_task/features/albums/presentation/bloc/photos_list_cubit/photos_list_state.dart';

class PhotosListCubit extends Cubit<PhotoState> {
  final GetAllPhotosForAlbum getAllPhotos;

  PhotosListCubit({required this.getAllPhotos})
      : super(PhotoEmptyState());

  void loadPhotos(int albumId) async {
    if (state is PhotoLoadingState) return;

    emit(PhotoLoadingState());

    final failureOrPhotos = await getAllPhotos(albumId);

    emit(failureOrPhotos.fold(
        (failure) => PhotoErrorState(message: _mapFailureMessage(failure)),
        (photos) => PhotoLoadedState(photos)));
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server failure';
      case CacheFailure:
        return 'Cache failure';
      default:
        return 'Unexpected Error';
    }
  }
}
