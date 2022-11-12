import 'package:flutter/material.dart';
import 'package:note_app/add_note.dart';
import 'package:note_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sqlflite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const Home()) ,
      routes: {
        "addnotes" : (context) => const AddNotes(),
      },
    );
  }
}
