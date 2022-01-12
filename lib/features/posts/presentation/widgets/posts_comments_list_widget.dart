import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test_task/features/posts/domain/entities/posts_comment_entity.dart';
import 'package:users_test_task/features/posts/presentation/bloc/posts_comments_list_cubit/posts_comments_list_cubit.dart';
import 'package:users_test_task/features/posts/presentation/bloc/posts_comments_list_cubit/posts_comments_list_state.dart';
import 'package:users_test_task/features/posts/presentation/widgets/add_comment_bottom_sheet.dart';
import 'package:users_test_task/features/posts/presentation/widgets/posts_comment_card_widget.dart';

class PostsCommentsList extends StatelessWidget {
  final int postId;

  const PostsCommentsList({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PostsCommentsListCubit>().loadPostsComments(postId);
    Widget? addCommentResult;
    return BlocBuilder<PostsCommentsListCubit, PostsCommentState>(
        builder: (context, state) {
      List<PostsCommentEntity> comments = [];
      if (state is PostsCommentLoadingState) {
        return _loadingIndicator();
      } else if (state is PostsCommentSentState) {
        addCommentResult = Text(state.resultMessage);
      } else if (state is PostsCommentErrorState) {
        return Text(state.message);
      } else if (state is PostsCommentLoadedState) {
        comments = state.postsCommentsList;
      }
      void _openAddCommentBottomSheet() {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return AddCommentBottomSheet(postId: postId);
            });
      }

      return Column(
        children: [
          const Text(
            "Комментарии",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          addCommentResult ?? Container(),
          const SizedBox(height: 10,),
          SizedBox(
            height: 500,
            child: ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                return PostsCommentCard(comment: comments[index]);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey[400],
                );
              },
              itemCount: comments.length,
            ),
          ),
          TextButton(
            onPressed: _openAddCommentBottomSheet,
            child: const Text('Добавить комментарий'),
          )
        ],
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
