import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:users_test_task/core/error/exception.dart';
import 'package:users_test_task/features/albums/data/models/photo_model.dart';

abstract class IPhotoRemoteDataSource {
  Future<List<PhotoModel>> getAllPhotosForAlbum(int albumId);
}

class PhotoRemoteDataSource implements IPhotoRemoteDataSource {
  final http.Client client;

  PhotoRemoteDataSource({required this.client});

  @override
  Future<List<PhotoModel>> getAllPhotosForAlbum(int albumId) async {
    return await _getPhotosFromUrl(
        'https://jsonplaceholder.typicode.com/albums/$albumId/photos');
  }

  Future<List<PhotoModel>> _getPhotosFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final photos = json.decode(response.body);
      return (photos as List)
          .map((photo) => PhotoModel.fromJson(photo))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
