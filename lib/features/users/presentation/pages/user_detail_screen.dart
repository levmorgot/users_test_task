import 'package:flutter/material.dart';
import 'package:users_test_task/common/app_colors.dart';
import 'package:users_test_task/features/users/domain/entities/company_entity.dart';
import 'package:users_test_task/features/users/domain/entities/user_entity.dart';

class UserDetailPage extends StatelessWidget {
  final UserEntity user;

  const UserDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            children: [
              ..._buildInfoField("Name:", user.name),
              ..._buildInfoField("Email:", user.email),
              ..._buildInfoField("Website:", user.website),
              ..._buildCompanyInfo(user.company),
              ..._buildInfoField("Address:", user.address),
            ],
          ),
        ),
      ),
    );
  }


  List<Widget> _buildCompanyInfo(CompanyEntity company) {
    return [
      const Divider(color: Colors.grey,),
      const Text(
        'Company:',
        style: TextStyle(
          color: AppColors.greyColor,
          fontSize: 20,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      ..._buildInfoField('Name:', company.name),
      ..._buildInfoField('Business strategy:', company.bs),
      const Text(
        'Catch phrase:',
        style: TextStyle(
          color: AppColors.greyColor,
          fontSize: 16,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        '"${company.catchPhrase}"',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontStyle: FontStyle.italic,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
      const Divider(color: Colors.grey,),

    ];
  }


  List<Widget> _buildInfoField(String title, String value) {
    return [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.greyColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      const SizedBox(
        height: 12,
      ),
      ];
  }
}
