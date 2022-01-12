import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_test_task/core/error/exception.dart';
import 'package:users_test_task/features/albums/data/models/photo_model.dart';

abstract class IPhotoLocalDataSource {
  Future<List<PhotoModel>> getLastPhotosForAlbumFromCache(int albumId);

  Future<String> getLastEdit(int albumId);

  Future<void> photosForAlbumToCache(int albumId, List<PhotoModel> albums);

  Future<void> lastEditToCache(int albumId, String lastEdit);
}

const cachePhotosList = 'CACHE_PHOTOS_LIST';
const cachePhotosLastEdit = 'CACHE_PHOTOS_LAST_EDIT';

class PhotoLocalDataSource implements IPhotoLocalDataSource {
  final SharedPreferences sharedPreferences;

  PhotoLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> photosForAlbumToCache(int albumId, List<PhotoModel> albums) {
    final List<String> jsonPhotoList =
        albums.map((album) => json.encode(album.toJson())).toList();
    sharedPreferences.setStringList(cachePhotosList + '$albumId', jsonPhotoList);
    return Future.value();
  }

  @override
  Future<List<PhotoModel>> getLastPhotosForAlbumFromCache(int albumId) {
    final jsonPhotoList = sharedPreferences.getStringList(cachePhotosList + '$albumId');
    if (jsonPhotoList != null && jsonPhotoList.isNotEmpty) {
      try {
        return Future.value(jsonPhotoList
            .map((photo) => PhotoModel.fromJson(json.decode(photo)))
            .toList());
      } catch (e) {
        throw CacheException();
      }
    } else if (jsonPhotoList != null && jsonPhotoList.isEmpty) {
      return Future.value([]);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getLastEdit(int albumId) {
    final jsonPhotoList = sharedPreferences.getString(cachePhotosLastEdit + '$albumId');
    if (jsonPhotoList != null && jsonPhotoList.isNotEmpty) {
      try {
        return Future.value(jsonPhotoList);
      } catch (e) {
        throw CacheException();
      }
    } else {
      return Future.value("");
    }
  }

  @override
  Future<void> lastEditToCache(int albumId, String lastEdit) {
    sharedPreferences.setString(cachePhotosLastEdit + '$albumId', lastEdit);
    return Future.value();
  }
}
