import 'package:dio/dio.dart';
import 'package:github_user_finder/core/exceptions/app_exceptions.dart';
import 'package:github_user_finder/modules/search-user/data/data-sources/local/search_user_cache.dart';
import 'package:github_user_finder/modules/search-user/data/data-sources/remote/github_api_service.dart';
import 'package:github_user_finder/modules/search-user/domain/interfaces/user_interface.dart';

import '../../domain/entities/user.dart';

class UserRepositoryImpl implements UserInterface {
  final GithubApiService apiService;
  final UserCacheService cacheService;

  UserRepositoryImpl(this.apiService, this.cacheService);

  @override
  Future<User> getUserByUsername(String username) async {
    try {
      final cached = await cacheService.getCachedUser(username);

      if (cached != null) return cached.toEntity();

      final userModel = await apiService.fetchUser(username);

      await cacheService.cacheUser(userModel);

      return userModel.toEntity();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException();
      }

      if (e.response?.statusCode == 404) {
        throw NotFoundException();
      }
      throw ServerException(e.response?.statusMessage ?? e.message ?? '');
    } catch (_) {
      throw UnexpectedException();
    }
  }
}
