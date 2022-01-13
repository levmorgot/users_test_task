import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:users_test_task/core/error/exception.dart';
import 'package:users_test_task/features/posts/data/models/post_model.dart';

abstract class IPostRemoteDataSource {
  Future<List<PostModel>> getAllPostsForUser(int userId);
}

class PostRemoteDataSource implements IPostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSource({required this.client});

  @override
  Future<List<PostModel>> getAllPostsForUser(int userId) async {
    return await _getPostsFromUrl(
        'https://jsonplaceholder.typicode.com/users/$userId/posts');
  }

  Future<List<PostModel>> _getPostsFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final posts = json.decode(response.body);
      return (posts as List).map((post) => PostModel.fromJson(post)).toList();
    } else {
      throw ServerException();
    }
  }
}
