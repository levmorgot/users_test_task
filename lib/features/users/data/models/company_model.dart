import 'package:users_test_task/features/users/domain/entities/company_entity.dart';

class CompanyModel extends CompanyEntity {
  const CompanyModel({required name, required catchPhrase, required bs})
      : super(
          name: name,
          catchPhrase: catchPhrase,
          bs: bs,
        );

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'catchPhrase': catchPhrase,
      'bs': bs,
    };
  }
}
