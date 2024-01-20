import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/data/task_data.dart';
import 'package:todo_app/widgets/add_task_window.dart';
import 'package:todo_app/widgets/edit_task_window.dart';
import 'package:todo_app/widgets/task_tile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoBloc todoBloc = TodoBloc();
  @override
  void initState() {
    todoBloc.add(TodoInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Your Todo List",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            todoBloc.add(AddTaskButtonClickedEvent());
          },
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: BlocConsumer<TodoBloc, TodoState>(
            bloc: todoBloc,
            listenWhen: (previous, current) => current is TodoActionState,
            buildWhen: (previous, current) => current is! TodoActionState,
            listener: (context, state) {
              if (state is AddTaskWindowState) {
                showDialog(
                  context: context,
                  builder: (context) => AddTaskWindow(todoBloc),
                );
              }
              if (state is TaskAddedSuccessfullyState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "Task added successfuly",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.black,
                ));
              }

              if (state is EditTaskWindowState) {
                showDialog(
                  context: context,
                  builder: (context) => EditTaskWindow(todoBloc, state.task),
                );
              }
              if (state is TaskEditedSuccessfullyState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.black,
                    content: Text("Task edited successfully")));
              }
              if (state is TaskDeleteValidationState) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.rightSlide,
                  title: 'Delete Validation',
                  desc: 'Are you sure you want to delete this task ?',
                  btnCancelOnPress: () {
                    todoBloc.add(TaskDeleteCanceledEvent());
                  },
                  btnCancelColor: Colors.green,
                  btnCancelText: "Cancel",
                  btnOkOnPress: () {
                    todoBloc.add(TaskDeleteValidatedEvent(state.task));
                  },
                  btnOkColor: Colors.red,
                  btnOkText: "Delete",
                ).show();
              }
              if (state is TaskDeletedSuccessfullyState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.black,
                    content: Text("Task Deleted Successfully")));
              }
            },
            builder: (context, state) {
              if (state is TodoLoadingState) {
                return const Scaffold(
                    body: Center(
                        child: CircularProgressIndicator(
                  color: Colors.black,
                )));
              } else if (state is TodoListLoadedSuccessfullyState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: TaskCollection.taskList.length,
                    itemBuilder: (context, index) {
                      return TaskTile(
                        task: TaskCollection.taskList[index],
                        todoBloc: todoBloc,
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
