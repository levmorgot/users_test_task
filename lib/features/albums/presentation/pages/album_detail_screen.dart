import 'package:flutter/material.dart';
import 'package:users_test_task/features/albums/domain/entities/album_entity.dart';
import 'package:users_test_task/features/albums/domain/entities/photo_entity.dart';
import 'package:users_test_task/features/albums/presentation/widgets/photos_slider_widget.dart';

class AlbumDetailPage extends StatelessWidget {
  final AlbumEntity album;
  final List<PhotoEntity> photos;

  const AlbumDetailPage({Key? key, required this.album, required this.photos})
      : super(key: key);

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
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              PhotosSlider(photos: photos),
            ],
          ),
        ),
      ),
    );
  }
}
