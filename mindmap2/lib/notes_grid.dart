import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mindmap2/widget/note_card_container.dart';

class NotesGrid extends StatelessWidget {

  final List<NoteCardContainer> noteList;
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
