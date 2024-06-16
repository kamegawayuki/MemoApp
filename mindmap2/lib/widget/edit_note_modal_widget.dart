import 'package:flutter/material.dart';
import 'package:mindmap2/model/note.dart';
import 'package:mindmap2/provider/note_provider.dart';
import 'package:provider/provider.dart';

class EditNoteModal extends StatelessWidget {
  final Note note;
  final TextEditingController titleController;
  final TextEditingController contentController;

  EditNoteModal({super.key, required this.note})
    : titleController =  TextEditingController(text: note.title),
      contentController = TextEditingController(text: note.content);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit NOte'),
      content: SingleChildScrollView(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: null,

            )
          ],
        )
      ),
      actions: [
        TextButton(
          onPressed: () {
            print(context);
            Navigator.of(context).pop();
          },
          child: Text('Cancel')
        ),
        ElevatedButton(
          onPressed: () {
            print(context);
            note.title = titleController.text;
            note.content = contentController.text;
            Provider.of<NoteProvider>(context, listen: false).updateNoteInFirebase(note);
            Navigator.of(context).pop();
          },
          child: Text('Save')
        )
      ],
    );
  }
}
