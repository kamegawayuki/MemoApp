import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mindmap2/model/note.dart';
import 'package:mindmap2/provider/note_provider.dart';
import 'package:mindmap2/widget/child_note_card.dart';
import 'package:mindmap2/widget/edit_note_modal_widget.dart';
import 'package:provider/provider.dart';

class NoteDetailOverlay extends StatelessWidget {
  final Note note;
  final List<ChildNoteCard> childNoteCardList;
  const NoteDetailOverlay({super.key,required this.note, required this.childNoteCardList});



  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              note.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8, child: Container(color: Colors.yellow)),
            Expanded(
              child: SingleChildScrollView(
                child: Text(note.content),
              ),
            ),
            SizedBox(height: 16, child: Container(color: Colors.yellow)),
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: childNoteCardList,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => EditNoteModal(note: note),
                    );
                  },
                  child: Text('Edit')
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<NoteProvider>(context, listen:false).clearSelectedNote();
              },
              child: Text('Close'))
          ],
        )
      )
    );
  }
}
