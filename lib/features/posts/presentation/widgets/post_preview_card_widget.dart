import 'package:flutter/material.dart';
import 'package:users_test_task/common/app_colors.dart';
import 'package:users_test_task/features/posts/domain/entities/post_entity.dart';
import 'package:users_test_task/features/posts/presentation/pages/post_detail_screen.dart';

class PostPreviewCard extends StatelessWidget {
  final PostEntity post;

  const PostPreviewCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => PostDetailPage(post: post)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                '${post.body.split("\n")[0]}...',
                style: const TextStyle(
                  color: AppColors.greyColor,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
