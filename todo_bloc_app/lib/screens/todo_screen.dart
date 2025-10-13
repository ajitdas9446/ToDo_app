import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(LoadTodos());

    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('TODO App - BLoC + Dio')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) return const Center(child: CircularProgressIndicator());
          if (state is TodoError) return Center(child: Text(state.message));
          if (state is TodoLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => context.read<TodoBloc>().add(DeleteTodo(todo.id)),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(controller: controller, decoration: const InputDecoration(hintText: 'New Task')),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            context.read<TodoBloc>().add(AddTodo(controller.text));
                            controller.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
