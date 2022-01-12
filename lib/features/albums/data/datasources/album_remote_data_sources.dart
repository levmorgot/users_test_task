import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:users_test_task/core/error/exception.dart';
import 'package:users_test_task/features/albums/data/models/album_model.dart';

abstract class IAlbumRemoteDataSource {
  Future<List<AlbumModel>> getAllAlbumsForUser(int userId);
}

class AlbumRemoteDataSource implements IAlbumRemoteDataSource {
  final http.Client client;

  AlbumRemoteDataSource({required this.client});

  @override
  Future<List<AlbumModel>> getAllAlbumsForUser(int userId) async {
    return await _getAlbumsFromUrl(
        'https://jsonplaceholder.typicode.com/users/$userId/albums');
  }

  Future<List<AlbumModel>> _getAlbumsFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final albums = json.decode(response.body);
      return (albums as List)
          .map((album) => AlbumModel.fromJson(album))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
