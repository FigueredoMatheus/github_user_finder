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
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.avatarUrl),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  user.login,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
