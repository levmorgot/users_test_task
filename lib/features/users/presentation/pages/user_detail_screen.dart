import 'package:flutter/material.dart';
import 'package:users_test_task/features/posts/presentation/widgets/posts_list_preview_widget.dart';
import 'package:users_test_task/features/users/domain/entities/user_entity.dart';
import 'package:users_test_task/features/users/presentation/widgets/user_info_widget.dart';

class UserDetailPage extends StatelessWidget {
  final UserEntity user;

  const UserDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            children: [
              UserInfo(user: user),
              const SizedBox(height: 30,),
              PostsListPreview(userId: user.id),
            ],
          ),
        ),
      ),
    );
  }
}
