import 'package:equatable/equatable.dart';
import 'package:users_test_task/features/posts/domain/entities/posts_comment_entity.dart';

abstract class PostsCommentState extends Equatable {
  const PostsCommentState();

  @override
  List<Object> get props => [];
}

class PostsCommentEmptyState extends PostsCommentState {
  @override
  List<Object> get props => [];
}

class PostsCommentLoadingState extends PostsCommentState {

  @override
  List<Object> get props => [];
}


class PostsCommentLoadedState extends PostsCommentState {
  final List<PostsCommentEntity> postsCommentsList;

  const PostsCommentLoadedState(this.postsCommentsList);

  @override
  List<Object> get props => [postsCommentsList];
}

class PostsCommentErrorState extends PostsCommentState {
  final String message;

  const PostsCommentErrorState({required this.message});

  @override
  List<Object> get props => [message];
}


class PostsCommentSentState extends PostsCommentState {
  final String resultMessage;

  const PostsCommentSentState({required this.resultMessage});

  @override
  List<Object> get props => [resultMessage];
}
