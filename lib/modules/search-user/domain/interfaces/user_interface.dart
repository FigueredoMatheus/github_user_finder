import '../entities/user.dart';

abstract class UserInterface {
  Future<User> getUserByUsername(String username);
}
