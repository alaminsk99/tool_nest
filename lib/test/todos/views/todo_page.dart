import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../filter/filter_bloc.dart';
import '../filter/filter_event.dart';
import '../filter/filter_state.dart';
import '../models/todo_model.dart';


class TodoPage extends StatefulWidget {
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();

  List<Todo> _filterTodos(List<Todo> todos, FilterType filter) {
    switch (filter) {
      case FilterType.completed:
        return todos.where((t) => t.isDone).toList();
      case FilterType.active:
        return todos.where((t) => !t.isDone).toList();
      case FilterType.all:
      default:
        return todos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('📝 Todo List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add a new task...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      context.read<TodoBloc>().add(AddTodo(text));
                      _controller.clear();
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Filter Buttons
            BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: FilterType.values.map((filter) {
                    final isSelected = state.filter == filter;
                    return ChoiceChip(
                      label: Text(filter.name.toUpperCase()),
                      selected: isSelected,
                      onSelected: (_) {
                        context.read<FilterBloc>().add(ChangeFilter(filter));
                      },
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 20),

            // Todo List
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, todoState) {
                  return BlocBuilder<FilterBloc, FilterState>(
                    builder: (context, filterState) {
                      final filteredTodos =
                      _filterTodos(todoState.todos, filterState.filter);
                      return ListView.builder(
                        itemCount: filteredTodos.length,
                        itemBuilder: (_, index) {
                          final todo = filteredTodos[index];
                          return ListTile(
                            leading: Checkbox(
                              value: todo.isDone,
                              onChanged: (_) {
                                context
                                    .read<TodoBloc>()
                                    .add(ToggleTodo(todo.id));
                              },
                            ),
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                decoration: todo.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                context.read<TodoBloc>().add(DeleteTodo(todo.id));
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
