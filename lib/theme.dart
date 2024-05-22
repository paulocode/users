import 'package:flutter/material.dart';

const seedColor = Color(0x007fcf60);

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
  useMaterial3: true,
);

final darkTheme = ThemeData(
  colorScheme:
      ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark),
  useMaterial3: true,
);
