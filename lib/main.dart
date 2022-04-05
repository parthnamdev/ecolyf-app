import 'package:flutter/material.dart';

import 'screens/wrapper.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
    );
  }
}
