import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test_task/core/error/failure.dart';
import 'package:users_test_task/features/posts/domain/usecases/get_all_comments.dart';
import 'package:users_test_task/features/posts/presentation/bloc/posts_comments_list_cubit/posts_comments_list_state.dart';
import 'package:users_test_task/features/posts/presentation/bloc/posts_list_cubit/posts_list_state.dart';

class PostsCommentsListCubit extends Cubit<PostsCommentState> {
  final GetAllCommentsForPosts getAllCommentsForPosts;

  PostsCommentsListCubit({required this.getAllCommentsForPosts})
      : super(PostsCommentEmptyState());

  void loadPosts(int postId) async {
    if (state is PostLoadingState) return;

    emit(PostsCommentLoadingState());

    final failureOrPosts = await getAllCommentsForPosts(postId);

    emit(failureOrPosts.fold(
        (failure) => PostsCommentErrorState(message: _mapFailureMessage(failure)),
        (comments) => PostsCommentLoadedState(comments)));
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
