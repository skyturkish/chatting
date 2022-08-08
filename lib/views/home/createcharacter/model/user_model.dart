import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:groupnotes/core/constants/cloudFireStore/cloud_fire_store_constants.dart';

@immutable
class UserModel {
  final String documentId;
  final String ownerUsedId;
  final String name;
  final String surName;
  final List<dynamic> groupNames; // dynami olmayınca saçma bir hata geliyor, fixle onu
  final bool gender;
  const UserModel({
    required this.documentId,
    required this.ownerUsedId,
    required this.name,
    required this.surName,
    required this.groupNames,
    required this.gender,
  });
  UserModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUsedId = snapshot[FirestoreDatabaseTextFields.ownerUserIdFieldName],
        name = snapshot['name'] as String,
        surName = snapshot['surName'] as String,
        groupNames = snapshot['groupNames'] as List<dynamic>,
        gender = snapshot['gender'] as bool;
}
