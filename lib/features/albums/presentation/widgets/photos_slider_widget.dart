import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:users_test_task/features/albums/domain/entities/photo_entity.dart';
import 'package:users_test_task/features/albums/presentation/widgets/photo_slider_element_widget.dart';

class PhotosSlider extends StatelessWidget {
  final List<PhotoEntity> photos;

  const PhotosSlider({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: _getPhotoSliderElements(photos),
    );
  }

  List<Widget> _getPhotoSliderElements(List<PhotoEntity> photos) {
    List<Widget> photoWidgets = [];
    for (var i = 0; i < photos.length; i++) {
      photoWidgets.add(PhotoSliderElement(
        photo: photos[i],
      ));
    }
    return photoWidgets;
  }
}
