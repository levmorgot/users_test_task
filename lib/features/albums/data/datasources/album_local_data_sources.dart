import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_test_task/core/error/exception.dart';
import 'package:users_test_task/features/albums/data/models/album_model.dart';

abstract class IAlbumLocalDataSource {
  Future<List<AlbumModel>> getLastAlbumsForUserFromCache(int userId);

  Future<String> getLastEdit(int userId);

  Future<void> albumForUserToCache(int userId, List<AlbumModel> albums);

  Future<void> lastEditToCache(int userId, String lastEdit);
}

const cacheAlbumsList = 'CACHE_ALBUMS_LIST';
const cacheAlbumsLastEdit = 'CACHE_ALBUMS_LAST_EDIT';

class AlbumLocalDataSource implements IAlbumLocalDataSource {
  final SharedPreferences sharedPreferences;

  AlbumLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> albumForUserToCache(int userId, List<AlbumModel> albums) {
    final List<String> jsonAlbumList =
        albums.map((album) => json.encode(album.toJson())).toList();
    sharedPreferences.setStringList(cacheAlbumsList + '$userId', jsonAlbumList);
    return Future.value();
  }

  @override
  Future<List<AlbumModel>> getLastAlbumsForUserFromCache(int userId) {
    final jsonAlbumList =
        sharedPreferences.getStringList(cacheAlbumsList + '$userId');
    if (jsonAlbumList != null && jsonAlbumList.isNotEmpty) {
      try {
        return Future.value(jsonAlbumList
            .map((album) => AlbumModel.fromJson(json.decode(album)))
            .toList());
      } catch (e) {
        throw CacheException();
      }
    } else if (jsonAlbumList != null && jsonAlbumList.isEmpty) {
      return Future.value([]);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getLastEdit(int userId) {
    final jsonAlbumList =
        sharedPreferences.getString(cacheAlbumsLastEdit + '$userId');
    if (jsonAlbumList != null && jsonAlbumList.isNotEmpty) {
      try {
        return Future.value(jsonAlbumList);
      } catch (e) {
        throw CacheException();
      }
    } else {
      return Future.value("");
    }
  }

  @override
  Future<void> lastEditToCache(int userId, String lastEdit) {
    sharedPreferences.setString(cacheAlbumsLastEdit + '$userId', lastEdit);
    return Future.value();
  }
}
