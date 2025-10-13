import 'package:dio/dio.dart';
import '../model/todo.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));

  Future<List<Todo>> fetchTodos() async {
    final response = await _dio.get('/todos?_limit=10');
    return (response.data as List).map((e) => Todo.fromJson(e)).toList();
  }

  Future<void> addTodo(Todo todo) async {
    await _dio.post('/todos', data: todo.toJson());
  }

  Future<void> deleteTodo(int id) async {
    await _dio.delete('/todos/$id');
  }
}
