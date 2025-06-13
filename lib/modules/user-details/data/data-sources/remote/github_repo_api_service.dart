import 'package:dio/dio.dart';
import 'package:github_user_finder/modules/user-details/data/models/git_repo_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'github_repo_api_service.g.dart';

@RestApi(baseUrl: "https://api.github.com")
abstract class GithubRepoApiService {
  factory GithubRepoApiService(Dio dio) = _GithubRepoApiService;

  @GET("/users/{login}/repos")
  Future<List<RepoModel>> getLastUpdatedRepos(
    @Path("login") String login,
    @Query("per_page") int perPage,
    @Query("sort") String sort,
  );

  @GET("/repos/{owner}/{repo}/commits")
  Future<HttpResponse> countCommits(
    @Path("owner") String owner,
    @Path("repo") String repo,
    @Query("per_page") int perPage,
    @Query("page") int page,
  );
}
