// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'bloc/todo_bloc.dart';
// import 'service/api_service.dart';
// import 'screens/landing_page.dart';
// import 'screens/todo_screen.dart';
// import 'bloc/todo_event.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TODO BLoC App',
//       debugShowCheckedModeBanner: false,
//       home: BlocProvider(
//         create: (_) => TodoBloc(ApiService())..add(LoadTodos()),
//         child: const TodoScreen(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/todo_bloc.dart';
import 'bloc/todo_event.dart';
import 'service/api_service.dart';
import 'screens/landing_page.dart';

void main() {
  final apiService = ApiService();
  runApp(MyApp(apiService: apiService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;
  const MyApp({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = TodoBloc(apiService);
        bloc.add(LoadTodos());
        return bloc;
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}
