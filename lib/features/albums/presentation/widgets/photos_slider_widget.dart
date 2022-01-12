import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test_task/features/albums/domain/entities/photo_entity.dart';
import 'package:users_test_task/features/albums/presentation/bloc/photos_list_cubit/photos_list_cubit.dart';
import 'package:users_test_task/features/albums/presentation/bloc/photos_list_cubit/photos_list_state.dart';
import 'package:users_test_task/features/albums/presentation/widgets/photo_slider_element_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PhotosSlider extends StatelessWidget {
  final int albumId;

  const PhotosSlider({Key? key, required this.albumId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PhotosListCubit>().loadPhotos(albumId);
    return BlocBuilder<PhotosListCubit, PhotoState>(builder: (context, state) {
      List<PhotoEntity> photos = [];
      if (state is PhotoLoadingState) {
        return _loadingIndicator();
      } else if (state is PhotoErrorState) {
        return Text(state.message);
      } else if (state is PhotoLoadedState) {
        photos = state.photosList;
      }
      return CarouselSlider(
        options: CarouselOptions(height: 400.0),
        items: _getPhotoSliderElements(photos),
      );
    });
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

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
