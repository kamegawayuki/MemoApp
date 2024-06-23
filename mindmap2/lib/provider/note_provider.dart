
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mindmap2/model/note.dart';
import 'package:mindmap2/model/note_relation.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<NoteRelation> _relations = [];
  Note? _selectedNote;

  bool isAbsorbMode = true;

  List<Note> get notes => _notes;
  Note? get selectedNote => _selectedNote;


  noteProvider() {
    fetchNotesAndRelationsFromFB();
  }

  void setSelectedNote (Note note) {
    print('note Selected');
    _selectedNote = note;
    notifyListeners();
  }

  void clearSelectedNote () {
    _selectedNote = null;
    notifyListeners();
  }

  Future<void> fetchNotesAndRelationsFromFB () async {
    print("Fetching notes...");
    final querySnapshot = await FirebaseFirestore.instance.collection('notes').get();
    _notes = querySnapshot.docs.map((doc) => Note.fromDocument(doc)).toList();

    FirebaseFirestore.instance.collection('note_relations').snapshots().listen((snapshot){
      _relations = snapshot.docs.map((doc) => NoteRelation.fromMap(doc.data())).toList();
    });

    notifyListeners();
  }

  Future<void> addNoteToFirebase(Note note) async {
    await FirebaseFirestore.instance.collection('notes').add(note.toMap());
    notifyListeners();
  }

  Future<void> updateNoteInFirebase(Note note) async {
    try{
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(note.id)
          .update(note.toMap());
      final index = _notes.indexWhere((n) => n.id == note.id);
      if (index != -1) {
        _notes[index] = note;
      }
      notifyListeners();
    } catch (e) {
      print('Error updateing document: $e');
    }
  }

  void updateNotePosition(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Note item = _notes.removeAt(oldIndex);
    _notes.insert(newIndex, item);
    notifyListeners();
  }

  void addRelationToFirebase(NoteRelation relation) {
    FirebaseFirestore.instance.collection('note_relations').add(relation.toMap());
  }

  void removeRelationFromFirebase(String relationId) {
    FirebaseFirestore.instance.collection('note_relations').doc(relationId).delete();
  }

  List<Note> getChildNotes(String parentId) {
    final childIds = _relations.where((r) => r.parentNoteId == parentId).map((r) => r.childNoteId).toList();
    return _notes.where((note) =>childIds.contains(note.id)).toList();
  }

  List<Note> getParentNotes(String childId) {
    final parentIds = _relations.where((r) => r.childNoteId == childId).map((r) => r.parentNoteId).toList();
    return _notes.where((note) => parentIds.contains(note.id)).toList();
  }

  void absorbNoteAsChild(String parentId, String childId) {
    final newRelation = NoteRelation(
      id: FirebaseFirestore.instance.collection('note_relations').doc().id,
      parentNoteId: parentId,
      childNoteId: childId
    );
    addRelationToFirebase(newRelation);
  }

  void removeChildNoteRelation(String parentId, String childId) {
    final relation = _relations.firstWhereOrNull(
        (r)  => r.parentNoteId == parentId && r.childNoteId == childId
    );
    if (relation != null) {
      removeRelationFromFirebase(relation.id);
    }
  }


  void removeNoteById(String id){
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}