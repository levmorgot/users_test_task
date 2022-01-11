import 'package:users_test_task/features/posts/domain/entities/posts_comment_entity.dart';

class PostsCommentModel extends PostsCommentEntity {
  const PostsCommentModel(
      {required id,
      required postId,
      required name,
      required email,
      required body})
      : super(
          id: id,
          postId: postId,
          name: name,
          email: email,
          body: body,
        );

  factory PostsCommentModel.fromJson(Map<String, dynamic> json) {
    return PostsCommentModel(
      id: json['id'],
      postId: json['postId'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'name': name,
      'email': email,
      'body': body,
    };
  }
}
