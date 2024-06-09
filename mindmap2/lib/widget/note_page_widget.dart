import 'package:flutter/material.dart';
import 'package:mindmap2/model/note.dart';
import 'package:mindmap2/notes_grid.dart';
import 'package:mindmap2/provider/note_provider.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}


class _NotesPageState extends State<NotesPage>{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<NoteProvider>(context, listen: false).fetchNotes();
    });
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void _addNote (BuildContext context) {
    final title = titleController.text;
    final content = contentController.text;
    if (title.isNotEmpty && content.isNotEmpty) {
      final newNote = Note(
        id:DateTime.now().toString(),
        title: title,
        content: content,
      );

      Provider.of<NoteProvider>(context, listen: false).addNoteToFirebase(newNote);

      titleController.clear();
      contentController.clear();
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('tektoApp'),
      ),
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Content'),
              ),
            ),
            ElevatedButton(
              onPressed: () => _addNote(context),
              child: Text('Add Note'),
            ),
            const Expanded(
              child: NotesGrid()
            )
          ]


      ),

    );
  }



}