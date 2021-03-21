import 'dart:convert';
import 'package:http/http.dart';
import 'package:todoapp/models/todo.dart';

class ToDoService {
  
  // get list of todos by userId from external service
  Future<List<ToDo>> getToDos(int userId) async {
    Response res = await get(Uri.https(
        'jsonplaceholder.typicode.com', '/todos', {"userId": userId.toString()}));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<ToDo> todos = body
          .map(
            (dynamic item) => ToDo.fromJson(item),
          )
          .toList();

      return todos;
    } else {
      throw "Can't get todos for user {$userId}.";
    }
  }

  // TODO: create functions to add and remove a task from a specific user
}
