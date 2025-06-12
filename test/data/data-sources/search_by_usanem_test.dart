import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_user_finder/core/exceptions/app_exceptions.dart';
import 'package:github_user_finder/modules/search-user/data/data-sources/local/cache_user_service.dart';
import 'package:github_user_finder/modules/search-user/data/data-sources/remote/github_api_service.dart';
import 'package:github_user_finder/modules/search-user/data/models/user_model.dart';
import 'package:github_user_finder/modules/search-user/data/repositories/user_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'search_by_usanem_test.mocks.dart';

@GenerateMocks([GithubApiService, CacheUserService])
void main() {
  late GithubApiService mockApi;
  late CacheUserService mockCache;
  late UserRepositoryImpl repository;

  const username = 'octocat';

  final userModel = UserModel.fromJson({
    "login": "octocat",
    "name": "The Octocat",
    "bio": "GitHub mascot",
    "location": "San Francisco",
    "followers": 100,
    "public_repos": 8,
    "avatar_url": "https://avatars.githubusercontent.com/u/583231?v=4",
  });

  final userEntity = userModel.toEntity();

  setUp(() {
    mockApi = MockGithubApiService();
    mockCache = MockCacheUserService();
    repository = UserRepositoryImpl(mockApi, mockCache);
  });

  group('getUserByUsername', () {
    test('deve retornar usuário do cache se existir', () async {
      when(mockCache.getCachedUserByUsername(username))
          .thenAnswer((_) async => userModel);

      final result = await repository.getUserByUsername(username);

      expect(result.login, equals(userEntity.login));
      verifyNever(mockApi.fetchUser(username));
      verify(mockCache.getCachedUserByUsername(username)).called(1);
    });

    test('deve buscar da API se cache for nulo e salvar localmente', () async {
      when(mockCache.getCachedUserByUsername(username))
          .thenAnswer((_) async => null);
      when(mockApi.fetchUser(username)).thenAnswer((_) async => userModel);
      when(mockCache.cacheUser(userModel)).thenAnswer((_) async => {});

      final result = await repository.getUserByUsername(username);

      expect(result.login, equals(userEntity.login));
      verify(mockApi.fetchUser(username)).called(1);
      verify(mockCache.cacheUser(userModel)).called(1);
    });

    test('deve lançar NotFoundException se status 404', () async {
      when(mockCache.getCachedUserByUsername(username))
          .thenAnswer((_) async => null);
      when(mockApi.fetchUser(username)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(statusCode: 404, requestOptions: RequestOptions()),
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        () => repository.getUserByUsername(username),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('deve lançar NetworkException em timeout', () async {
      when(mockCache.getCachedUserByUsername(username))
          .thenAnswer((_) async => null);
      when(mockApi.fetchUser(username)).thenThrow(
        DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        () => repository.getUserByUsername(username),
        throwsA(isA<NetworkException>()),
      );
    });

    test('deve lançar ServerException para status desconhecido', () async {
      when(mockCache.getCachedUserByUsername(username))
          .thenAnswer((_) async => null);
      when(mockApi.fetchUser(username)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            statusMessage: 'Internal Server Error',
            requestOptions: RequestOptions(),
          ),
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        () => repository.getUserByUsername(username),
        throwsA(predicate((e) =>
            e is ServerException &&
            e.message.contains('Internal Server Error'))),
      );
    });

    test('deve lançar UnexpectedException para erro genérico', () async {
      when(mockCache.getCachedUserByUsername(username))
          .thenAnswer((_) async => null);
      when(mockApi.fetchUser(username)).thenThrow(Exception('Algo errado'));

      expect(
        () => repository.getUserByUsername(username),
        throwsA(isA<UnexpectedException>()),
      );
    });
  });
}
