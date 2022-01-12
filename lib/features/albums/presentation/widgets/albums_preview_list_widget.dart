import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test_task/features/albums/domain/entities/album_entity.dart';
import 'package:users_test_task/features/albums/presentation/bloc/albums_list_cubit/albums_list_cubit.dart';
import 'package:users_test_task/features/albums/presentation/bloc/albums_list_cubit/albums_list_state.dart';
import 'package:users_test_task/features/albums/presentation/pages/albums_screen.dart';
import 'package:users_test_task/features/albums/presentation/widgets/albums_card_widget.dart';

class AlbumsPreviewList extends StatelessWidget {
  final int userId;
  const AlbumsPreviewList({Key? key, required this.userId}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    context.read<AlbumsListCubit>().loadAlbums(userId);
    return BlocBuilder<AlbumsListCubit, AlbumState>(
        builder: (context, state) {
      List<AlbumEntity> albums = [];
      if (state is AlbumLoadingState) {
        return _loadingIndicator();
      } else if (state is AlbumErrorState) {
        return Text(state.message);
      } else if (state is AlbumLoadedState) {
        albums = state.albumsList;
        albums = albums.isNotEmpty
            ? albums.sublist(0, albums.length < 3 ? albums.length : 3)
            : albums;
      }
      return Column(
        children: [
          const Text(
            'Альбомы пользователя',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 250,
            child: ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                return AlbumCard(album: albums[index]);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey[400],
                );
              },
              itemCount: albums.length,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            child: const Text("К списку альбомов"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AlbumsPage(userId: userId)));
            },
          ),
        ],
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
