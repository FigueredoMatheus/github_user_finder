// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      login: json['login'] as String,
      name: json['name'] as String,
      followers: (json['followers'] as num).toInt(),
      publicRepos: (json['public_repos'] as num).toInt(),
      avatarUrl: json['avatar_url'] as String,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'login': instance.login,
      'name': instance.name,
      'bio': instance.bio,
      'location': instance.location,
      'followers': instance.followers,
      'public_repos': instance.publicRepos,
      'avatar_url': instance.avatarUrl,
    };
