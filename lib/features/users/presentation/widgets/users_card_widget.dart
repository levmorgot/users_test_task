import 'package:flutter/material.dart';
import 'package:users_test_task/common/app_colors.dart';
import 'package:users_test_task/features/users/domain/entities/user_entity.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DepartmentsPage(filialCacheId: filial.cashId, filialId: filial.id,)));
      // },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                user.username,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                user.name,
                style: const TextStyle(
                  color: AppColors.greyColor,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
