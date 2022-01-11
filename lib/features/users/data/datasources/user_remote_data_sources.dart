import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:users_test_task/core/error/exception.dart';
import 'package:users_test_task/features/users/data/models/user_model.dart';

abstract class IUserRemoteDataSource {
  Future<List<UserModel>> getAllUsers();
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSource({required this.client});

  @override
  Future<List<UserModel>> getAllUsers() async {
    return await _getUsersFromUrl(
        'https://jsonplaceholder.typicode.com/users');
  }

  Future<List<UserModel>> _getUsersFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final users = json.decode(response.body);
      return (users as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
