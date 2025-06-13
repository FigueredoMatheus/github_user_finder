import 'package:flutter/material.dart';
import 'package:github_user_finder/core/navigation/app_routes_names.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';

class CustomLoadedUserCard extends StatelessWidget {
  final User user;

  const CustomLoadedUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutesNames.USER_DETAILS,
          arguments: user,
        );
      },
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.avatarUrl),
                maxRadius: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  user.login,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
