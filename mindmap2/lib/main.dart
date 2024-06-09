import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mindmap2/firebase_options.dart';
import 'package:mindmap2/provider/note_provider.dart';
import 'package:mindmap2/widget/note_page_widget.dart';
import 'package:provider/provider.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: MaterialApp(
        home: NotesPage()
      ),
    );
  }
}



