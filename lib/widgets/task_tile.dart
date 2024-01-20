import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/model/task_model.dart';

class TaskTile extends StatelessWidget {
  final TodoBloc todoBloc;
  final Task task;
  const TaskTile({super.key, required this.task, required this.todoBloc});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(0),
          tileColor: Colors.grey[50],
          title: Text(
            task.description,
            style:  TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                decoration: task.isDone==true ? TextDecoration.lineThrough:TextDecoration.none),
          ),
          leading: IconButton(
            onPressed: () {
              todoBloc.add(TaskValidationButtonClickedEvent(task));
            },
            icon: const Icon(
              Icons.done,
              color: Colors.green,
            ),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    todoBloc.add(EditTaskButtonClickedEvent(task));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blueAccent,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    todoBloc.add(DeleteTaskButtonClickedEvent(task));
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
