import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mindmap2/model/note.dart';
import 'package:mindmap2/note_card.dart';
import 'package:mindmap2/provider/note_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mindmap2/widget/note_detail_overlay.dart';
import 'package:provider/provider.dart';

class NotesGrid extends StatelessWidget {

  final List<NoteCard> noteList;
  const NotesGrid({super.key, required this.noteList});



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: noteList,
        ),
      ],
    );
  }
}
