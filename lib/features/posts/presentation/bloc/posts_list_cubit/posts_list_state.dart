import 'package:equatable/equatable.dart';
import 'package:users_test_task/features/posts/domain/entities/post_entity.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostEmptyState extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoadingState extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoadedState extends PostState {
  final List<PostEntity> postsList;

  const PostLoadedState(this.postsList);

  @override
  List<Object> get props => [postsList];
}

class PostErrorState extends PostState {
  final String message;

  const PostErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
