import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projectone/providers/product_provider.dart';
import 'package:projectone/screens/home_screen.dart';
import 'package:projectone/core/app_theme.dart';  

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Store',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,        
      home: const HomeScreen(),
    );
  }
}