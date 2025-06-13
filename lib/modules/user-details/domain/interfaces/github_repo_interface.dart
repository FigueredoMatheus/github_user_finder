import 'package:github_user_finder/modules/user-details/domain/entities/git_repo.dart';

abstract class GithubRepoInterface {
  Future<List<GitRepo>> getUserLastRepos(String login);
}
