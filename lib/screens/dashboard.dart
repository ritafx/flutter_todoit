import 'package:flutter/material.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/todo.dart';

class Dashboard extends StatefulWidget {
  final userId;

  Dashboard({Key key, @required this.userId}) : super(key: key);

  @override
  DashboardState createState() => DashboardState(userId);
}

class DashboardState extends State<Dashboard> {
  final userId;
  DashboardState(this.userId);

  Future<List<ToDo>> futureTodos;
  ToDoService todoService = ToDoService();

  final TextEditingController _newTaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureTodos = todoService.getToDos(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TASKS"),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                })
          ],
          automaticallyImplyLeading: false,
        ),
        body: Container(
            child: Column(children: [
          FutureBuilder(
            future: futureTodos,
            builder:
                (BuildContext context, AsyncSnapshot<List<ToDo>> snapshot) {
              if (snapshot.hasData) {
                List<ToDo> todos = snapshot.data;
                todos.sort(
                    (a, b) => a.completed ? 1 : -1); //order by completed status

                return Expanded(
                    child: ListView(
                  children: todos
                      .map(
                        (ToDo todo) => Column(children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: todo.completed,
                                  onChanged: (bool value) {
                                    setState(() {
                                      todo.completed = value;
                                    });
                                  },
                                ),
                                Expanded(
                                    child: Text(todo.title,
                                        style: todo.completed
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyText1)), // set style according to completed status
                                IconButton(
                                  icon: Icon(Icons.delete_outline, size: 18),
                                  onPressed: () {
                                    //TODO: call function to delete from todo service
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title: Text("Task deleted"),
                                              content: Text(todo.title),
                                              actions: [
                                                TextButton(
                                                  child: Text('Close',
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            ));
                                  },
                                )
                              ],
                            ),
                          )
                        ]),
                      )
                      .toList(),
                ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          SizedBox(
              height: 60,
              child: Row(children: [
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: TextField(
                            controller: _newTaskController,
                            decoration: InputDecoration(
                                hintText: "What's your next task?",
                                hintStyle: Theme.of(context).textTheme.caption,
                                border: InputBorder.none)))),
                TextButton(
                  child: Row(children: [
                    Text(
                      "ADD NEW",
                      style: Theme.of(context).textTheme.button,
                    ),
                    Icon(
                      Icons.add,
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    )
                  ]),
                  onPressed: () {
                    if (_newTaskController.text.isNotEmpty) {
                      // TODO: call function to add task from todo service
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text("New task created"),
                                content: Text(_newTaskController.text),
                                actions: [
                                  TextButton(
                                    child: Text('Close',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _newTaskController.text = "";
                                    },
                                  )
                                ],
                              ));
                    }
                  },
                )
              ]))
        ])));
  }
}
