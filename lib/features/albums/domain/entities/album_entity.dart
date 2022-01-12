import 'package:equatable/equatable.dart';

class AlbumEntity extends Equatable {
  final int id;
  final int userId;
  final String title;

  const AlbumEntity({
    required this.id,
    required this.userId,
    required this.title,
  });

  @override
  List<Object?> get props =>
      [id, userId, title];
}
