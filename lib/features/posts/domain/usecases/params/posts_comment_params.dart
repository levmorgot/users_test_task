import 'package:equatable/equatable.dart';

class PostsCommentParams extends Equatable {
  final int postId;
  final String name;
  final String email;
  final String text;

  const PostsCommentParams({
    required this.postId,
    required this.name,
    required this.email,
    required this.text,
  });


  @override
  List<Object?> get props => [postId, name, email, text];
}