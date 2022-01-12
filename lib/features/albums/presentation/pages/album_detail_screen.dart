import 'package:flutter/material.dart';
import 'package:users_test_task/common/app_colors.dart';
import 'package:users_test_task/features/albums/domain/entities/album_entity.dart';

class AlbumDetailPage extends StatelessWidget {
  final AlbumEntity album;

  const AlbumDetailPage({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Альбом'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                album.title,
                style: const TextStyle(
                  color: AppColors.greyColor,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Тут надо фотки',
                style: TextStyle(
                  color: AppColors.greyColor,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
