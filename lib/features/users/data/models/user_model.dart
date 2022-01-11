import 'package:users_test_task/features/users/data/models/company_model.dart';
import 'package:users_test_task/features/users/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required id,
      required name,
      required username,
      required email,
      required phone,
      required website,
      required address,
      required company})
      : super(
          id: id,
          name: name,
          username: username,
          email: email,
          phone: phone,
          website: website,
          address: address,
          company: company,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      address: _getFullAddress(json['address']),
      company: CompanyModel.fromJson(json['company']),
    );
  }

  static String _getFullAddress(Map<String, dynamic> address) {
    return '${address["zipcode"]}, ${address["suite"]}, ${address["street"]}, ${address["city"]}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'address': address,
      'company': company,
    };
  }
}
