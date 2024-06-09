
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mindmap2/model/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];


  List<Note> get notes => _notes;

  noteProvider() {
    fetchNotes();
  }

  Future<void> fetchNotes () async {
    print("Fetching notes...");
    final querySnapshot = await FirebaseFirestore.instance.collection('notes').get();
    _notes = querySnapshot.docs.map((doc) => Note.fromDocument(doc)).toList();
    notifyListeners();
  }

  Future<void> addNoteToFirebase(Note note) async {
    await FirebaseFirestore.instance.collection('notes').add({
      'title': note.title,
      'content': note.content,
    });
    fetchNotes();
  }

  Future<void> updateNoteInFirebase(Note note) async {
    try{
      await FirebaseFirestore.instance.collection('notes').doc(note.id).update({
        'title': note.title,
        'content': note.content,
      });
      fetchNotes();
    } catch (e) {
      print('Error updateing document: $e');
    }
  }

  void addNote (Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeNoteById(String id){
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}