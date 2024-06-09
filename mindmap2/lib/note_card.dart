import 'package:flutter/material.dart';

import 'model/note.dart';
import 'widget/edit_note_modal_widget.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  NoteCard({required this.note});

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
      onTap: () =>_showEditModel(context, note),
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
