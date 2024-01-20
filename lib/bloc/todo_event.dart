// ignore_for_file: must_be_immutable

part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class TodoInitialEvent extends TodoEvent {}

class AddTaskButtonClickedEvent extends TodoEvent {}

class AddingTaskEvent extends TodoEvent {
  String taskDescription;
  AddingTaskEvent(this.taskDescription);
}

class EditTaskButtonClickedEvent extends TodoEvent {
  final Task task;
  EditTaskButtonClickedEvent(this.task);
}

class EditingTaskEvent extends TodoEvent {
}

class DeleteTaskButtonClickedEvent extends TodoEvent {
  Task task;
  DeleteTaskButtonClickedEvent(this.task);
}

class TaskDeleteCanceledEvent extends TodoEvent {}

class TaskDeleteValidatedEvent extends TodoEvent {
  Task task;
  TaskDeleteValidatedEvent(this.task);
}

class TaskValidationButtonClickedEvent extends TodoEvent {
  Task task;
  TaskValidationButtonClickedEvent(this.task);
}
