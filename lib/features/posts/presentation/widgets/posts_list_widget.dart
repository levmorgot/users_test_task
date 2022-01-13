import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test_task/common/widgets/error_message_widget.dart';
import 'package:users_test_task/common/widgets/loading_indicator_widget.dart';
import 'package:users_test_task/features/posts/domain/entities/post_entity.dart';
import 'package:users_test_task/features/posts/presentation/bloc/posts_list_cubit/posts_list_cubit.dart';
import 'package:users_test_task/features/posts/presentation/bloc/posts_list_cubit/posts_list_state.dart';
import 'package:users_test_task/features/posts/presentation/widgets/post_preview_card_widget.dart';

class PostsList extends StatelessWidget {
  final int userId;

  const PostsList({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PostsListCubit>().loadPosts(userId);
    return BlocBuilder<PostsListCubit, PostState>(builder: (context, state) {
      List<PostEntity> posts = [];
      if (state is PostLoadingState) {
        return const LoadingIndicator();
      } else if (state is PostErrorState) {
        return ErrorMessage(
          message: state.message,
        );
      } else if (state is PostLoadedState) {
        posts = state.postsList;
      }
      return ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return PostPreviewCard(post: posts[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: posts.length,
      );
    });
  }
}
