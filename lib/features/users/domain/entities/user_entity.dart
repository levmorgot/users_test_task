import 'package:equatable/equatable.dart';
import 'package:users_test_task/features/users/domain/entities/company_entity.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String address;
  final CompanyEntity company;

  const UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  @override
  List<Object?> get props =>
      [id, name, username, email, phone, website, address, company];
}
