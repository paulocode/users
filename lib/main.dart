import 'package:flutter/material.dart';

import 'screens/home_page_screen.dart';
import 'theme.dart';

void main() {
  //Bloc.observer = const SimpleBlocObserver();
  runApp(const UsersApp());
}

class UsersApp extends StatelessWidget {
  const UsersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users',
      theme: theme,
      darkTheme: darkTheme,
      home: const HomePageScreen(),
    );
  }
}
