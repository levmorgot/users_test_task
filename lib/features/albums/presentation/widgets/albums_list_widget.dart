import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test_task/common/widgets/error_message_widget.dart';
import 'package:users_test_task/common/widgets/loading_indicator_widget.dart';
import 'package:users_test_task/features/albums/domain/entities/album_entity.dart';
import 'package:users_test_task/features/albums/domain/entities/photo_entity.dart';
import 'package:users_test_task/features/albums/presentation/bloc/albums_list_cubit/albums_list_cubit.dart';
import 'package:users_test_task/features/albums/presentation/bloc/albums_list_cubit/albums_list_state.dart';
import 'package:users_test_task/features/albums/presentation/widgets/albums_card_widget.dart';

class AlbumsList extends StatelessWidget {
  final int userId;
  final int count;
  const AlbumsList({Key? key, required this.userId, this.count = 0}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    context.read<AlbumsListCubit>().loadAlbums(userId);
    return BlocBuilder<AlbumsListCubit, AlbumState>(
        builder: (context, state) {
      List<AlbumEntity> albums = [];
      List<PhotoEntity> allPhotos = [];
      if (state is AlbumLoadingState) {
        return const LoadingIndicator();
      } else if (state is AlbumErrorState) {
        return ErrorMessage(
          message: state.message,
        );
      } else if (state is AlbumLoadedState) {
        albums = state.albumsList;
        allPhotos = state.allPhotos;
      }
      return ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return AlbumCard(album: albums[index], photos: allPhotos);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: count > 0 ? count : albums.length,
      );
    });
  }
}
