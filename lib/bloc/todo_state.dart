part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

class TodoInitialState extends TodoState {}

class TodoActionState extends TodoState {}

class TodoLoadingState extends TodoState {}

class AddTaskWindowState extends TodoActionState {}

class EditTaskWindowState extends TodoActionState {
  final Task task;
  EditTaskWindowState(this.task);
}

class TaskEditedSuccessfullyState extends TodoActionState{}

class TodoListLoadedSuccessfullyState extends TodoState {
  final List<Task> taskList;
  TodoListLoadedSuccessfullyState(this.taskList);
}

class TaskAddedSuccessfullyState extends TodoActionState {}

class TaskDeleteValidationState extends TodoActionState {
  final Task task;
  TaskDeleteValidationState(this.task);
}

class TaskDeletedSuccessfullyState extends TodoActionState {}
