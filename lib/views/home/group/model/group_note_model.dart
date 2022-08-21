import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class GroupNote {
  final String groupName;
  final String ownerUsedId;
  final String documentId;
  final String note;
  GroupNote({
    required this.groupName,
    required this.ownerUsedId,
    required this.documentId,
    required this.note,
  });

  // QueryDocumentSnapshot kısmından alıyoruz ki document Id'yi de alabilelim

  GroupNote.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUsedId = snapshot.data()['ownerUsedId'],
        groupName = snapshot.data()['groupName'],
        note = snapshot.data()['note'] as String;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'groupName': groupName});
    result.addAll({'ownerUsedId': ownerUsedId});
    result.addAll({'documentId': documentId});
    result.addAll({'note': note});

    return result;
  }

  factory GroupNote.fromMap(Map<String, dynamic> map) {
    return GroupNote(
      groupName: map['groupName'] ?? '',
      ownerUsedId: map['ownerUsedId'] ?? '',
      documentId: map['documentId'] ?? '',
      note: map['note'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupNote.fromJson(String source) => GroupNote.fromMap(json.decode(source));
}
