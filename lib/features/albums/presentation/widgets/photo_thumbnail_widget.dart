import 'package:flutter/material.dart';
import 'package:users_test_task/features/albums/domain/entities/photo_entity.dart';

class PhotoThumbnail extends StatelessWidget {
  final PhotoEntity photo;
  final double size;

  const PhotoThumbnail({
    Key? key,
    required this.photo,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: size,
        width: size,
        child: Image.network(photo.thumbnailUrl),
      ),
    );
  }
}
