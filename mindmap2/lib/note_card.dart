import 'package:flutter/material.dart';
import 'package:mindmap2/provider/note_provider.dart';

import 'model/note.dart';
import 'widget/edit_note_modal_widget.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final NoteProvider noteProvider;

  NoteCard({required this.note, required this.noteProvider});

  void _showEditModel(BuildContext context, Note note){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return EditNoteModal(note: note);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => noteProvider.setSelectedNote(note),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note.title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(note.content)
              ],
          )
        )
      ),
    );
  }
}
