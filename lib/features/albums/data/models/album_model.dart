import 'package:users_test_task/features/albums/domain/entities/album_entity.dart';

class AlbumModel extends AlbumEntity {
  const AlbumModel({required id, required userId, required title})
      : super(
          id: id,
          userId: userId,
          title: title,
        );

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
    };
  }
}
