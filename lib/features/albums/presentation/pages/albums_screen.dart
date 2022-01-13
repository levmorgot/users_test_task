import 'package:flutter/material.dart';
import 'package:users_test_task/features/albums/presentation/widgets/albums_list_widget.dart';

class AlbumsPage extends StatelessWidget {
  final int userId;

  const AlbumsPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список пользователей'),
        centerTitle: true,
      ),
      body: AlbumsList(userId: userId),
    );
  }
}
