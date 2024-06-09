import 'package:flutter/material.dart';
import 'package:mindmap2/model/note.dart';
import 'package:mindmap2/provider/note_provider.dart';
import 'package:provider/provider.dart';

class EditNoteModal extends StatefulWidget {
  final Note note;

  const EditNoteModal({super.key, required this.note});

  @override
  State<EditNoteModal> createState() => _EditNoteModalState();
}

class _EditNoteModalState extends State<EditNoteModal> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState () {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote (){
    final updateNote = Note(
      id: widget.note.id,
      title: _titleController.text,
      content: _contentController.text
    );

    Provider.of<NoteProvider>(context, listen: false).updateNoteInFirebase(updateNote);
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Context')
          ),
          SizedBox(height:8),
          TextField(
            controller: _contentController,
            decoration: InputDecoration(labelText: 'Content'),
            maxLines: 5,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _saveNote,
            child: Text('Save')
          )

        ],
      )
    );
  }
}
