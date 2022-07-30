import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:groupnotes/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudNote {
  final String documentId;
  final String ownerUsedId;
  final String text;
  const CloudNote({
    required this.documentId,
    required this.ownerUsedId,
    required this.text,
  });

  CloudNote.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUsedId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName] as String;
}
