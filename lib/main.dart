import 'package:flutter/material.dart';
import 'package:final_mobile/pages/login.dart';
import 'package:final_mobile/pages/register.dart';
import 'package:final_mobile/pages/listview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const LoginPage(),
        "/listpage": (context) => const ListPage(),
      },
      initialRoute: "/",
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
