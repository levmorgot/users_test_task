import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_test_task/core/error/exception.dart';
import 'package:users_test_task/features/posts/data/models/post_model.dart';

abstract class IPostLocalDataSource {
  Future<List<PostModel>> getLastPostsForUserFromCache(int userId);

  Future<String> getLastEdit(int userId);

  Future<void> postForUserToCache(int userId, List<PostModel> posts);

  Future<void> lastEditToCache(int userId, String lastEdit);
}

const cachePostsList = 'CACHE_POSTS_LIST';
const cachePostsLastEdit = 'CACHE_POSTS_LAST_EDIT';

class PostLocalDataSource implements IPostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> postForUserToCache(int userId, List<PostModel> posts) {
    final List<String> jsonPostList =
        posts.map((post) => json.encode(post.toJson())).toList();
    sharedPreferences.setStringList(cachePostsList + '$userId', jsonPostList);
    return Future.value();
  }

  @override
  Future<List<PostModel>> getLastPostsForUserFromCache(int userId) {
    final jsonPostList =
        sharedPreferences.getStringList(cachePostsList + '$userId');
    if (jsonPostList != null && jsonPostList.isNotEmpty) {
      try {
        return Future.value(jsonPostList
            .map((post) => PostModel.fromJson(json.decode(post)))
            .toList());
      } catch (e) {
        throw CacheException();
      }
    } else if (jsonPostList != null && jsonPostList.isEmpty) {
      return Future.value([]);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getLastEdit(int userId) {
    final jsonDoctorLastEdit = sharedPreferences.getString(cachePostsLastEdit + '$userId');
    if (jsonDoctorLastEdit != null && jsonDoctorLastEdit.isNotEmpty) {
      try {
        return Future.value(jsonDoctorLastEdit);
      } catch (e) {
        throw CacheException();
      }
    } else {
      return Future.value("");
    }
  }

  @override
  Future<void> lastEditToCache(int userId, String lastEdit) {
    sharedPreferences.setString(cachePostsLastEdit + '$userId', lastEdit);
    return Future.value();
  }
}
