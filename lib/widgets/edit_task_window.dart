import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/model/task_model.dart';

// ignore: must_be_immutable
class EditTaskWindow extends StatelessWidget {
  Task task;
  TextEditingController controller = TextEditingController();
  TodoBloc todoBloc;
  EditTaskWindow(this.todoBloc, this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Edit Task",
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
              task.description = controller.value.text;
              todoBloc.add(EditingTaskEvent());
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
