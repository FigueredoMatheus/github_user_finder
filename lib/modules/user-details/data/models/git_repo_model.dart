import 'package:json_annotation/json_annotation.dart';

part 'git_repo_model.g.dart';

@JsonSerializable()
class RepoModel {
  final String name;

  RepoModel(this.name);

  factory RepoModel.fromJson(Map<String, dynamic> json) =>
      _$RepoModelFromJson(json);

  Map<String, dynamic> toJson() => _$RepoModelToJson(this);
}
