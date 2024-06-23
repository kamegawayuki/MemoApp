import 'package:flutter/material.dart';
import 'package:mindmap2/model/note.dart';
import 'package:mindmap2/provider/note_provider.dart';

class ChildNoteCard extends StatelessWidget {
  final Note note;
  final NoteProvider noteProvider;
  const ChildNoteCard({super.key,required this.note,required this.noteProvider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        noteProvider.setSelectedNote(note);
      },
      child: Card(
        child: Text(note.title),
      ),

    );
  }
}
