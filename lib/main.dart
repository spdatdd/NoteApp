import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_manager.dart';
import 'note_home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteManager(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NoteApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NoteHome(),
      ),
    );
  }
}
