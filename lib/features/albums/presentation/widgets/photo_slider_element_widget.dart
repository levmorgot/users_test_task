import 'package:flutter/material.dart';
import 'package:users_test_task/features/albums/domain/entities/photo_entity.dart';
import 'package:users_test_task/features/albums/presentation/widgets/photo_cache_image_widget.dart';

class PhotoSliderElement extends StatelessWidget {
  final PhotoEntity photo;

  const PhotoSliderElement({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          PhotoCacheImage(
            height: 300,
            width: 300,
            photoUrl: photo.url,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(photo.title),
        ],
      ),
    );
  }
}
