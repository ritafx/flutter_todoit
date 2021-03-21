import 'dart:convert';
import 'package:http/http.dart';
import 'package:todoapp/models/user.dart';

class UsersService {

  // find user by email
  Future<User> getUser(String email) async {
    User user;
    List<User> users = await getAllUsers();
    user = users.firstWhere((u) => u.email.toLowerCase().contains(email.toLowerCase()), orElse: () => null);
    return user;
  }

  // get all users from external service
  Future<List<User>> getAllUsers() async {
    Response res =
        await get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<User> users = body
          .map(
            (dynamic item) => User.fromJson(item),
          )
          .toList();

      return users;
    } else {
      throw "Can't get users.";
    }
  }
}
