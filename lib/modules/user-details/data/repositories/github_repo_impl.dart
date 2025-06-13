import 'package:github_user_finder/modules/user-details/data/data-sources/remote/github_repo_api_service.dart';
import 'package:github_user_finder/modules/user-details/domain/entities/git_repo.dart';
import 'package:github_user_finder/modules/user-details/domain/interfaces/github_repo_interface.dart';

class GithubRepoImpl extends GithubRepoInterface {
  final GithubRepoApiService githubRepoApiService;

  GithubRepoImpl(this.githubRepoApiService);

  @override
  Future<List<GitRepo>> getUserLastRepos(String login) async {
    final response =
        await githubRepoApiService.getLastUpdatedRepos(login, 5, 'updated');

    final futures = response.map((repo) async {
      try {
        final commits = await countCommits(login, repo.name, 1, 1);

        return GitRepo(
          repoName: repo.name,
          commitCount: commits,
        );
      } catch (_) {
        return GitRepo(repoName: repo.name, commitCount: 0);
      }
    });

    return await Future.wait(futures);
  }

  Future<int> countCommits(
      String owner, String repoName, int perPage, int page) async {
    final res =
        await githubRepoApiService.countCommits(owner, repoName, perPage, page);

    final link = res.response.headers.value('link');

    final match = RegExp(r'&page=(\d+)>;\s*rel="last"').firstMatch(link ?? '');

    return match != null ? int.parse(match.group(1)!) : 1;
  }
}
