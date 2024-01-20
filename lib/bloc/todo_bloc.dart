import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/data/task_data.dart';
import 'package:todo_app/model/task_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitialState()) {
    on<TodoInitialEvent>(todoInitialEvent);
    on<AddTaskButtonClickedEvent>(addTaskButtonClickedEvent);
    on<AddingTaskEvent>(addingTaskEvent);
    on<EditTaskButtonClickedEvent>(editTaskButtonClickedEvent);
    on<EditingTaskEvent>(editingTaskEvent);
    on<DeleteTaskButtonClickedEvent>(deleteTaskButtonClicked);
    on<TaskDeleteValidatedEvent>(taskDeleteValidatedEvent);
    on<TaskDeleteCanceledEvent>(taskDeleteCanceledEvent);
    on<TaskValidationButtonClickedEvent>(taskValidationButtonClickedEvent);
  }
  FutureOr<void> todoInitialEvent(
      TodoInitialEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(TodoListLoadedSuccessfullyState(TaskCollection.taskList));
  }

  FutureOr<void> addTaskButtonClickedEvent(
      AddTaskButtonClickedEvent event, Emitter<TodoState> emit) {
    emit(AddTaskWindowState());
  }

  FutureOr<void> addingTaskEvent(
      AddingTaskEvent event, Emitter<TodoState> emit) {
    TaskCollection.taskList.add(Task(event.taskDescription));
    emit(TodoListLoadedSuccessfullyState(TaskCollection.taskList));
    emit(TaskAddedSuccessfullyState());
  }

  FutureOr<void> editTaskButtonClickedEvent(
      EditTaskButtonClickedEvent event, Emitter<TodoState> emit) {
    emit(EditTaskWindowState(event.task));
  }

  FutureOr<void> deleteTaskButtonClicked(
      DeleteTaskButtonClickedEvent event, Emitter<TodoState> emit) {
    emit(TaskDeleteValidationState(event.task));
  }

  FutureOr<void> taskDeleteValidatedEvent(
      TaskDeleteValidatedEvent event, Emitter<TodoState> emit) {
    TaskCollection.taskList.remove(event.task);
    emit(TodoListLoadedSuccessfullyState(TaskCollection.taskList));
    emit(TaskDeletedSuccessfullyState());
  }

  FutureOr<void> taskDeleteCanceledEvent(
      TaskDeleteCanceledEvent event, Emitter<TodoState> emit) {
    emit(TodoListLoadedSuccessfullyState(TaskCollection.taskList));
  }

  FutureOr<void> taskValidationButtonClickedEvent(
      TaskValidationButtonClickedEvent event, Emitter<TodoState> emit) {
    event.task.isDone = event.task.isDone == true ? false : true;
    emit(TodoListLoadedSuccessfullyState(TaskCollection.taskList));
  }

  FutureOr<void> editingTaskEvent(
      EditingTaskEvent event, Emitter<TodoState> emit) {
    emit(TodoListLoadedSuccessfullyState(TaskCollection.taskList));
    emit(TaskEditedSuccessfullyState());
  }
}
