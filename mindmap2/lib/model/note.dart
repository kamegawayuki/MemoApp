import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String title;
  String content;

  Note ({
    required this.id,
    required this.title,
    required this.content
  });

  factory Note.fromDocument(DocumentSnapshot doc){
    return Note(
      id: doc.id,
      title: doc['title'],
      content: doc['content']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

}

