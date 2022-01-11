import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:users_test_task/core/error/exception.dart';
import 'package:users_test_task/features/posts/data/models/posts_comment_model.dart';

abstract class IPostsCommentRemoteDataSource {
  Future<List<PostsCommentModel>> getAllCommentsForPosts(int postId);

  Future<PostsCommentModel> sendCommentForPost(int postId, String name,
      String email, String text);
}

class PostsCommentRemoteDataSource implements IPostsCommentRemoteDataSource {
  final http.Client client;

  PostsCommentRemoteDataSource({required this.client});

  @override
  Future<List<PostsCommentModel>> getAllCommentsForPosts(int postId) async {
    return await _getCommentsFromUrl(
        'https://jsonplaceholder.typicode.com/posts/$postId/comments');
  }

  Future<List<PostsCommentModel>> _getCommentsFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final posts = json.decode(response.body);
      return (posts as List)
          .map((post) => PostsCommentModel.fromJson(post))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostsCommentModel> sendCommentForPost(int postId, String name,
      String email, String text) async {
    String url = 'https://jsonplaceholder.typicode.com/posts/$postId/comments';
    print(url);
    final response = await client
        .post(Uri.parse(
        url), headers: {'Content-Type': 'application/json'}, body: {
          "name": name,
          "email": email,
          "body": text
    });
    if (response.statusCode == 200) {
      final post = json.decode(response.body);
      return PostsCommentModel.fromJson(post);
    } else {
      throw ServerException();
    }
  }

}
