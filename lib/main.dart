import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setu_todo/providors/todo_provider.dart';
import 'package:setu_todo/screens/home_screen.dart';
import 'package:setu_todo/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const Home(),
      ),
    );
  }
}
