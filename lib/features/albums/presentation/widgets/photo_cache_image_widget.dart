import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoCacheImage extends StatelessWidget {
  final String photoUrl;
  final double width, height;

  const PhotoCacheImage(
      {Key? key,
      required this.photoUrl,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: width,
      width: height,
      imageUrl: photoUrl,
      imageBuilder: (context, imageProvider) {
        return _imageWidget(imageProvider);
      },
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      errorWidget: (context, url, error) {
        return _imageWidget(const AssetImage('assets/image/404.png'));
      },
    );
  }

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          )),
    );
  }
}
