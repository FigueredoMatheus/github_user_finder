import '../entities/user.dart';
import '../interfaces/user_interface.dart';

class GetUserByUsername {
  final UserInterface interface;

  GetUserByUsername(this.interface);

  Future<User> call(String username) {
    return interface.getUserByUsername(username);
  }
}
