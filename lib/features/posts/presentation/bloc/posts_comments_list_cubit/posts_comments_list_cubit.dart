import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/posts/domain/entities/posts_comment_entity.dart';
import 'package:users_test_task/features/posts/domain/usecases/get_all_comments.dart';
import 'package:users_test_task/features/posts/domain/usecases/params/posts_comment_params.dart';
import 'package:users_test_task/features/posts/domain/usecases/send_comment_for_post.dart';
import 'package:users_test_task/features/posts/presentation/bloc/posts_comments_list_cubit/posts_comments_list_state.dart';

class PostsCommentsListCubit extends Cubit<PostsCommentState> {
  final GetAllCommentsForPosts getAllCommentsForPosts;
  final SendCommentsForPost sendCommentsForPost;

  PostsCommentsListCubit(
      {required this.getAllCommentsForPosts, required this.sendCommentsForPost})
      : super(PostsCommentEmptyState());

  void loadPostsComments(int postId) async {
    if (state is PostsCommentLoadingState) return;

    emit(PostsCommentLoadingState());

    final failureOrPosts = await getAllCommentsForPosts(postId);

    emit(failureOrPosts.fold(
        (failure) =>
            PostsCommentErrorState(message: _mapFailureMessage(failure)),
        (comments) => PostsCommentLoadedState(comments)));
  }

  void sendPostsComment(
      int postId, String name, String email, String text) async {
    if (state is PostsCommentLoadingState) return;

    var currentState = state;

    emit(PostsCommentLoadingState());

    List<PostsCommentEntity> oldComments =
        (currentState as PostsCommentLoadedState).postsCommentsList;

    final failureOrPosts = await sendCommentsForPost(PostsCommentParams(
        postId: postId, email: email, text: text, name: name));

    emit(failureOrPosts.fold(
        (failure) => PostsCommentSentState(
            resultMessage:
                'Не удалось добавить комментарий: ${_mapFailureMessage(failure)}'),
        (newComment) {
      oldComments.add(newComment);
      return const PostsCommentSentState(
          resultMessage: 'Комметарий успешно добавлен');
    }));
    Timer(const Duration(milliseconds: 5), () {
      emit(PostsCommentLoadedState(oldComments));
    });
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server failure';
      case CacheFailure:
        return 'Cache failure';
      default:
        return 'Unexpected Error';
    }
  }
}
