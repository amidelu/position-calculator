import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:position_calculator/dashboard.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Position Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      darkTheme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber)),
      themeMode: ThemeMode.system,
      home: const Dashboard(),
    );
  }
}
