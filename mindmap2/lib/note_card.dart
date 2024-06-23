import 'package:flutter/material.dart';
import 'package:mindmap2/provider/note_provider.dart';

import 'model/note.dart';
import 'widget/edit_note_modal_widget.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  NoteCard({required this.note});


  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
