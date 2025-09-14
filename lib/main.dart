import "package:flutter/material.dart";
import "package:size_on_folder/home.dart";

void main() {
  runApp(const MyApp());
}

///Main skelethon of the app
class MyApp extends StatelessWidget {
  ///
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const Home(),
    );
  }
}
