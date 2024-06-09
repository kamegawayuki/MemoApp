import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mindmap2/model/note.dart';
import 'package:mindmap2/note_card.dart';
import 'package:mindmap2/provider/note_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class NotesGrid extends StatelessWidget {

  const NotesGrid({super.key});



  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, noteProvider, child){
        List<NoteCard> noteList = [];
        for (var note in noteProvider.notes) {
          noteList.add(NoteCard(note: note));
        }


        return StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: noteList,
        );
      }
    );
  }
}
