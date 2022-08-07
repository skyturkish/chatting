import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:groupnotes/services/cloud/cloud_storage_constants.dart';

@immutable
class GroupCloudNote {
  final String documentId;
  final String ownerUsedId;
  final String groupName;
  final String text;
  const GroupCloudNote({
    required this.documentId,
    required this.ownerUsedId,
    required this.text,
    required this.groupName,
  });

  GroupCloudNote.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUsedId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName] as String,
        groupName = snapshot.data()[textGroupName] as String;
}
