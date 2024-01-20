import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todo_bloc.dart';

// ignore: must_be_immutable
class AddTaskWindow extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  TodoBloc todoBloc;
  AddTaskWindow(this.todoBloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Add Task",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            hintText: "Enter task",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
      ),
      contentPadding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      actions: [
        IconButton(
            onPressed: () {
              todoBloc.add(AddingTaskEvent(controller.value.text));
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.send,
              color: Colors.black,
            ))
      ],
      actionsPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
    );
  }
}
