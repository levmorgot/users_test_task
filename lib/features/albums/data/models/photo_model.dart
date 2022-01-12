import 'package:users_test_task/features/albums/domain/entities/photo_entity.dart';

class PhotoModel extends PhotoEntity {
  const PhotoModel(
      {required id,
      required albumId,
      required title,
      required url,
      required thumbnailUrl})
      : super(
          id: id,
          albumId: albumId,
          title: title,
          url: url,
          thumbnailUrl: thumbnailUrl,
        );

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      albumId: json['albumId'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'albumId': albumId,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
