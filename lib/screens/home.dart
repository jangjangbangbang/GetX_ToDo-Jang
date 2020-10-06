import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/controllers/authController.dart';
import 'package:getx_todo/controllers/todoController.dart';
import 'package:getx_todo/controllers/userController.dart';
import 'package:getx_todo/models/todo.dart';
import 'package:getx_todo/services/database.dart';

class Home extends GetWidget<AuthController> {
  final TextEditingController _todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GetX<UserController>(
          initState: (_) async {
            Get.find<UserController>().user =
                await Database().getUser(Get.find<AuthController>().user.uid);
          },
          builder: (_) {
            if (_.user.name != null) {
              return Text(
                "Welcome " + _.user.name,
              );
            } else {
              return Text("Loading...");
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: InkWell(
              onTap: () {
                AuthController().signOut();
              },
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Add Todo Here:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _todoController,
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (_todoController.text != "") {
                          Database().addTodo(
                              _todoController.text, controller.user.uid);
                          _todoController.clear();
                        }
                      }),
                ],
              ),
            ),
          ),
          Text(
            "Your Todos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GetX<TodoController>(
            init: Get.put<TodoController>(TodoController()),
            builder: (TodoController todoController) {
              if (todoController != null && todoController.todos != null) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: todoController.todos.length,
                      itemBuilder: (_, index) {
                        return TodoCard(
                            uid: controller.user.uid,
                            todo: todoController.todos[index]);
                      }),
                );
              } else {
                return Text("Loading...");
              }
            },
          )
        ],
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  final String uid;
  final TodoModel todo;

  const TodoCard({Key key, this.uid, this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        Database().deleteTodo(uid, todo.todoId);
      },
      background: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.cancel),
            ],
          )),
      secondaryBackground: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.cancel),
            ],
          )),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: FlatButton(
                  onPressed: () {
                    Database().updateTodo(!todo.done, uid, todo.todoId);
                  },
                  child: Text(
                    todo.content,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration:
                            todo.done ? TextDecoration.lineThrough : null,
                        color: todo.done ? Colors.grey : Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print('Tapped Edit');
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(Icons.edit),
              ),
            )
            // Checkbox(
            //     value: todo.done,
            // onChanged: (newValue) {
            //   Database().updateTodo(newValue, uid, todo.todoId);
            // })
          ],
        ),
      ),
    );
  }
}
