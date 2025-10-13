import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import '../service/api_service.dart';
import '../model/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ApiService apiService;

  TodoBloc(this.apiService) : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await apiService.fetchTodos();
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  // void _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
  //   final newTodo = Todo(id: DateTime.now().millisecondsSinceEpoch, title: event.title);
  //   await apiService.addTodo(newTodo);
  //   add(LoadTodos());
  // }
  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentTodos = (state as TodoLoaded).todos;
      final newTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: event.title,
      );
      final updatedTodos = List<Todo>.from(currentTodos)..add(newTodo);
      emit(TodoLoaded(updatedTodos));
    }
  }

  // void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
  //   await apiService.deleteTodo(event.id);
  //   add(LoadTodos());
  // }
  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
  if (state is TodoLoaded) {
    final currentTodos = (state as TodoLoaded).todos;
    final updatedTodos = currentTodos.where((todo) => todo.id != event.id).toList();
    emit(TodoLoaded(updatedTodos));
  }
}

}
