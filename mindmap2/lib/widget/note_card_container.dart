import 'package:flutter/material.dart';
import 'package:mindmap2/model/note.dart';
import 'package:mindmap2/note_card.dart';
import 'package:mindmap2/provider/note_provider.dart';
import 'package:mindmap2/widget/edit_note_modal_widget.dart';


class NoteCardContainer extends StatelessWidget {
  final Note note;
  final NoteProvider noteProvider;

  NoteCardContainer({required this.note, required this.noteProvider});

  void _showEditModel(BuildContext context, Note note) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return EditNoteModal(note: note);
        });
  }

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Note>(
      data: note,
      feedback: Material(
        elevation: 6.0,
        child: NoteCard(note: note)
      ),
      childWhenDragging: Container(),
      child: DragTarget<Note>(
        onAcceptWithDetails: (draggedNote) {
          print(' set abdorb');
          if (noteProvider.isAbsorbMode && draggedNote != note) {

            print(' set abdorb222');
            noteProvider.absorbNoteAsChild(note.id, draggedNote.data.id);
          }
        },
        builder: (context, candidateData, rejectData) {
          return GestureDetector(
            onTap: () => noteProvider.setSelectedNote(note),
            child: NoteCard(note: note)
          );
      }),
    );
  }
}
