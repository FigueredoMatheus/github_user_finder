import 'package:dio/dio.dart';
import 'package:github_user_finder/modules/search-user/data/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'github_api_service.g.dart';

@RestApi(baseUrl: "https://api.github.com/")
abstract class GithubApiService {
  factory GithubApiService(Dio dio, {String baseUrl}) = _GithubApiService;

  @GET("/users/{username}")
  Future<UserModel> fetchUser(@Path("username") String username);
}
