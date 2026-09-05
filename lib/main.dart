import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_c19/data/hive_adapters/source_dm_adapter.dart';
import 'package:news_c19/ui/screens/splash/splash_screen.dart';
import 'package:news_c19/ui/utils/app_theme.dart';

void main() async {
  Hive.initFlutter();
  Hive.registerAdapter(SourceDMAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
