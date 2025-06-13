import 'package:github_user_finder/modules/user-details/domain/entities/git_repo.dart';
import 'package:github_user_finder/modules/user-details/domain/interfaces/github_repo_interface.dart';

class GetLastFiveUserRepos {
  final GithubRepoInterface interface;

  GetLastFiveUserRepos(this.interface);

  Future<List<GitRepo>> call(String login) {
    return interface.getUserLastRepos(login);
  }
}
