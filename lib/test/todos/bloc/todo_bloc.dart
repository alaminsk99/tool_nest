


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tool_nest/test/todos/bloc/todo_event.dart';
import 'package:tool_nest/test/todos/bloc/todo_state.dart';

import '../models/todo_model.dart';




class TodoBloc extends Bloc<TodoEvent,TodoState>{
  TodoBloc():super(TodoState([])){
    on<AddTodo>((event,emit){
      final newTodo = Todo(id: DateTime.now().toString(), title: event.title);
      emit(TodoState([...state.todos,newTodo]));

    });

    on<ToggleTodo>((event,emit){
      final update = state.todos.map((todo){
        return todo.id == event.id ? todo.copyWith(isDone: !todo.isDone) : todo;
      }).toList();
      emit(TodoState(update));

    });


    on<DeleteTodo>((event, emit) {
      final updated = state.todos.where((todo) => todo.id != event.id).toList();
      emit(TodoState(updated));
    });
  }
}