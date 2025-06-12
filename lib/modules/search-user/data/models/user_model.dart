import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String login;
  final String name;
  final String? bio;
  final String? location;
  final int followers;

  @JsonKey(name: 'public_repos')
  final int publicRepos;

  UserModel({
    required this.login,
    required this.name,
    required this.followers,
    required this.publicRepos,
    this.bio,
    this.location,
  });

  User toEntity() => User(
        login: login,
        name: name,
        bio: bio,
        location: location,
        followers: followers,
        publicRepos: publicRepos,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
