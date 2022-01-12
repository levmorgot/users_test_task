import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/albums/domain/usecases/get_all_albums_for_user.dart';
import 'package:users_test_task/features/albums/domain/usecases/get_all_photos_for_album.dart';
import 'package:users_test_task/features/albums/presentation/bloc/albums_list_cubit/albums_list_state.dart';

class AlbumsListCubit extends Cubit<AlbumState> {
  final GetAllAlbumsForUser getAllAlbums;
  final GetAllPhotosForAlbum getAllPhotos;

  AlbumsListCubit({required this.getAllAlbums, required this.getAllPhotos})
      : super(AlbumEmptyState());

  void loadAlbums(int userId) async {
    if (state is AlbumLoadingState) return;

    emit(AlbumLoadingState());

    final failureOrAlbums = await getAllAlbums(userId);

    emit(failureOrAlbums.fold(
        (failure) => AlbumErrorState(message: _mapFailureMessage(failure)),
        (filials) => AlbumLoadedState(filials)));
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
