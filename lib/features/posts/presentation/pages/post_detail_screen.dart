import 'package:flutter/material.dart';
import 'package:users_test_task/features/posts/domain/entities/post_entity.dart';

class PostDetailPage extends StatelessWidget {
  final PostEntity post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(post.body),
            ],
          ),
        ),
      ),
    );
  }
}
