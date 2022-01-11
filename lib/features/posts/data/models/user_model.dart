import 'package:users_test_task/features/posts/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({required id, required userId, required title, required body})
      : super(
          id: id,
          userId: userId,
          title: title,
          body: body,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}
