import 'package:flutter/material.dart';
import 'package:fashon_app/utils/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/main/main_wrapper.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: const MainWrapper(),
    );
  }
}
