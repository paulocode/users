import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home_page_screen.dart';
import 'theme.dart';

void main() {
  runApp(const ProviderScope(child: UsersApp()));
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
