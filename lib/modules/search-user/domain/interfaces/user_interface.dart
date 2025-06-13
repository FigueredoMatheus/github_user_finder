import '../entities/user.dart';

abstract class UserInterface {
  Future<User> getUserByUsername(String username);

  Future<List<User>> getUsersPaginated({int limit, int offset});
}
